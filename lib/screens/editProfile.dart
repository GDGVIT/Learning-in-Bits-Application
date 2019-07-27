import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learning_in_bits/models/global.dart';
import 'package:learning_in_bits/models/viewDetails.dart';
import 'package:learning_in_bits/screens/forgotPassword.dart';
import 'package:learning_in_bits/screens/changeProfilePic.dart';

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

  String fullname,email,image_url;
  List tags;
  int counter = 0;

  Map<String, dynamic> body_edit_profile_add_tag = 
  {
  "token":"Q8CybNK6SEdo3+a2U2IZjQ21HIIVqVD/+E0JL68lQS4=",
  "tag" : "beauty",  
  "tag_command" : "add"
  };
  String addTag;

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
      return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(110,26,230,50),
        iconTheme: IconThemeData(color: Color.fromRGBO(110,26,230,50),),
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
            image_url=snapshot.data.image_url;
            tags=snapshot.data.tags;

            return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 20.0),
            padding: EdgeInsets.all(25.0),
            child: Form(
              key: _key,
              autovalidate: autovalidate,
              child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Center(
  child: GestureDetector(
    onTap: (){
      Navigator.push(
    context,
    new MaterialPageRoute(
        builder: (BuildContext context) => new ChangePic(token: widget.token,)));
    },
    child : Container(
     margin: new EdgeInsets.only(top: 0.0,bottom: 20.0),
     child : image_url==null?  new Icon(Icons.account_circle , size: 100.0, color: Colors.amberAccent,)
     //(icon: Icon(Icons.account_circle,size: 100.0,color: Colors.amberAccent,))
     : new ClipRRect(
    borderRadius: new BorderRadius.circular(100.0),
    child:  new Image.network(
        image_url,
        height: 100.0,
        width: 100.0,
       ),  ),
),),
  /*new Container(
     margin: new EdgeInsets.only(top: 40.0,left: 125.0),
     alignment: FractionalOffset.centerLeft,
     
     child : Image.network(image_url , height: 100.0, width: 100.0, )
    //  child: new IconButton(
    //    icon: Icon(Icons.account_circle,size: 100.0,color: Colors.amberAccent,),
    // ),
  ),*/
),
        Row(
          children: <Widget>[
            Flexible(
              child:  TextFormField(
                enabled: counter%2==0 ? false : true,
          decoration: InputDecoration(
            labelText:'Fullname',
             focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(110,26,230,50),)),
             labelStyle: TextStyle(color: Color.fromRGBO(110,26,230,50),),
             border: counter%2==0 ? UnderlineInputBorder(borderSide: BorderSide.none):OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(110,26,230,50),)),
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
          enabled: counter%2==0 ? false : true,
          decoration: InputDecoration(
             labelText:'E-mail',
            border: counter%2==0 ? UnderlineInputBorder(borderSide: BorderSide.none):OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(110,26,230,50),)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(110,26,230,50),)),
            labelStyle: TextStyle(color: Color.fromRGBO(110,26,230,50),),
          ),
          maxLength: 30,
          initialValue: email,
          validator: validateEmail,
          onSaved: (val){
            email=val;
          },
        ),

        new SizedBox(
          height: 20.0,
        ),

        TextFormField(
          enabled: counter%2==0 ? false : true,
          decoration: InputDecoration(
             labelText:'Add tag',
             focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(110,26,230,50),)),
             labelStyle: TextStyle(color: Color.fromRGBO(110,26,230,50),),
            border: counter%2==0 ? UnderlineInputBorder(borderSide: BorderSide.none):OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(110,26,230,50),)),
          ),
          maxLength: 30,
          onSaved: (val){
            addTag=val;
          },
        ),

        Container(
          height: 200,
      child: new GridView.count(
    shrinkWrap: true,
    childAspectRatio: 2/1.5,
    crossAxisSpacing: 0.5,
    crossAxisCount: _gridCount(tags.length),
    children: List.generate(tags.length, (index) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
         // color: _gridColor(index),
          child:  Chip(
              deleteIcon: Icon(Icons.cancel,color: Colors.white,),
              onDeleted: () {
          setState(() {
            _removeMaterial(tags[index]);
          });
        },
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        backgroundColor: Color.fromRGBO(110,26,230,50),
        label: Text(tags[index] , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
          ),
          );
        })) 
           ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
          child: RaisedButton(onPressed: _sendToEditDetails,
          child: Text('Edit profile'),color: Color.fromRGBO(110,26,230,50),textColor: Colors.white,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0) ),),
          ),

          Center(
          child: RaisedButton(onPressed: (){
            _setSharedToNull();
           // Navigator.push(context,new MaterialPageRoute(builder: (BuildContext context) =>new ForgotPassword()));

          },
          child: Text('Log out'),color: Color.fromRGBO(110,26,230,50),textColor: Colors.white,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0) ),),
          )
          ],
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
    );
  }

  _setSharedToNull() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', null);
    exit(0);
  }

  _sendToEditDetails() {
   if (_key.currentState.validate()) {
      _key.currentState.save();

  setState(() {
    counter = counter + 1;
    print("The new counter is "+counter.toString());
  });

  if(addTag.isEmpty){
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
          if(counter%2==1){
            print("counter is even");
          }
          else{
            Fluttertoast.showToast(
              msg: "Changes edited successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey[700],
              textColor: Colors.white
          );
          }
       // Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ViewProfile(token: widget.token)));
        }
        }
      else{
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
   }
   else{
     body_edit_profile["fullname"] = '$fullname';
    body_edit_profile["email"] = '$email';
    body_edit_profile["token"] = '${widget.token}';

    body_edit_profile_add_tag["token"] = '${widget.token}';
    body_edit_profile_add_tag["tag"] = '$addTag';
    body_edit_profile_add_tag["tag_command"] = 'add';
    
    print(body_edit_profile);
    print(body_edit_profile_add_tag.toString() + "    Add tag");
    
    Future fetchPosts(http.Client client) async {
    var edit_response=await http.post(URL_EDIT_PROFILE,  headers: {"Content-Type": "application/json"}, body:json.encode(body_edit_profile));
    var edit_response_add_tag=await http.post(URL_EDIT_PROFILE,  headers: {"Content-Type": "application/json"}, body:json.encode(body_edit_profile_add_tag));

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
        }
        }else{
    Fluttertoast.showToast(
        msg: "There is some error for making changes",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white);
  }

  if(edit_response_add_tag.statusCode==200){
   final data_edit_add_tag = json.decode(edit_response_add_tag.body);
      print(data_edit_add_tag['property']);
        if(data_edit_add_tag['property'].toString()=="success"){
           Fluttertoast.showToast(
        msg: "Tag added successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white);
        }
        }else{
    Fluttertoast.showToast(
        msg: "There is some error adding tag",
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
   }
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

_gridCount(int count) {
    if(count==1){
      return 1;
    }
    else {
      return 2;
    }
  }

  
 _gridColor(int index) {
    if(index%2==0){
      return Colors.amber;
    }
    else{
      return Colors.blue;
    }
  }

  void _removeMaterial(String name) async {

    Map<String, dynamic> body_delete_edit_profile = 
  {
    "tag" : "tag1",
    "tag_command" : "delete" ,
    "token" : "Q8CybNK6SEdo3+a2U2IZjQ21HIIVqVD/+E6QS4="
  };

  //Future fetchPosts(http.Client client) async {
    body_delete_edit_profile["token"] = widget.token;
    body_delete_edit_profile["tag"] = name;
    body_delete_edit_profile["tag_command"] = "delete";

    print(body_delete_edit_profile.toString()+"   body view profile");
    var delete_response=await http.post(URL_EDIT_PROFILE,  headers: {"Content-Type": "application/json"}, body:json.encode(body_delete_edit_profile));

    print("delete edit response"+ delete_response.toString());

     if(delete_response.statusCode==200){
   final data_edit_delete = json.decode(delete_response.body);
      print(data_edit_delete['property']);
        if(data_edit_delete['property'].toString()=="success"){
           Fluttertoast.showToast(
            msg: "Tag deleted successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[700],
            textColor: Colors.white
          );
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
  // }

    // _materials.remove(name);
    // if (_selectedMaterial == name) {
    //   _selectedMaterial = '';
    // }
  }
}
