import 'package:com.roy93group.flutter_tutorial/lib/common/const/dimen_constants.dart';
import 'package:com.roy93group.flutter_tutorial/lib/core/base_stateful_state.dart';
import 'package:com.roy93group.flutter_tutorial/lib/util/ui_utils.dart';
import 'package:com.roy93group.flutter_tutorial/lib/util/url_launcher_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

/**
 * Created by Loitp on 05,August,2022
 * Galaxy One company,
 * Vietnam
 * +840766040293
 * freuss47@gmail.com
 */
class HtmlScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HtmlScreenState();
  }
}

class _HtmlScreenState extends BaseStatefulState<HtmlScreen> {
  var document = "";

  @override
  void initState() {
    super.initState();

    var _s = '<body>Hello world! <a href="www.html5rocks.com">HTML5 rocks!';
    var _document = parse(_s);
    print(_document.outerHtml);
    setState(() {
      document = "$_s \n=>\n ${_document.outerHtml}";
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIUtils.getAppBar(
        "html",
        () {
          Get.back();
        },
        () {
          UrlLauncherUtils.launchInWebViewWithJavaScript(
              "https://pub.dev/packages/html");
        },
      ),
      body: ListView(
        padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
        physics: BouncingScrollPhysics(),
        children: [
          UIUtils.getText(document),
        ],
      ),
    );
  }
}
