import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:learning_in_bits/models/global.dart';
import 'package:learning_in_bits/models/getQuote.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ShowQuotes extends StatefulWidget {
  ShowQuotes({Key key,this.token}) : super(key: key);
  final String token;

  @override
  _ShowQuotesState createState() => _ShowQuotesState();
}
/*
class _ShowQuotesState extends State<ShowQuotes> {


  Map<String, dynamic> bodyGetQuote = 
  {
    "token" : "Q8CybNK6SEdo3+a2U2IZjQ21HIIVqVD/+E6QS4="
  };

  String property,quote;

  Future fetchPosts(http.Client client) async {
    bodyGetQuote["token"] = widget.token;
    print(bodyGetQuote.toString()+"   body get quote");
    var quote_response=await http.post(URL_GET_QUOTE,  headers: {"Content-Type": "application/json"}, body:json.encode(bodyGetQuote));

    print("Quote response"+ quote_response.toString());

    if (quote_response.statusCode == 200) {
    return GetQuote.fromJson(json.decode(quote_response.body));
  } else {
    print(quote_response.statusCode.toString() + "    status code");
    //throw Exception('Failed to load quotes');
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
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text("Main Page"),
      ),
      body: LiquidPullToRefresh(
        onRefresh:null ,
        child: ListView(
          children: <Widget>[

       new FutureBuilder(
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
            property = snapshot.data.property;
            quote =snapshot.data.quote;

return Center(
  child: Container(
    margin: EdgeInsets.symmetric(horizontal: 40.0),
    child: Text(quote),
  )      
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
          ],
        ),
      )
      
    );
  }


  Future<GetQuote> getQuote() async {

    Map<String, dynamic> bodyGetQuote = 
  {
    "token" : "Q8CybNK6SEdo3+a2U2IZjQ21HIIVqVD/+E6QS4="
  };
    bodyGetQuote["token"] = widget.token;
    print(bodyGetQuote.toString()+"   body get quote");
    var quote_response=await http.post(URL_GET_QUOTE,  headers: {"Content-Type": "application/json"}, body:json.encode(bodyGetQuote));

    print("Quote response"+ quote_response.toString());

    if (quote_response.statusCode == 200) {
    return GetQuote.fromJson(json.decode(quote_response.body));
  } else {
    print(quote_response.statusCode.toString() + "    status code");
    //throw Exception('Failed to load quotes');
  }
   

  }
}

*/


class _ShowQuotesState extends State<ShowQuotes> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = 
  new GlobalKey<RefreshIndicatorState>();

  GetQuote gq = GetQuote("Success","Beauty is not in the face ; beauty is a light in the heart");

  // Map<String, dynamic> bodyGetQuote = 
  // {
  //   "token" : "Q8CybNK6SEdo3+a2U2IZjQ21HIIVqVD/+E6QS4="
  // };

  // String property,quote;

  // Future fetchPosts(http.Client client) async {
  //   bodyGetQuote["token"] = widget.token;
  //   print(bodyGetQuote.toString()+"   body get quote");
  //   var quote_response=await http.post(URL_GET_QUOTE,  headers: {"Content-Type": "application/json"}, body:json.encode(bodyGetQuote));

  //   print("Quote response"+ quote_response.toString());

  //   if (quote_response.statusCode == 200) {
  //   return GetQuote.fromJson(json.decode(quote_response.body));
  // } else {
  //   print(quote_response.statusCode.toString() + "    status code");
  //   //throw Exception('Failed to load quotes');
  // }
  //  }

  @override
  void initState() {
    super.initState();
      WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  Map<String, dynamic> body_edit_profile_add_tag = 
  {
  "token":"Q8CybNK6SEdo3+a2U2IZjQ21HIIVqVD/+E0JL68lQS4=",
  "tag" : "beauty",  
  "tag_command" : "add"
  };
  String addTag;
  GlobalKey<FormState> _key = new GlobalKey();
  bool _autovalidate = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning in Bits',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home : Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(110,26,230,50),
        iconTheme: IconThemeData(color: Color.fromRGBO(110,26,230,50),),
        title: Text("Main Page"),
        actions: <Widget>[
          new IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () {
                _refreshIndicatorKey.currentState.show();
              }),
        ],
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 30.0),
          child:  RefreshIndicator(
          // height: 100.0,
          // showChildOpacityTransition: false,
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 50.0),
                child: Center(
                  child: _displayText(gq.quote)
                 // Text(gq.quote,style: TextStyle(fontSize: 20.0),),
                )
              ),
              /*Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 30.0),
                child: Form(
                key: _key,
                autovalidate: _autovalidate,
                child: Column(children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText:'Add tag',
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(110,26,230,50),)),
                      labelStyle: TextStyle(color: Color.fromRGBO(110,26,230,50),),
                      border: UnderlineInputBorder()
                    ),
                    onSaved: (val){
                      addTag=val;
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: RaisedButton(
                      child: Text('Add tag'),color: Color.fromRGBO(110,26,230,50),textColor: Colors.white,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0) ),
                      onPressed: _sendToServer,
                    ),
                  )
                ],)
                  
                ) 
              )*/
            ],
            // children: [Padding(
            //   padding: const EdgeInsets.only(top: 24.0),
            //   child: Center(
            //     child: Column(
            //       children: <Widget>[
            //         Text(gq.quote),
            //       ],
            //     ),
            //   ),
            // )
         // ]
          ),
         
        )
       ),)
     ) );
  }
   Future<GetQuote> getQuote() async {

    Map<String, dynamic> bodyGetQuote = 
  {
    "token" : "Q8CybNK6SEdo3+a2U2IZjQ21HIIVqVD/+E6QS4="
  };
    bodyGetQuote["token"] = widget.token;
    print(bodyGetQuote.toString()+"   body get quote");
    var quote_response=await http.post(URL_GET_QUOTE,  headers: {"Content-Type": "application/json"}, body:json.encode(bodyGetQuote));

    print("Quote response"+ quote_response.toString());

    if (quote_response.statusCode == 200) {
    return GetQuote.fromJson(json.decode(quote_response.body));
  } else {
    print(quote_response.statusCode.toString() + "    status code");
    //throw Exception('Failed to load quotes');
  }
   

  }

  Future<Null> _refresh() {
    return getQuote().then((_quote) {
      setState(() => gq = _quote);
    });
  }

  _displayText(quote) {

      if(quote==null || gq.property=="failed" || gq.quote=="" || gq.quote==[]){
      return Container(
        child:
            Text("Cannot find a quote",style: TextStyle(fontSize: 20.0 , fontFamily: 'Nunito'),),
      );
       }
    else{
      return Column(
        children: <Widget>[
          Text(gq.quote,style: TextStyle(fontSize: 23.0 , fontFamily: 'Nunito' , fontWeight: FontWeight.bold),),
        ],
      );
      
    }
    
  }

  _sendToServer() {
   if (_key.currentState.validate()) {
      _key.currentState.save();

    body_edit_profile_add_tag["token"] = '${widget.token}';
    body_edit_profile_add_tag["tag"] = '$addTag';
    body_edit_profile_add_tag["tag_command"] = 'add';

    print(body_edit_profile_add_tag);
    Future fetchPosts(http.Client client) async {
    var edit_response_add_tag=await http.post(URL_EDIT_PROFILE,  headers: {"Content-Type": "application/json"}, body:json.encode(body_edit_profile_add_tag));

  if(edit_response_add_tag.statusCode==200){
   final data_edit_add_tag = json.decode(edit_response_add_tag.body);
      print(data_edit_add_tag['property'] + "property");
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
    else {
      setState(() {
        _autovalidate = false;
      });
    }
}
}

