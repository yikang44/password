import 'package:flutter/material.dart';
import 'package:password/add.dart';
import 'package:password/edit.dart';
import 'package:password/login.dart';
import 'package:password/models/note.dart';



class Password extends StatefulWidget {
  final String email;
  final String password;
  const  Password({Key? key, required this.email, required this.password}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Page(),
    Page2(email: '',password: '',),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.white,
        selectedIconTheme: const IconThemeData(color : Colors.white),
      ),
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  List<Note> filteredNotes = [];

  @override
  void initState() {
    super.initState();
    filteredNotes = sampleNotes;
  }

  void onSearchTextChanged(String searchText ){
    setState(() {
      filteredNotes = sampleNotes
          .where((note) =>
          note.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

   void deleteNote(int index) {
     setState(() {
       Note note = filteredNotes[index];
       sampleNotes.remove(note);
       filteredNotes.removeAt(index);

     });

   }


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('List',
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
          TextField(
              onChanged: onSearchTextChanged,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                hintText: "Search here....",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          Expanded(
              child:ListView.builder(
                itemCount: filteredNotes.length,
                itemBuilder: (context, index ){
                  return Card(
                    color: Colors.black,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        onTap: ()async {
                          final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>add(note: filteredNotes[index]),
                          ));
                          if (result != null) {
                            setState(() {
                              int orgIndex = sampleNotes.indexOf(filteredNotes[index]);

                              sampleNotes[orgIndex] = (Note(
                                id: sampleNotes[orgIndex].id,
                                title: result[0],
                                context: result[1],
                              ));

                              filteredNotes[index] = (Note(
                                id:  filteredNotes[index].id,
                                title: result[0],
                                context: result[1],
                              ));
                            });
                          }
                          },
                        title: RichText(
                          text:  TextSpan(
                              text: '${filteredNotes [index].title} \n',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 1.5),
                              children: [
                                TextSpan(
                                    text: filteredNotes[index].context,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                        height: 1.5),
                                  )
                              ]
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: (){
                            deleteNote(index);
                            filteredNotes = sampleNotes;
                          },icon: const Icon(Icons.delete, color: Colors.white,),
                        ),
                      ),
                    ),
                  );
                },
              ))
        ],
      ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const add(),
              ),
          );

          if (result != null) {
            setState(() {
              sampleNotes.add(Note(
                  id: sampleNotes.length,
                  title: result[0],
                  context: result[1],
                  ));
              filteredNotes = sampleNotes;
            });
          }
        },
        child: const Icon(Icons.add, size: 38,color: Colors.white,),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  final String email;
  final String password;
  const Page2({super.key, required this.email, required this.password});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final DataBaseHelper dataBaseHelper = DataBaseHelper();
  final login fuc = login();
 String a  = "", b = "";

 @override
  void initState(){
    super.initState();
    fuck();
  }
  void fuck()async {
    a = await DataBaseHelper().readloginEmail();
    b = await DataBaseHelper().password();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children:[
            Expanded(
              child: ListView(
                children: [
                  Icon(Icons.person, color: Colors.white,size: 200),
                  Text(
                    a,
                    style: TextStyle(fontSize: 30,color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    b,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                    Card(
                      color: Colors.white60,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                                onTap: (){
                              Navigator.push(
                              context,
                                MaterialPageRoute(builder: (context) => const edit())
                              );
                              },
                              title: RichText(
                                text: TextSpan(
                                text:'Edit Account',
                                style:TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                height: 1.5
                            ),
                          ),
                        ),
                              leading: Icon(Icons.manage_accounts,size: 60, color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                    Card(
                      color: Colors.white60,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                          onTap: () async {
                            _handleLogout(context);
                          },
                          title: RichText(
                            text: TextSpan(
                              text:'Sign out',
                              style:TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  height: 1.5
                              ),
                            ),
                          ),
                            leading: Icon(Icons.group_remove_outlined, color: Colors.black,size: 60,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void  _handleLogout(BuildContext context) async{
    await dataBaseHelper.delete();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => login()));
  }
}




