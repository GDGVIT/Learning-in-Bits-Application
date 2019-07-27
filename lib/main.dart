import 'package:flutter/material.dart';
import 'package:learning_in_bits/screens/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

//void main() => runApp(MyApp());
Future<void> main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  //print("Got token as "+token);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: token == null ? LoginScreen() : MyHomePage(token:token)
      )
    );
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
//   var token ;
//   Future<void> main() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   token = prefs.getString('token');
//   print("Got token as "+token);
//   runApp(MaterialApp(home: token == null ? LoginScreen() : MyHomePage(token:token)));
// }

  @override
  Widget build(BuildContext context) {

    // Future<void> main() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   var email = prefs.getString('token');
    //   print(email);
    // }

//      Future<void> main() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var token = prefs.getString('token');
//   print("Got token as "+token);
//   runApp(MaterialApp(home: token == null ? LoginScreen() : MyHomePage(token:token)));
// }
     return MaterialApp(
      title: 'Learning in Bits',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        hintColor: Color.fromRGBO(110,26,230,50),
      ),
    // home: token == null ? LoginScreen() : MyHomePage(token:token),
      // LoginScreen(),
      debugShowCheckedModeBanner: false,
    //   routes: <String, WidgetBuilder> {
    // '/homepage': (BuildContext context) => MyHomePage(title: 'Learning in Bits'),
    // '/loginpage': (BuildContext context) => LoginScreen(
    // //  auth:new Auth()
    //   ),
    //   }
    );
  }
}
