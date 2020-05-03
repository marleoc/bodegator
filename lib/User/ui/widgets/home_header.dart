import 'package:flutter/material.dart';

import 'package:bodegator/User/ui/widgets/home_header_name.dart';
import 'package:bodegator/User/ui/widgets/home_header_buttons.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new HomeHeaderName('Luis', 'Alfa Centauro 185', 'assets/img/people.jpg'),
          new HomeHeaderButtons()
        ],
      ),
    );
  }
}