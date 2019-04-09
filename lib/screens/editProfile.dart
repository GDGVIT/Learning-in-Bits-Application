import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:learning_in_bits/models/global.dart';
import 'package:learning_in_bits/models/viewDetails.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key,this.token}) : super(key: key);
  final String token;
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

GlobalKey<FormState> _key = new GlobalKey();
bool autovalidate = false;

Map<String, dynamic> body_view_profile = 
  {
    "token" : "Q8CybNK6SEdo3+a2U2IZjQ21HIIVqVD/+E6QS4="
  };

Map<String, dynamic> body_edit_profile = 
  {
  "token":"Q8CybNK6SEdo3+a2U2IZjQ21HIIVqVD/+E0JL68lQS4=",
  "fullname" : "uc",  
  "email" : "fc@gmail.com"
  };

  String fullname,email;
  List tags;

  Future fetchPosts(http.Client client) async {
    body_view_profile["token"] = widget.token;
    print(body_view_profile.toString()+"   body view profile");
    var login_response=await http.post(URL_VIEW_PROFILE,  headers: {"Content-Type": "application/json"}, body:json.encode(body_view_profile));

    print("login response"+ login_response.toString());

    if (login_response.statusCode == 200) {
    return ViewDetails.fromJson(json.decode(login_response.body));
  } else {
    throw Exception('Failed to load post');
  }
   }

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
        title: Text("Edit Profile"),
      ),
      body: new FutureBuilder(
        future: fetchPosts(http.Client()),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.data==null){
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          else if (snapshot.hasData) {
            fullname = snapshot.data.fullname;
            email =snapshot.data.email;

            return SingleChildScrollView(
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
            labelText:'Fullname',
            border: OutlineInputBorder()
          ),
          maxLength: 20,
          initialValue: fullname,
          validator: (val) => val.length == 0 ? 'Please enter user name' :null,
          onSaved: (val){
            fullname=val;
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
             labelText:'E-mail',
            border: OutlineInputBorder()
          ),
          maxLength: 30,
          initialValue: email,
          validator: validateEmail,
          onSaved: (val){
            email=val;
          },
        ),
        Center(
          child: RaisedButton(onPressed: _sendToEditDetails,
          child: Text('Edit worker'),color: Colors.lightBlueAccent,textColor: Colors.white,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0) ),),
          )
      ],
    ))));    
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
          })
    ));
  }

  _sendToEditDetails() {
   if (_key.currentState.validate()) {
      _key.currentState.save();

      print(email);
      print(fullname);

    body_edit_profile["fullname"] = '$fullname';
    body_edit_profile["email"] = '$email';
    body_edit_profile["token"] = '${widget.token}';
    
    print(body_edit_profile);
    
    Future fetchPosts(http.Client client) async {
    var edit_response=await http.post(URL_EDIT_PROFILE,  headers: {"Content-Type": "application/json"}, body:json.encode(body_edit_profile));

    print(edit_response);
    if(edit_response.statusCode==200){
   final data_edit = json.decode(edit_response.body);
      print(data_edit['property']);
        if(data_edit['property'].toString()=="success"){
           Fluttertoast.showToast(
        msg: "Changes edited successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white);
       // Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ViewProfile(token: widget.token)));
        }
        }else{
    Fluttertoast.showToast(
        msg: "There is some error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white);
  }
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
    } else {
      setState(() {
        autovalidate = false;
      });
    }
  }
  
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter valid Email';
    else
      return null;
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
