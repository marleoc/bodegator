import 'package:flutter/material.dart';

import 'package:bodegator/widgets/button_order.dart';

class HomeHeaderButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: 25.0
      ),
      child: Row(
        children: <Widget>[
          new ButtonOrder(),
          new ButtonOrder(),
        ],
      ),
    );
  }
}