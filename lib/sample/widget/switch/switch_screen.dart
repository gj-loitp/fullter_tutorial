import 'package:com.roy93group.flutter_tutorial/lib/common/const/dimen_constants.dart';
import 'package:com.roy93group.flutter_tutorial/lib/util/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
 * Created by Loitp on 08,August,2022
 * Galaxy One company,
 * Vietnam
 * +840766040293
 * freuss47@gmail.com
 */
class SwitchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIUtils.getAppBar(
        "SwitchScreen",
        () {
          Get.back();
        },
        null,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SwitchWidget(),
            SizedBox(height: 50),
            SizedBox(
              height: 300,
              child: SwitchListTileWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class SwitchWidget extends StatefulWidget {
  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isCheck,
      onChanged: (value) {
        print("_SwitchWidgetState value " + value.toString());
        this.setState(() => isCheck = value);
      },
    );
  }
}

class SwitchListTileWidget extends StatefulWidget {
  @override
  _SwitchListTileWidgetState createState() => _SwitchListTileWidgetState();
}

class _SwitchListTileWidgetState extends State<SwitchListTileWidget> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SwitchListTile(
          title: Text('Title'),
          subtitle: Text('Subtitle'),
          secondary: Icon(Icons.pages),
          value: isCheck,
          onChanged: (value) {
            setState(() => isCheck = value);
          },
        ),
        SwitchListTile(
          title: Text('Title'),
          subtitle: Text('Subtitle'),
          secondary: Icon(Icons.pages),
          value: isCheck,
          onChanged: (value) {
            setState(() => isCheck = value);
          },
        ),
        SwitchListTile(
          title: Text('Title'),
          subtitle: Text('Subtitle'),
          secondary: Icon(Icons.pages),
          value: isCheck,
          onChanged: (value) {
            setState(() => isCheck = value);
          },
        ),
      ],
    );
  }
}
