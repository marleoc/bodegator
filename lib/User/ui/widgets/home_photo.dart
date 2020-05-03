import 'package:flutter/material.dart';

class HomePhoto extends StatefulWidget {

  String pathImage = '';

  HomePhoto(this.pathImage);

  @override
  State<StatefulWidget> createState() {
    return _HomePhoto();
  }
}

class _HomePhoto extends State<HomePhoto> {
  @override
  Widget build(BuildContext context) {

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
              image: AssetImage(widget.pathImage)
          )
      ),
    );

    return Container(
      child: new InkWell(
        onTap: onPressedButton,
        child: containerPhoto,
      ),
    );
  }

  void onPressedButton() {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('ver perfil'),
    ));
  }
}