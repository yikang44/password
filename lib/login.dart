import 'package:flutter/material.dart';
import 'package:password/sign.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'password.dart';


class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginStateState();
}

class _loginStateState extends State<login> {
  final DataBaseHelper dataBaseHelper = DataBaseHelper();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String email () {
    return _emailController.text;
  }
  String password () {
    return _passwordController.text;
  }
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
              'Login',
              style: TextStyle(fontSize:30, color: Colors.black),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'PassWord',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
             GestureDetector(
               onTap: () {
                 Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => const sign()));
               },
               child : Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   SizedBox(width: 5,),
                   Text(
                       'Sign up',
                   style: TextStyle(fontSize: 20,color: Colors.blueAccent),),
                   Icon(Icons.arrow_forward_ios_rounded)
                 ],
               )
            ),
            ElevatedButton(
                onPressed: () async {
                  await dataBaseHelper.sign(_emailController.text, _passwordController.text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  Password(email: _emailController.text, password:  _passwordController.text)));
                },
                child: Text('Login'))
          ]),

        ),
      ),
    );
  }
}


class DataBaseHelper {
  static const String _databaseName = "My_database.db";

  static final table = 'My_table';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnPassWord = 'password';
  static final columnLogin = '_login';

  static Database? _database;

  Future<Database> get database async {
    if(_database != null) return _database !;
    _database = await _initDatabase();
    return _database!;
  }
  Future<String> get fullpath async {
    final path = await getDatabasesPath();
    final name = "login.db";
    return join(path , name);
  }
  Future<Database> _initDatabase() async {
    String path = await fullpath;
    return await openDatabase(path, version:1, onCreate: (db , context)async {
      await db.execute('''
    CREATE TABLE $table (
    $columnId INTEGER PRIMARY KEY,
    $columnName TEXT,
    $columnPassWord TEXT,
    _login  INTEGER
    )
    ''');
    }
    );
  }
  Future<String> readloginEmail() async {
    final db =await database;
    final result = await db.query('$table' , where: '_login = ?' , whereArgs: [1]);
    if(result.isNotEmpty){
      return result.first['$columnName'].toString();
    }else{
      return '';
    }
  }
  Future<void> sign(String email , String password) async {
    final db = await database;
    db.insert('$table', {'$columnName' : email , '$columnPassWord' : password ,'_login' : 1});
  }
  Future<void> delete() async {
    final db = await database;
    final email = await readloginEmail();
    db.delete('$table' , whereArgs: [email],where: '$columnName = ?');
  }
  Future<String>password() async {
    final db = await  database;
   List<Map<String , dynamic >> res =   await db.query('table' , where: '_login = ?' , whereArgs: [1]);
   return res.firstWhere((element) => element['_password'] != null, orElse : () => {'_password' : ''})['_password'].toString();
  }


}
