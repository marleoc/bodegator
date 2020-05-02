import 'package:flutter/material.dart';
import 'package:flutter_app/services/authservice.dart';


class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Salir'),
          onPressed: () {
            AuthService().signOut();
          },
        )
      )
    );
  }
}