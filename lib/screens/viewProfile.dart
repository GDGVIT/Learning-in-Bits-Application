import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:learning_in_bits/models/global.dart';
import 'package:learning_in_bits/screens/changeProfilePic.dart';
import 'package:learning_in_bits/models/viewDetails.dart';
import 'package:learning_in_bits/screens/changeProfilePic.dart';

class ViewProfile extends StatefulWidget {
  ViewProfile({Key key,this.token}) : super(key: key);
  final String token;
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
Map<String, dynamic> body_view_profile = 
  {
    "token" : "Q8CybNK6SEdo3+a2U2IZjQ21HIIVqVD/+E6QS4="
  };

  String fullname,email,image_url;
  List tags;

  Future fetchPosts(http.Client client) async {
    body_view_profile["token"] = widget.token;
    print(body_view_profile.toString()+"   body view profile");
    var login_response=await http.post(URL_VIEW_PROFILE,  headers: {"Content-Type": "application/json"}, body:json.encode(body_view_profile));

    print("login response"+ login_response.toString());

    if (login_response.statusCode == 200) {
    return ViewDetails.fromJson(json.decode(login_response.body));
  } else {
    print("Error has occured");
   // throw Exception('Failed to load post');
  }
   }

  @override
  void initState() {
    fetchPosts(http.Client());
    super.initState();
    
   // fetchPosts(http.Client());
  }

  @override
  Widget build(BuildContext context) {
return MaterialApp(
      title: 'Learning in Bits',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home : WillPopScope(
      onWillPop: () async => _exitApp(context),
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(110,26,230,50),
        iconTheme: IconThemeData(color: Color.fromRGBO(110,26,230,50),),
        title: Text("View Profile"),
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
            image_url=snapshot.data.image_url;
            fullname = snapshot.data.fullname;
            email =snapshot.data.email;
            tags=snapshot.data.tags;
            print(tags.length.toString() +"tags length");

            return Column(
    children: <Widget>[
Stack(
  children: <Widget>[

new Container(
  margin: EdgeInsets.only(top: 105.0,left: 30.0,right: 30.0),
        child: new  Center(
          child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 8.0,
          child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
             // padding: EdgeInsets.symmetric(horizontal: 115.0),
              margin:EdgeInsets.only(top: 50.0,bottom: 40.0),
              child: new Text('Name : $fullname',style: Theme.of(context).textTheme.title,textAlign: TextAlign.center,),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: new Text('E-mail : $email',style: Theme.of(context).textTheme.subhead,textAlign: TextAlign.center,),
            ),
            Container(
              height: 166.0,
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
            
          ],
        ) ,
        ),
        )
      ),
      new Center(
  child: GestureDetector(
    onTap: (){
      Navigator.push(
    context,
    new MaterialPageRoute(
        builder: (BuildContext context) => new ChangePic(token: widget.token,)));
    },
    child : Container(
     margin: new EdgeInsets.only(top: 40.0,left: 125.0),
     alignment: FractionalOffset.centerLeft,
     
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
  ],
),  
    ],
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
          })
       )  ) );
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
    else if(count==2){
      return 2;
    }
    else{
      return 3;
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
        textColor: Colors.white);
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
