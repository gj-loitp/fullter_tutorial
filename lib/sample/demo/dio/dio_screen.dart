import 'package:com.roy93group.flutter_tutorial/lib/common/const/dimen_constants.dart';
import 'package:com.roy93group.flutter_tutorial/lib/core/base_stateful_state.dart';
import 'package:com.roy93group.flutter_tutorial/lib/util/ui_utils.dart';
import 'package:com.roy93group.flutter_tutorial/lib/util/url_launcher_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:get/get.dart';

/**
 * Created by Loitp on 08,August,2022
 * Galaxy One company,
 * Vietnam
 * +840766040293
 * freuss47@gmail.com
 */
class DioScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DioScreenState();
  }
}

class _DioScreenState extends BaseStatefulState<DioScreen> {
  String _response = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIUtils.getAppBar(
        "dio",
        () {
          Get.back();
        },
        () {
          UrlLauncherUtils.launchInWebViewWithJavaScript(
              "https://pub.dev/packages/dio");
        },
      ),
      body: ListView(
        padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
        physics: BouncingScrollPhysics(),
        children: [
          UIUtils.getText(
              "A powerful Http client for Dart, which supports Interceptors, Global configuration, FormData, Request Cancellation, File downloading, Timeout etc."),
          UIUtils.getButton("Get Google", () {
            _getHttp();
          }),
          UIUtils.getText(_response),
          //TODO loitpp https://pub.dev/packages/web_scraper
        ],
      ),
    );
  }

  void _getHttp() async {
    try {
      Dio dio = Dio();
      var response = await dio.get('http://www.thichtruyen.vn');
      // var response = await Dio().get('https://drive.google.com/uc?export=download&id=1bjIaEuvDJhrdlP__LNEf43__pkEVV75D');

      if (kDebugMode) {
        dio.interceptors.add(
          PrettyDioLogger(
            requestHeader: true,
            queryParameters: true,
            requestBody: true,
            responseHeader: true,
            responseBody: true,
            error: true,
            showProcessingTime: true,
            showCUrl: true,
            canShowLog: kDebugMode,
            convertFormData: true,
          ),
        );
      }

      print(response);
      setState(() {
        _response = response.data;
      });
    } catch (e) {
      print(e);
    }
  }
}
