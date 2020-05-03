import 'package:flutter/material.dart';

import 'package:bodegator/util.dart';

class HomeAddress extends StatefulWidget {

  String address = '';

  HomeAddress(this.address);

  @override
  State<StatefulWidget> createState() {
    return _HomeAddress();
  }
}

class _HomeAddress extends State<HomeAddress> {
  @override
  Widget build(BuildContext context) {

    final containerAddress = Container(
      margin: EdgeInsets.only(
        top: 10.0,
      ),
      child: Row(
        children: <Widget>[
          Text(
            widget.address,
            style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: colorPrimaryText,
                fontFamily: fontLato
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            size: sizeIcon,
            color: colorPrimaryText,
          )
        ],
      ),
    );

    return Container(
      child: new InkWell(
        onTap: onPressedButton,
        child: containerAddress,
      ),
    );
  }

  void onPressedButton() {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('ver dirección'),
    ));
  }
}