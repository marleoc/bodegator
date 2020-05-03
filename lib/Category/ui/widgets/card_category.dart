import 'package:flutter/material.dart';

import 'package:bodegator/util.dart';

class CardCategory extends StatefulWidget {

  String pathImage = '';
  String name = '';

  CardCategory(this.name, this.pathImage);

  @override
  State<StatefulWidget> createState() {
    return _CardCategory();
  }
}

class _CardCategory extends State<CardCategory> {
  @override
  Widget build(BuildContext context) {

    final containerCard = Container(
      height: 75.0,
      width: 75.0,
      margin: EdgeInsets.only(
        bottom: 10.0,
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(widget.pathImage)
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          shape: BoxShape.rectangle,
      ),
    );

    final containerText = Container(
      child: Text(
        widget.name,
        style: TextStyle(
            fontSize: 15.0,
            color: colorPrimaryText,
            fontFamily: fontLato
        ),
      ),
    );

    return Container(
      child: new InkWell(
        onTap: onPressedButton,
        child: Column(
          children: <Widget>[
            containerCard,
            containerText
          ],
        ),
      ),
    );
  }

  void onPressedButton() {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('listado de categoría'),
    ));
  }
}
