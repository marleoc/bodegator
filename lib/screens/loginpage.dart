import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/authservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  List<Item> users = <Item>[
    const Item('+51',Icon(Icons.map,color:  Colors.red,)),
  ];
  String phoneNo, verificationId, smsCode;
  Item selectedUser;
  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                //ROW 1
                children: [
                  Container(
                    margin: EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                  Container(
                      child: Text(
                          'Atrás'
                      )
                  )
                ],
              ),
              SizedBox(height: 5.0),
              Row(//ROW 3
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 25.0, right: 0, top: 10),
                        child: Column(
                        children: <Widget>[
                            DropdownButton<Item>(
                            hint:  Text("País"),
                            value: selectedUser,
                            //isExpanded: true,
                            onChanged: (Item value) {
                              setState(() {
                                selectedUser = value;
                              });
                            },
                            items: users.map((Item user) {
                              return  DropdownMenuItem<Item>(
                                value: user,
                                child: Row(
                                  children: <Widget>[
                                    user.icon,
                                    SizedBox(width: 10,),
                                    Text(
                                      user.name,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ]
                    )),
                    new Flexible(
                      child: new Padding(
                          padding: EdgeInsets.only(left: 5.0, right: 25.0),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(hintText: 'Ingrese número de teléfono'),
                            onChanged: (val) {
                              setState(() {
                                this.phoneNo = val;
                              });
                            },
                          )                      ),
                    )
                  ]
              ),
                  codeSent ? Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(hintText: 'Ingrese código de verificación'),
                        onChanged: (val) {
                          setState(() {
                            this.smsCode = val;
                          });
                        },
                      )) : Container(),
              SizedBox(height: 25.0),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: RaisedButton(
                    child: Center(child: codeSent ? Text('Verificar'):Text('Recibir código por SMS')),
                    onPressed: () {
                        codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                      },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      textColor: Colors.white,
                    splashColor: Colors.deepOrange,
                      color: Colors.orange
                  ))
            ],
          )),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: selectedUser.name.toString() + phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}