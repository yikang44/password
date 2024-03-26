import 'package:flutter/material.dart';
import 'package:password/password.dart';

class edit extends StatefulWidget {
  const edit({super.key});

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {

  TextEditingController _TitleController = TextEditingController();
  TextEditingController _ContextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(Icons.person, color: Colors.white,size: 200),
            TextField(
              controller: _TitleController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              obscureText: true,
            ),
        SizedBox(height: 20),
        TextFormField(
          controller: _ContextController,
          decoration: InputDecoration(
            labelText: 'PassWord',
          ),
          obscureText: true,
        ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  Password(email: _TitleController.text, password: _ContextController.text)));
                },
                child:
            Text('Edit',style: TextStyle(fontSize: 15),))
          ],
        ),
      ),
    );
  }
}
