import 'package:flutter/material.dart';

import 'package:bodegator/util.dart';
import 'package:bodegator/User/ui/widgets/home_photo.dart';
import 'package:bodegator/User/ui/widgets/home_address.dart';

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
          new HomeAddress(this.address)
        ],
      ),
    );

    return Container(
      child: Row(
        children: <Widget>[
          new HomePhoto(this.pathImage),
          columnNameAddressUser
        ],
      ),
    );
  }
}