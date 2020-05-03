import 'package:flutter/material.dart';

import 'package:bodegator/util.dart';

class ButtonOrder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ButtonOrder();
  }
}

class _ButtonOrder extends State<ButtonOrder> {
  @override
  Widget build(BuildContext context) {

    final containerButton = Container (
        child: FloatingActionButton(
          backgroundColor: backgroundButton,
          onPressed: onPressedButton,
          child: Icon(
            Icons.shopping_basket,
            size: sizeIcon,
            color: colorIcon,
          ),
        )
    );

    return Container(
      height: 35,
      width: 35,
      margin: EdgeInsets.only(
          left: 15.0
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: customShadow,
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: containerButton,
          )
        ],
      ),
    );
  }

  void onPressedButton() {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('listado de cotizaciones'),
    ));
  }
}