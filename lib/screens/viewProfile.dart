import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:learning_in_bits/models/global.dart';
import 'package:learning_in_bits/models/viewDetails.dart';

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
    return WillPopScope(
      onWillPop: () async => _exitApp(context),
      child: Scaffold(
      appBar: AppBar(
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
            fullname = snapshot.data.fullname;
            email =snapshot.data.email;
            tags=snapshot.data.tags;

            return Column(
    children: <Widget>[
Stack(
  children: <Widget>[

new Container(
  margin: EdgeInsets.only(top: 135.0),
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
              margin:EdgeInsets.only(top: 50.0,bottom: 10.0),
              child: new Text('Name : $fullname',style: Theme.of(context).textTheme.title,textAlign: TextAlign.center,),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: new Text('E-mail : $email',style: Theme.of(context).textTheme.subhead,textAlign: TextAlign.center,),
            ),
            Container(
             // padding: EdgeInsets.symmetric(horizontal: 115.0),
              margin: EdgeInsets.all(10.0),
              child: new Text('Tags : $tags',style: Theme.of(context).textTheme.subhead,textAlign: TextAlign.center,),
            ),
             Container(
             padding: EdgeInsets.symmetric(horizontal: 120.0),
              margin: EdgeInsets.all(10.0),
              child: new Text('    ',style: Theme.of(context).textTheme.subhead,textAlign: TextAlign.center,),
            )
          ],
        ) ,
        ),
        )
      ),
      new Center(
  child: new Container(
     margin: new EdgeInsets.only(top: 70.0,left: 125.0),
     alignment: FractionalOffset.centerLeft,
     child: new IconButton(
       icon: Icon(Icons.account_circle,size: 100.0,color: Colors.amberAccent,),
    ),
  ),
),
  ],
),  
    ],
  );
            
           /*  Center(
           // padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [BoxShadow(blurRadius: 0.8),],
                borderRadius: BorderRadius.all(Radius.circular(18))
              ),
              padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 20.0),
              child: Stack(
              children: <Widget>[
            Container(
              margin:EdgeInsets.only(top: 20.0,bottom: 10.0),
              child: new Text('Name : ${snapshot.data.fullname}',style: Theme.of(context).textTheme.title,textAlign: TextAlign.center,),
            ),
            Container(
              margin: EdgeInsets.only(top: 50.0,bottom: 20.0),
              child: new Text('E-mail : ${snapshot.data.email}',style: Theme.of(context).textTheme.subhead,textAlign: TextAlign.center,),
            ),
            Container(
              margin: EdgeInsets.only(top: 80.0,bottom: 20.0),
              child: new Text('Tags : ${snapshot.data.tags}',style: Theme.of(context).textTheme.subhead,textAlign: TextAlign.center,),
            ),
          ],
        ) ,
            ) 
             );*/
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
       )   );
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
