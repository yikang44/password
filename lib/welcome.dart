import 'package:flutter/material.dart';
import 'package:password/sign.dart';

import 'login.dart';

class welcome extends StatefulWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 150.0),
                  child: Icon(Icons.flutter_dash_sharp, size: 200, color: Colors.white,),
                ),
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  'welcome',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=> const login()));
                    },
                    child:Text('Login',style: TextStyle(fontSize: 20),)
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const sign()));
                    },
                    child: Text('Sign in', style: TextStyle(fontSize: 20),)
                )
              ],
            ) ,
          )
      ),
    );
  }
}
