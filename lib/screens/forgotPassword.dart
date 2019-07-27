import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:learning_in_bits/screens/homepage.dart';
import 'package:learning_in_bits/models/global.dart';
import 'package:learning_in_bits/models/viewDetails.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key,this.token}) : super(key: key);
  final String token;
  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {

GlobalKey<FormState> _key = new GlobalKey();
bool autovalidate = false;

Map<String, dynamic> body_forgot_password = 
  {
  "username" : "uc",  
  "password" : "password",
  "new_password" : "password",
  "confirm_new_password" : "password"
  };

  String un,op,np,cnp;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return new WillPopScope(
    onWillPop: () async => _exitApp(context),
    child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text("Forgot password"),
      ),
      body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 50.0),
            padding: EdgeInsets.all(25.0),
            child: Form(
              key: _key,
              autovalidate: autovalidate,
              child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      
        Row(
          children: <Widget>[
            Flexible(
              child:  TextFormField(
          decoration: InputDecoration(
            labelText:'Username',
            border: OutlineInputBorder()
          ),
          onSaved: (String val){
            un=val;
          },
        ),
            )
          ],
        ),
        new SizedBox(
          height: 20.0,
        ),
      
        TextFormField(
          decoration: InputDecoration(
             labelText:'Old password',
            border: OutlineInputBorder()
          ),
          onSaved: (String val){
            op=val;
          },
        ),

        new SizedBox(
          height: 20.0,
        ),

        TextFormField(
          decoration: InputDecoration(
             labelText:'New password',
            border: OutlineInputBorder()
          ),
          initialValue: np,
          onSaved: (String val){
            np=val;
          },
        ),

        new SizedBox(
          height: 20.0,
        ),

        TextFormField(
          decoration: InputDecoration(
             labelText:'Confirm new password',
            border: OutlineInputBorder()
          ),
          initialValue: np,
          onSaved: (String val){
            cnp=val;
          },
        ),

        Center(
          child: RaisedButton(onPressed: _sendToEditDetails,
          child: Text('Confirm'),color: Colors.lightBlueAccent,textColor: Colors.white,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0) ),),
          )
      ],
    ))))));  
}

  _sendToEditDetails() {
   if (_key.currentState.validate()) {
      _key.currentState.save();
    
    body_forgot_password["username"] = '$un';
    body_forgot_password["password"] = '$op';
    body_forgot_password["new_password"] = '$np';
    body_forgot_password["confirm_new_password"] = '$cnp';

    print(body_forgot_password);
    
    Future fetchPosts(http.Client client) async {
    var edit_response=await http.post(URL_EDIT_PROFILE,  headers: {"Content-Type": "application/json"}, body:json.encode(body_forgot_password));
  
    print(edit_response);
    if(edit_response.statusCode==200){
   final data_edit = json.decode(edit_response.body);
      print(data_edit['property']);
        if(data_edit['property'].toString()=="success"){
           Fluttertoast.showToast(
        msg: "Password changed successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white);

        Navigator.pop(context);
        }
        else{
    Fluttertoast.showToast(
        msg: "There is some error for making changes",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white);
  }
        }
        else{
    Fluttertoast.showToast(
        msg: "There is some error for making changes",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white);
  }
   return FutureBuilder(
        future: fetchPosts(http.Client()),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.data==null){
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          else{
            Fluttertoast.showToast(
        msg: "Check Your Connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white);
          }
          });
   }
   } else {
      setState(() {
        autovalidate = false;
      });
    }
  }
  
  Future<bool> _exitApp(BuildContext context) {
  return showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text('Do you want to exit this application?'),
          content: new Text('We hate to see you leave...'),
          actions: <Widget>[
            new FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No'),
            ),
            new FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: new Text('Yes'),
            ),
          ],
        ),
      ) ??
      false;
}
}
