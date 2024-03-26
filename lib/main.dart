import 'dart:async';

import 'package:flutter/material.dart';
import 'package:password/login.dart';
import 'package:password/password.dart';
import 'package:password/welcome.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({Key?key}): super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home:splashScreen(),
    );
  }
}

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  bool _isLoggedIn = false;

  void initState() {
    super.initState();
    checkLoginStatus();
  }

void checkLoginStatus() async{
  final dataBaseHelper = DataBaseHelper();
  final loggedInEmail = await dataBaseHelper.readloginEmail();
  setState((){
    _isLoggedIn = loggedInEmail.isNotEmpty;
  });
  Timer(Duration(seconds: 3), () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _isLoggedIn ?  Password(email: '',password: '',) : const welcome(),
      ));
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 100,
        ),
      ),
    );
  }
}



