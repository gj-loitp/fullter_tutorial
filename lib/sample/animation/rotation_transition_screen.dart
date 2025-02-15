import 'package:com.roy93group.flutter_tutorial/lib/common/const/dimen_constants.dart';
import 'package:com.roy93group.flutter_tutorial/lib/util/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
 * Created by Loitp on 05,August,2022
 * Galaxy One company,
 * Vietnam
 * +840766040293
 * freuss47@gmail.com
 */
class RotationTransitionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIUtils.getAppBar(
        "RotationTransitionScreen",
        () => Get.back(),
        null,
      ),
      body: Container(
        padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
        child: RotationTransitionWidget(),
      ),
    );
  }
}

class RotationTransitionWidget extends StatefulWidget {
  @override
  _RotationTransitionWidgetState createState() =>
      _RotationTransitionWidgetState();
}

class _RotationTransitionWidgetState extends State<RotationTransitionWidget>
    with SingleTickerProviderStateMixin {
  final Tween<double> turnsTween = Tween<double>(
    begin: 1,
    end: 3,
  );
  late AnimationController controller;
  bool status = true;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RotationTransition(
          turns: turnsTween.animate(controller),
          child: Container(
            color: Colors.purple[300],
            width: 200,
            height: 200,
            padding: EdgeInsets.all(20),
            child: FlutterLogo(),
          ),
        ),
        UIUtils.getButton("Change Rotation", () {
          status ? controller.forward() : controller.reverse();
          status = !status;
        }),
      ],
    );
  }
}
