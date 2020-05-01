import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
//import 'package:firebase_auth/firebase_auth.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi app',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Bodegator'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  AppLifecycleState _lastLifecycleState;
  final phoneNumController = TextEditingController();



  @override
  void dispose() {
    phoneNumController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lastLifecycleState = state;
    });
  }

  bool _isLoggedIn = false;
  Map userProfile;
  String _typeRegister = '';
  Item selectedUser;
  String _smsVerificationCode;
  final facebookLogin = FacebookLogin();

  List<Item> users = <Item>[
    const Item('+51',Icon(Icons.map,color:  Colors.red,)),
  ];

  _loginWithMobile() {
    setState(() {
      _typeRegister = 'Mobile';
      //selectedUser = const Item('+51',Icon(Icons.map,color:  Colors.red,));
    });
  }

  _registerMobile(BuildContext context) async {
    String phoneNumber = "+1" + phoneNumController.text.toString();
    /*final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 5),
        verificationCompleted: (authCredential) => _verificationComplete(authCredential, context),
        verificationFailed: (authException) => _verificationFailed(authException, context),
        codeAutoRetrievalTimeout: (verificationId) => _codeAutoRetrievalTimeout(verificationId),
        // called when the SMS code is sent
        codeSent: (verificationId, [code]) => _smsCodeSent(verificationId, [code]));*/
  }

  /// will get an AuthCredential object that will help with logging into Firebase.
/*  _verificationComplete(AuthCredential authCredential, BuildContext context) {
    FirebaseAuth.instance.signInWithCredential(authCredential).then((authResult) {
      var user = authResult.user.uid;
      final snackBar = SnackBar(content: Text("Success!!! UUID is: " + user));
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  _smsCodeSent(String verificationId, List<int> code) {
    // set the verification code so that we can use it to log the user in
    _smsVerificationCode = verificationId;
  }

  _verificationFailed(AuthException authException, BuildContext context) {
    final snackBar = SnackBar(content: Text("Exception!! message:" + authException.message.toString()));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    // set the verification code so that we can use it to log the user in
    _smsVerificationCode = verificationId;
  }*/

  _loginWithFB() async{

    final result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          _isLoggedIn = true;
          _typeRegister = 'Facebook';
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false );
        _typeRegister = '';
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false );
        _typeRegister = '';
        break;
    }

  }

  _logout(){
      facebookLogin.logOut();
      setState(() {
        _isLoggedIn = false;
        _typeRegister = '';
      });
    }

  @override
  Widget build(BuildContext context) {



    if (_lastLifecycleState == null)
      print('data:' + _lastLifecycleState.toString());

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child:
            _isLoggedIn && _typeRegister == 'Facebook'
            ?
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(userProfile["picture"]["data"]["url"], height: 50.0, width: 50.0,),
                Text(userProfile["name"]),
                OutlineButton( child: Text("Logout"), onPressed: (){
                  _logout();
                },)
              ],
            )
            :
            _typeRegister == 'Mobile' ?
              Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
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
                  Row(//ROW 2
                    children: [
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Text(
                            'Ingrese número de celular'
                          ),
                        )
                    ]
                  ),
                  SizedBox(height: 5.0),
                  Row(//ROW 3
                      children: <Widget>[
                      Column(
                          children: <Widget>[
                            DropdownButton<Item>(
                            //        hint:  Text("Select item"),
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
                      ),
                      new Flexible(
                        child: new TextField(
                          controller: phoneNumController,
                          decoration: const InputDecoration(helperText: "Ingresa tu número de celular"),
                            keyboardType: TextInputType.number,
                            maxLength: 9,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
//                          style: Theme.of(context).textTheme.body1,
                        ),
                      )
                    ]
                  ),
                  SizedBox(height: 55.0),
//                Row(//ROW 4
//                    children: <Widget>[
                  RaisedButton.icon(
                    onPressed: (){ _registerMobile(context); },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    label: Text('Recibir código por SMS',
                    style: TextStyle(color: Colors.white),),
                    icon: Icon(FontAwesomeIcons.sms, color:Colors.white,),
                    textColor: Colors.white,
                    splashColor: Colors.deepOrange,
                    color: Colors.orange,),
    //                  ]
                //           )
                ]
              )
            :
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Crea tu cuenta en Bodegator',
//                style: Theme.of(context).textTheme.display1,
                textAlign: TextAlign.center
              ),
              const SizedBox(height: 90),
              RaisedButton.icon(
              onPressed: (){ _loginWithMobile(); },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              label: Text('Con tu número celular',
                style: TextStyle(color: Colors.white),),
              icon: Icon(FontAwesomeIcons.mobile, color:Colors.white,),
              textColor: Colors.white,
              splashColor: Colors.deepOrange,
              color: Colors.orange,),
              RaisedButton.icon(
              onPressed: (){ _loginWithFB(); },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
              label: Text('Facebook',
                style: TextStyle(color: Colors.white),),
              icon: Icon(FontAwesomeIcons.facebook, color:Colors.white,),
              textColor: Colors.white,
              splashColor: Colors.blueGrey,
              color: Colors.blue,)
          ],
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );

  }

}


class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}