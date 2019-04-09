import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_in_bits/models/global.dart';
import 'package:learning_in_bits/screens/homepage.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({//this.auth,
  this.onSignIn});
 // final BaseAuth auth;
   final VoidCallback onSignIn;

  @override
  _LoginScreen3State createState() => new _LoginScreen3State();
}
enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

class _LoginScreen3State extends State<LoginScreen>
    with TickerProviderStateMixin {
      String usernameLogin,passwordLogin;
     // final FirebaseAuth _auth = FirebaseAuth.instance;

GlobalKey<FormState> _key = new GlobalKey();
bool autovalidate = false;

GlobalKey<FormState> _key_signup = new GlobalKey();
bool autovalidate_signp = false;
String _emailSignUp, _passwordSignUp, _usernameSignUp, _fullnameSignUp, _confirmpasswordSignUp,message;


 Map<String, dynamic> body_signup = 
   {
    "username" : "Sfdhgmjbathuj" ,
    "password" : "Satkriti" ,
    "confirm_password" : "Satkriti" ,
    "tags" : ["tag1", "tag2"] ,
    "fullname" : "Sat",
    "email" : "Satvh@gmail.com"
    };


Map<String, dynamic> body_login = 
  {
	"username": "hgf" ,
	"password" : "qwerty"
} ;

  @override
  void initState() {
    super.initState();
  }

  Widget HomePage(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
    backgroundColor: Colors.white,
             body:SingleChildScrollView(child: Container(
              decoration: BoxDecoration(
        color: Colors.white,
        // image: DecorationImage(
        //   colorFilter: new ColorFilter.mode(
        //       Colors.black.withOpacity(1), BlendMode.dstATop),
        //   image: AssetImage('lib/assests/images/startbackground.png'),
        //   fit: BoxFit.fitWidth,
        // ),
       ),
         
          child:SingleChildScrollView(child: Container(
            height: MediaQuery.of(context).size.height,
          
      child: new Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 120,top: 100),
            child:
          Text("Learning in Bits",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),),     
          new Container(
            width: MediaQuery.of(context).size.width-100,
            margin: const EdgeInsets.only(left: 50.0, right: 30.0, top: 520.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new OutlineButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.redAccent,
                    highlightedBorderColor: Colors.white,
                    onPressed: () => gotoSignup(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "SIGN UP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width-100,
            margin: const EdgeInsets.only(left: 50.0, right: 30.0, top: 380.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.greenAccent,
                    onPressed: ()  {
                      gotoLogin();
                    },
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )))));
  }

  Widget LoginPage(BuildContext context) {
    return Scaffold
    (body: Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Form(
              key: _key,
              autovalidate: autovalidate,
              child: FormUI(),
            ),
    )  );
  }
Widget FormUI() {
  
    int flag;
    return SingleChildScrollView(
      child:

  Container(
      height: MediaQuery.of(context).size.height,
       decoration: BoxDecoration(
         color: Colors.white,
       
       ),
      child: new Column(
        children: <Widget>[
          
         SingleChildScrollView(
                child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container(
          //   height: 200,
          //  // padding: EdgeInsets.all(50),
          //   child:Center(
          //   child:Container(
          //    // margin: EdgeInsets.only(top: 10),
          //     child:Image.asset('lib/assests/images/appname.png') ,
          //   )
          // ,
          //   ),
          // ),
           Container(
                padding: EdgeInsets.only(left: 16.0,right:16.0,top: 16.0),
                child:
              TextFormField(
                style: TextStyle(color: Colors.pink),
                cursorColor:  Theme.of(context).accentColor,
                
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                hintText: 'User name',
                  labelText: 'User Name'
                ),
                 keyboardType: TextInputType.text,
            validator:  (val) => val.length == 0 ? 'Please enter user name' :null,
            onSaved: (String val) {
              usernameLogin = val.toString().trim();
            }
                
              )
              ),
              Container(
                padding: EdgeInsets.only(left: 16.0,right:16.0,top: 16.0),
                child:
              TextFormField(
                style: TextStyle(color: Colors.pink),
                cursorColor:  Theme.of(context).accentColor,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password'
                ),
                  validator: (val) => val.length == 0 ? 'Please Enter the Password' : (val.length<6)?'Password too short':null,
              onSaved: (val) => passwordLogin = val,
              // obscureText: _obscureText,
                
              )
              ),
              new Container(
                width: MediaQuery.of(context).size.width-100,
            margin: EdgeInsets.only(bottom: 5,left: 50,top: 35),
            child: Center(child: 
            Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.greenAccent,
                    onPressed: ()  {
                    _sendToServerLogin();
                  },
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),),

          Container(
             margin: EdgeInsets.only(bottom: 4,left: 130,top: 3),
            child: Text("Forgot Password",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
          ),

           new Container(
          width: MediaQuery.of(context).size.width-100,
            margin: EdgeInsets.only(bottom: 16,left: 50,top: 5),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new OutlineButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.orange,
                    highlightedBorderColor: Colors.white,
                  onPressed: () => gotoSignup(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "SIGN UP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
            
        
              
        ],
      ),
    )])));
}

_sendToServerLogin() {
    if (_key.currentState.validate()) {
      // setState(() {
      // });
    
      _key.currentState.save();

    body_login["username"] = '$usernameLogin';
    body_login["password"] = '$passwordLogin';
    
    print(body_login);
    
    Future fetchPosts(http.Client client) async {
    var login_response=await http.post(URL_LOGIN,  headers: {"Content-Type": "application/json"}, body:json.encode(body_login));

    print(login_response);
    if(login_response.statusCode==200){
   final data_login = json.decode(login_response.body);
      print(data_login['msg']);
       Fluttertoast.showToast(
        msg: data_login['msg'].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white);

        if(data_login['msg'].toString()=="Login successful."){
          Navigator.push(context, MaterialPageRoute(builder:(context) => MyHomePage(title:"Learning in bits",token: data_login['token'].toString(),)));
        }
        }else{
    Fluttertoast.showToast(
        msg: "There is some error in the server",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white);
  }
        //_processData();
  }
    
   print(body_login);
  
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
      // validation error
      setState(() {
        autovalidate = false;
      });
    }
  }



  Widget SignupPage(BuildContext context) {
    return Scaffold(body:
    SingleChildScrollView(child: Container(
      height: MediaQuery.of(context).size.height,
     color: Colors.white,
      child:Container(child: Form(
        key:_key_signup,
        autovalidate: autovalidate_signp,
        child: Column(
        children: <Widget>[
          Container(
            height: 70.0,
          ),
              Container(
                padding: EdgeInsets.only(left: 16.0,right:16.0),
                child:
              TextFormField(
                style: TextStyle(color: Colors.pink),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'What People call you?',
                  labelText: 'Full Name',
                  
                ),
                validator:  (val) => val.length == 0 ? 'Please enter full name' :null,
          onSaved: (String val) {
            _fullnameSignUp = val;
          },
              )
              ),
              Container(
                padding: EdgeInsets.only(left: 16.0,right:16.0,top: 16.0),
                child:
              TextFormField(
                validator:  (val) => val.length == 0 ? 'Please enter user name' :null,
                style: TextStyle(color: Colors.pink),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //hintText: '',
                  labelText: 'Username'
                ),    
          onSaved: (String val) {
            _usernameSignUp = val;
          },
              )
              ),
            Container(
                padding: EdgeInsets.only(left: 16.0,right:16.0,top: 16.0),
                child:
             new TextFormField(
               style: TextStyle(color: Colors.pink),
            decoration: new InputDecoration(hintText: 'Email ID',labelText: 'Email ID',border: OutlineInputBorder(),),
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
            onSaved: (String val) {
              _emailSignUp= val;
            }
            ),
              ),
             Container(
                padding: EdgeInsets.only(left: 16.0,right:16.0,top: 16.0),
                child:
              TextFormField(
                style: TextStyle(color: Colors.pink),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Password",
                  labelText: 'Password'
                ),
              validator: (val) => val.length == 0 ? 'Please enter  Password' : (val.length<6)?'Password too short':null,
              onSaved: (val) => _passwordSignUp = val.toString().trim(),
              obscureText: true,
              ),),
               Container(
                padding: EdgeInsets.only(left: 16.0,right:16.0,top: 16.0),
                child:
              TextFormField(
                style: TextStyle(color: Colors.pink),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Password",
                  labelText: 'Confirm Password'
                ),
              validator: (val) => val.length == 0 ? 'Please enter Password' : (val.length<6)?'Password too short':null,
              onSaved: (val) => _confirmpasswordSignUp = val.toString().trim(),
              obscureText: true,
             
              ),),
             
               new Container(
          width: MediaQuery.of(context).size.width-100,
            margin: EdgeInsets.only(bottom: 16,left: 10,top: 35),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new OutlineButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.orange,
                    highlightedBorderColor: Colors.white,
                   onPressed: () {
                    _sendToServerSignUp();
                  },
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "SIGN UP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]))
  ))));
  }
 _sendToServerSignUp() {
  
    if (_key_signup.currentState.validate()) {
   
      _key_signup.currentState.save();

    body_signup["username"] = '$_usernameSignUp';
    body_signup["password"] = '$_passwordSignUp';
    body_signup["confirm_password"] = '$_confirmpasswordSignUp';
    body_signup["tags"] = '["beauty"]';
    body_signup["fullname"] = '$_fullnameSignUp';
    body_signup["email"] = '$_emailSignUp';
    print(body_signup);
    
    Future fetchPosts(http.Client client) async {
    var response=await http.post(URL_SIGNUP,  headers: {"Content-Type": "application/json"},
    body:json.encode(body_signup));
   
    print(response.body+"   response body");
    if(response.statusCode==200){
    final data = json.decode(response.body);
      print(data['property']);

      if(data['property'].toString()=="confirm_password_failed"){
        message = "Password do not match";
      }
      else{
        message = data['msg'].toString();
      }

       Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white);
        gotoLogin();
        //_processData();
  }else{
    Fluttertoast.showToast(
        msg: "There is some error in the server",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white);
  }
    }
   print(body_signup);
  
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
      // validation error
      setState(() {
        autovalidate_signp= true;
      });
    }
  }
      
  gotoLogin() {
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  gotoSignup() {
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
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
  PageController _controller = new PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: PageView(
          controller: _controller,
          physics: new AlwaysScrollableScrollPhysics(),
          children: <Widget>[LoginPage(context), HomePage(context),SignupPage(context)],
          scrollDirection: Axis.horizontal,
        ));
  }
}