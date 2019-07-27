import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:learning_in_bits/models/global.dart';

class ChangePic extends StatefulWidget {
  ChangePic({Key key,this.token}) : super(key: key);
  final String token;
  @override
  _ChangePicState createState() => _ChangePicState();
}

class _ChangePicState extends State<ChangePic> {
 
  File _image;
  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
    _image = image;
    Fluttertoast.showToast(
      msg: _image.path,
      backgroundColor: Colors.grey,
      fontSize: 12.0
    );
    print(_image.path + "image path");
    print("token   "+widget.token);
    });
  }

  Future _upload() async{
     if(_image==null){
       Fluttertoast.showToast(
      msg: "No image selected.",
      backgroundColor: Colors.grey,
      fontSize: 15.0
    );
     }
     else{
    Dio dio = new Dio();
    FormData formdata = new FormData.from({
      "token" : widget.token,
      "image":new UploadFileInfo(_image, _image.path)
    });
    // formdata.add("token", widget.token);
    // formdata.add("image_url", new UploadFileInfo(_image, _image.path));
    var response = await dio.post("https://stark-retreat-48003.herokuapp.com/upload_image", 
    data: formdata, 
    options: Options(
    
    method: 'POST',
    responseType: ResponseType.json // or ResponseType.JSON
    ));

    if(response.statusCode==200){
      final data_update = json.decode(response.data);
      print(data_update['err']);
      Fluttertoast.showToast(
      msg: "Image uploaded successfully.",
      backgroundColor: Colors.grey,
      fontSize: 15.0
    );
      }
      else{
        Fluttertoast.showToast(
      msg: response.statusMessage,
      backgroundColor: Colors.grey,
      fontSize: 12.0
    );
      }
      print(formdata.toString() + "   "+ response.toString() + "  response");
    }
  }

  // Map<String, dynamic> body_edit_profile_add_tag = 
  // {
  // "token":"Q8CybNK6SEdo3+a2U2IZjQ21HIIVqVD/+E0JL68lQS4=",
  // "tag" : "beauty",  
  // "tag_command" : "add"
  // };

  // Future fetchPosts(http.Client client) async {
  //   body_view_profile["token"] = widget.token;
  //   print(body_view_profile.toString()+"   body view profile");
  //   var login_response=await http.post(URL_VIEW_PROFILE,  headers: {"Content-Type": "application/json"}, body:json.encode(body_view_profile));

  //   print("login response"+ login_response.toString());

  //   if (login_response.statusCode == 200) {
  //   return ViewDetails.fromJson(json.decode(login_response.body));
  // } else {
  //   throw Exception('Failed to load post');
  // }
  //  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      // return  MaterialApp(
      // title: 'Learning in Bits',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      // debugShowCheckedModeBanner: false,
      // home :  
      //WillPopScope(
    //onWillPop: () async => _exitApp(context),
    //child: 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(110,26,230,50),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Change Picture"),
      ),
      // body: new FutureBuilder(
      //   future: fetchPosts(http.Client()),
      //   builder: (BuildContext context,AsyncSnapshot snapshot){
      //     if(snapshot.data==null){
      //       return Container(
      //         child: Center(
      //           child: CircularProgressIndicator(),
      //         ),
      //       );
      //     }
      //     else if (snapshot.hasData) {
      //       fullname = snapshot.data.fullname;
      //       email =snapshot.data.email;

            body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 50.0),
            padding: EdgeInsets.all(25.0),
            child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: _getImage,
                child: Text('Choose Image'),
              ),
              SizedBox(width: 10.0),
              RaisedButton(
                onPressed: _upload,
                child: Text('Upload Image'),
              )
            ],
          ),
          _image == null
            ? Container(
              margin: EdgeInsets.all(20.0),
              child : Text('No Image Selected') )
            : Container(
              margin: EdgeInsets.all(20.0),
              height: 400.0,
              width: 400.0,
              child : Image.file(_image)
              )
        ],
            ))   
        //   }
        //   else{
        //     Fluttertoast.showToast(
        // msg: "Check Your Connection",
        // toastLength: Toast.LENGTH_SHORT,
        // gravity: ToastGravity.BOTTOM,
        // timeInSecForIos: 1,
        // backgroundColor: Colors.grey[700],
        // textColor: Colors.white);
        //   }
        //  })
    ));
  }

//   _sendToEditDetails() {
//    if (_key.currentState.validate()) {
//       _key.currentState.save();

// if(addTag.isEmpty){
//       print(email);
//       print(fullname);

//     body_edit_profile["fullname"] = '$fullname';
//     body_edit_profile["email"] = '$email';
//     body_edit_profile["token"] = '${widget.token}';
    
//     print(body_edit_profile);
    
//     Future fetchPosts(http.Client client) async {
//     var edit_response=await http.post(URL_EDIT_PROFILE,  headers: {"Content-Type": "application/json"}, body:json.encode(body_edit_profile));

//     print(edit_response);
//     if(edit_response.statusCode==200){
//    final data_edit = json.decode(edit_response.body);
//       print(data_edit['property']);
//         if(data_edit['property'].toString()=="success"){
//            Fluttertoast.showToast(
//         msg: "Changes edited successfully",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIos: 1,
//         backgroundColor: Colors.grey[700],
//         textColor: Colors.white);
//        // Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ViewProfile(token: widget.token)));
//         }
//         }else{
//     Fluttertoast.showToast(
//         msg: "There is some error",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIos: 1,
//         backgroundColor: Colors.grey[700],
//         textColor: Colors.white);
//   }
//   }
//    return FutureBuilder(

//         future: fetchPosts(http.Client()),
//         builder: (BuildContext context,AsyncSnapshot snapshot){
//           if(snapshot.data==null){
//             return Container(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
            
//             );

//           }
//           else{
//             Fluttertoast.showToast(
//         msg: "Check Your Connection",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIos: 1,
//         backgroundColor: Colors.grey[700],
//         textColor: Colors.white);
//           }
//           });
//    }
//    else{
//      body_edit_profile["fullname"] = '$fullname';
//     body_edit_profile["email"] = '$email';
//     body_edit_profile["token"] = '${widget.token}';

//     body_edit_profile_add_tag["token"] = '${widget.token}';
//     body_edit_profile_add_tag["tag"] = '$addTag';
//     body_edit_profile_add_tag["tag_command"] = 'add';
    
//     print(body_edit_profile);
//     print(body_edit_profile_add_tag.toString() + "    Add tag");
    
//     Future fetchPosts(http.Client client) async {
//     var edit_response=await http.post(URL_EDIT_PROFILE,  headers: {"Content-Type": "application/json"}, body:json.encode(body_edit_profile));
//     var edit_response_add_tag=await http.post(URL_EDIT_PROFILE,  headers: {"Content-Type": "application/json"}, body:json.encode(body_edit_profile_add_tag));

//     print(edit_response);
//     if(edit_response.statusCode==200){
//    final data_edit = json.decode(edit_response.body);
//       print(data_edit['property']);
//         if(data_edit['property'].toString()=="success"){
//            Fluttertoast.showToast(
//         msg: "Changes edited successfully",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIos: 1,
//         backgroundColor: Colors.grey[700],
//         textColor: Colors.white);
//         }
//         }else{
//     Fluttertoast.showToast(
//         msg: "There is some error for making changes",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIos: 1,
//         backgroundColor: Colors.grey[700],
//         textColor: Colors.white);
//   }

//   if(edit_response_add_tag.statusCode==200){
//    final data_edit_add_tag = json.decode(edit_response_add_tag.body);
//       print(data_edit_add_tag['property']);
//         if(data_edit_add_tag['property'].toString()=="success"){
//            Fluttertoast.showToast(
//         msg: "Tag added successfully",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIos: 1,
//         backgroundColor: Colors.grey[700],
//         textColor: Colors.white);
//         }
//         }else{
//     Fluttertoast.showToast(
//         msg: "There is some error adding tag",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIos: 1,
//         backgroundColor: Colors.grey[700],
//         textColor: Colors.white);
//   }

//   }
//    return FutureBuilder(
//         future: fetchPosts(http.Client()),
//         builder: (BuildContext context,AsyncSnapshot snapshot){
//           if(snapshot.data==null){
//             return Container(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//           else{
//             Fluttertoast.showToast(
//         msg: "Check Your Connection",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIos: 1,
//         backgroundColor: Colors.grey[700],
//         textColor: Colors.white);
//           }
//           });
//    }
//     } else {
//       setState(() {
//         autovalidate = false;
//       });
//     }
//   }
  
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


