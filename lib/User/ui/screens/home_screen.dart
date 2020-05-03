import 'package:flutter/material.dart';

import 'package:bodegator/util.dart';
import 'package:bodegator/User/ui/widgets/home_header.dart';
import 'package:bodegator/Category/ui/widgets/card_category.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundApp,
        body: Container(
          padding: EdgeInsets.only(
              top: 10.0,
              left: 20.0,
              right: 20.0
          ),
          child: Column(
            children: <Widget>[
              new HomeHeader(),
              new CardCategory('Lo Que Sea', 'assets/img/people.jpg')
            ],
          )
        )
    );
  }
}