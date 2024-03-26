import 'dart:math';

import 'package:flutter/material.dart';
import 'package:password/models/note.dart';

class PasswordGenerator extends StatefulWidget {

  final Function(String) onPasswordGenerated;
  const PasswordGenerator({Key?key, required this.onPasswordGenerated}) :super(key: key);

  @override
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  bool includeUppercase = true;
  bool includeLowercase = true;
  bool includeDigits = true;
  bool includeSymbols = true;
  int length = 8;
  String password = '';

  void generatePassword() {
    const String uppercaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String lowercaseLetters = 'abcdefghijklmnopqrstuvwxyz';
    const String digits = '0123456789';
    const String symbols = '!@#\$%^&*()_+-=[]{}|;:,.<>?';

    String allCharacters = '';

    if (includeUppercase) allCharacters += uppercaseLetters;
    if (includeLowercase) allCharacters += lowercaseLetters;
    if (includeDigits) allCharacters += digits;
    if (includeSymbols) allCharacters += symbols;

    Random random = Random();
    String newPassword = '';

    for (int i = 0; i < length; i++) {
      int randomIndex = random.nextInt(allCharacters.length);
      newPassword += allCharacters[randomIndex];

      widget.onPasswordGenerated(password);
    }


    setState(() {
      password = newPassword;
    });
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Password Generator'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose options:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            CheckboxListTile(
              title: Text('Include Uppercase Letters'),
              value: includeUppercase,
              onChanged: (value) {
                setState(() {
                  includeUppercase = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Include Lowercase Letters'),
              value: includeLowercase,
              onChanged: (value) {
                setState(() {
                  includeLowercase = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Include Number'),
              value: includeDigits,
              onChanged: (value) {
                setState(() {
                  includeDigits = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Include Symbols'),
              value: includeSymbols,
              onChanged: (value) {
                setState(() {
                  includeSymbols = value!;
                });
              },
            ),
            Row(
              children: [
                Text('Length:'),
                SizedBox(width: 10),
                Expanded(
                  child: Slider(
                    value: length.toDouble(),
                    min: 4,
                    max: 20,
                    divisions: 16,
                    onChanged: (newValue) {
                      setState(() {
                        length = newValue.toInt();
                      });
                    },
                  ),
                ),
                Text(length.toString()),
              ],
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: generatePassword,
                child: Text('Generate Password'),
              ),
            ),
            Row(
              children: [
                Text('password:',
                style: TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(
                  height: 5,
                ),
                Text(password)
              ],
            ),
            GestureDetector(
              onTap: (){
                generatePassword();
                Navigator.of(context).pop();
              },
              child:Align(
                alignment: Alignment.bottomRight,
                child: Text(
                    'OK',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),),
              )
            )
          ],
        ),
      ),
    );
  }
}



class add extends StatefulWidget {
  final Note ? note;
  const add({super.key, this.note});

  @override
  State<add> createState() => _addState();
}

class _addState extends State<add> {
   TextEditingController _titleController = TextEditingController();
   TextEditingController _contextController = TextEditingController();

   @override
  void initState() {
     if(widget.note != null){
    _titleController = TextEditingController(text: widget.note!.title);
    _contextController = TextEditingController(text: widget.note!.context);
     }
    super.initState();
  }

   void  setPassword(String newpassword){
   setState(() {
   _contextController.text = newpassword;
   });
   }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(backgroundColor: Colors.grey,),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Column(
            children: [
              Expanded(
                  child: ListView(
                    children:  [
                       TextField(
                         controller : _titleController,
                         style: const TextStyle(fontSize: 30,color: Colors.black),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'title',
                        hintStyle: TextStyle(color: Colors.black, fontSize: 30)
                      ),
                    ),
                       TextField(
                        controller: _contextController,
                        style: const TextStyle(fontSize: 15,color: Colors.black),
                        maxLines: null,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'type something...',
                            hintStyle: TextStyle(color: Colors.black, fontSize: 15)
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: ElevatedButton(
                            onPressed: (){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return PasswordGenerator(
                                     onPasswordGenerated: setPassword,
                                    );
                                  }
                              );
                            }, child:
                         const Icon(Icons.password, size: 20,)
                        ),
                      ),
              ],
                  ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 10,
        onPressed: (){
          Navigator.pop(context, [
            _titleController.text,
            _contextController.text,
          ]);
        },
        child: const Icon(Icons.save_alt_sharp, color: Colors.white),
      ),
    );
  }
}

