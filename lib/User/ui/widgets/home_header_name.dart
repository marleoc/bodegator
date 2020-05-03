import 'package:flutter/material.dart';

import 'package:bodegator/util.dart';

class HomeHeaderName extends StatelessWidget {

  String pathImage = '';
  String name = '';
  String address = '';

  HomeHeaderName(this.name, this.address, this.pathImage);

  @override
  Widget build(BuildContext context) {
    final containerHello = Container(
      child: Text(
        'Hola ',
        style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: colorPrimaryText,
            fontFamily: fontLato
        ),
      ),
    );

    final containerName = Container(
      child: Text(
        this.name,
        style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: colorSecondaryText,
            fontFamily: fontLato
        ),
      ),
    );

    final containerPhoto = Container (
      width: 45.0,
      height: 45.0,
      margin: EdgeInsets.only(
        right: 15.0,
        top: 15.0
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(this.pathImage)
          )
      ),
    );

    final containerAddress = Container(
      margin: EdgeInsets.only(
        top: 10.0,
      ),
      child: Row(
        children: <Widget>[
          Text(
            this.address,
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

    final rowNameUser = Row(
      children: <Widget>[
        containerHello,
        containerName
      ],
    );

    final columnNameAddressUser = Container(
      margin: EdgeInsets.only(
        top: 25.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          rowNameUser,
          containerAddress
        ],
      ),
    );

    return Container(
      child: Row(
        children: <Widget>[
          containerPhoto,
          columnNameAddressUser
        ],
      ),
    );
  }
}