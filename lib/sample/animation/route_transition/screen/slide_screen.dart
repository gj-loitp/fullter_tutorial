import 'package:com.roy93group.flutter_tutorial/lib/common/const/dimen_constants.dart';
import 'package:com.roy93group.flutter_tutorial/lib/util/ui_utils.dart';
import 'package:flutter/material.dart';

import '../../../../lib/animation/route_transition/slide_route.dart';
import '../route_transition_screen.dart';

/**
 * Created by Loitp on 05,August,2022
 * Galaxy One company,
 * Vietnam
 * +840766040293
 * freuss47@gmail.com
 */
class SlideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            UIUtils.getButton("SlideRightTransition", () {
              Navigator.push(context, SlideRightRoute(page: Screen2()));
            }),
            UIUtils.getButton("SlideLeftTransition", () {
              Navigator.push(context, SlideLeftRoute(page: Screen2()));
            }),
            UIUtils.getButton("SlideTopTransition", () {
              Navigator.push(context, SlideTopRoute(page: Screen2()));
            }),
            UIUtils.getButton("SlideBottomTransition", () {
              Navigator.push(context, SlideBottomRoute(page: Screen2()));
            }),
          ],
        ),
      ),
    );
  }
}
