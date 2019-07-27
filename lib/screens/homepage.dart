// import 'package:flutter/material.dart';
// import 'package:learning_in_bits/screens/editProfile.dart';
// import 'package:learning_in_bits/screens/showQuotes.dart';
// import 'package:learning_in_bits/screens/viewProfile.dart';
// import 'package:flip_box_bar/flip_box_bar.dart';

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title,this.token}) : super(key: key);
//   final String title,token;


//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   int currentTab = 0; 
//   List<Widget> pages; 
//   Widget currentPage;

//   @override
//   void initState() {
//     super.initState();
//     pages = [new ShowQuotes(token: widget.token,), new ViewProfile(token: widget.token,), new EditProfile(token: widget.token,)];
//     currentPage = new ShowQuotes(token: widget.token,); 
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: currentPage,
//       drawer: Drawer(
//         child: ListView(
//           children: <Widget>[

//             UserAccountsDrawerHeader(
//             accountName: Text("Ashish Rawat"),
//             accountEmail: Text("ashishrawat2911@gmail.com"),
//             currentAccountPicture: CircleAvatar(
//               backgroundColor:
//                   Theme.of(context).platform == TargetPlatform.iOS
//                       ? Colors.blue
//                       : Colors.white,
//               child: Text(
//                 "A",
//                 style: TextStyle(fontSize: 40.0),
//               ),
//             ),
//           ),
//             ListTile(
//               title: Text("Ttem 1"),
//               trailing: Icon(Icons.arrow_forward),
//             ),
//             ListTile(
//               title: Text("Item 2"),
//               trailing: Icon(Icons.arrow_forward),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar:  FlipBoxBar(
//           items: [
//             FlipBarItem(icon: Icon(Icons.list), text: Text("Tags"), frontColor: Colors.yellow, backColor: Colors.yellowAccent),
//             FlipBarItem(icon: Icon(Icons.account_circle), text: Text("View Profile"), frontColor: Colors.blue, backColor: Colors.lightBlueAccent),
//             FlipBarItem(icon: Icon(Icons.edit), text: Text("Edit Profile"), frontColor: Colors.orange, backColor: Colors.orangeAccent),
//           ],
//           onIndexChanged: (newIndex) {

//         setState(() { 
//           print("Current tab: " + newIndex.toString());
//           currentTab = newIndex;
//           currentPage = pages[newIndex]; 
          
//           // if(newIndex==0){
//           //     currentTab=0;
//           //     currentPage=new MainPage(token: widget.token,);
//           //    // sendToMen();
//           //    // return  EditProfile(token: widget.token,);
//           //   }
//           //   else if(newIndex==1){
//           //     currentTab=1;
//           //     currentPage=new ViewProfile(token: widget.token,);
//           //      // return  EditProfile(token: widget.token,);
//           //   }
//           //   else if(newIndex==2){
//           //     currentTab=2;
//           //     currentPage=new EditProfile(token: widget.token,);
//           //       // return  EditProfile(token: widget.token,);
//           //   }

//         });

//             print(newIndex);
//           },
//         ),
//     );
//   }
// }

