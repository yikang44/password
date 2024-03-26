import 'package:flutter/material.dart';

import 'login.dart';

class sign extends StatefulWidget {
  const sign({Key?key}) : super(key: key);

  @override
  State<sign> createState() => _signState();
}

class _signState extends State<sign> {
final email = TextEditingController();

final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Sign up',
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: email ,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: password,
              decoration: InputDecoration(
                labelText: 'PassWord',
              ),
              obscureText: true,
            ),
           Expanded(child: SizedBox(),),
            ElevatedButton(
                onPressed: () async {
                  DataBaseHelper().sign(email.text, password.text);
                 Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => const login()));
                },
                child: Text('Sign up')),
            SizedBox(height: 50,)
          ]),
        ),
      ),
    );
  }
}