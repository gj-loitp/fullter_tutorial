import 'package:flutter/material.dart';
import 'package:com.roy93group.flutter_tutorial/sample/widget/slider/flutter_slidable/home_item.dart';

/**
 * Created by Loitp on 08,August,2022
 * Galaxy One company,
 * Vietnam
 * +840766040293
 * freuss47@gmail.com
 */
class HorizontalListItem extends StatelessWidget {
  HorizontalListItem(this.item);

  final HomeItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 160.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: CircleAvatar(
              backgroundColor: item.color,
              child: Text('${item.index}'),
              foregroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                item.subtitle!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
