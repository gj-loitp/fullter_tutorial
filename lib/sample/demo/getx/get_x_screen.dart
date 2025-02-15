import 'package:com.roy93group.flutter_tutorial/lib/common/const/dimen_constants.dart';
import 'package:com.roy93group.flutter_tutorial/lib/util/log_dog_utils.dart';
import 'package:com.roy93group.flutter_tutorial/lib/util/ui_utils.dart';
import 'package:com.roy93group.flutter_tutorial/lib/util/url_launcher_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'second_screen.dart';

/**
 * Created by Loitp on 08,August,2022
 * Galaxy One company,
 * Vietnam
 * +840766040293
 * freuss47@gmail.com
 */
class GetXScreen extends GetWidget with WidgetsBindingObserver {
  final Controller _controller = Get.put(Controller());

  Widget _testListen() {
    Dog.d("==============testListen " + _controller.text.value);
    return Obx(() {
      Dog.d(">>>>>>>testListen count " + _controller.count.value.toString());
      Dog.d(">>>>>>>testListen text " + _controller.text.value);
      return Text(_controller.text.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    _testListen();
    return Scaffold(
      appBar: UIUtils.getAppBar(
        "get",
        () => {
          Get.back(),
        },
        () {
          UrlLauncherUtils.launchInWebViewWithJavaScript(
              "https://pub.dev/packages/get");
        },
      ),
      body: Container(
        padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => UIUtils.getText("${_controller.count}")),
            UIUtils.getButton("Next Screen", () => Get.to(SecondScreen())),
            _testListen(),
            UIUtils.getButton("Set count = 69", () {
              _controller.setCount(69);
            }),
            UIUtils.getButton("Pop this screen and reset all value", () {
              _controller.clearAllValue();
              Get.back();
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.add),
        onPressed: () => {
          _controller.increment(),
          _controller
              .updateText(DateTime.now().millisecondsSinceEpoch.toString()),
        },
      ),
    );
  }
}
