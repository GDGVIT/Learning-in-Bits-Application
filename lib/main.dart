import 'package:flutter/material.dart';
import 'package:learning_in_bits/screens/homepage.dart';
import 'package:learning_in_bits/screens/loginpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: 'Puella',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder> {
    '/homepage': (BuildContext context) => MyHomePage(title: 'Learning in Bits'),
    '/loginpage': (BuildContext context) => LoginScreen(
    //  auth:new Auth()
      ),
      }
    );
  }
}
