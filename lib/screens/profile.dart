import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quiz_maker2/color.dart';
import 'package:quiz_maker2/screens/home.dart';
import 'package:quiz_maker2/widgit/quiz_list_for_user.dart';

import '../controls/auth.dart';
import '../models/quizmodel.dart';
import '../provider.dart';
import '../widgit/logo.dart';
import '../widgit/quiz_list.dart';
import 'edit_profile.dart';


Color? buttomcolor =Colors.blue[400] ;
Color text_color = Colors.black;
Color back_Container =Colors.black26;
Color  back_ground =Colors.white;


void main() => runApp(profile());

class profile extends StatefulWidget {

  MyHome createState() => MyHome();
}


class MyHome extends State<profile> {

  final auth = FirebaseAuth.instance;
  String fullname = '';
  String username = '';
  String userimage = '';
  String dateofbirth = '';

  Future<void> GetUserInfo() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        setState(() {
          fullname = snapshot.data()!['fullname'];
          username = snapshot.data()!['username'];
          dateofbirth = snapshot.data()!['dateofbirth'];
        });
      } else {
        print('No data');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetUserInfo();
  }

bool th =true;

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: back_ground,
        appBar: AppBar(
          title:
          Row(children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Home()),
                );
              },
              child: Icon(
                Icons.arrow_back_ios, color: buttomcolor,
                size: 30, // Adjust size as needed
              ),
            ),
          Padding( padding: EdgeInsets.only(left: 100), child: AppLogo(),),
          ]),
          elevation: 0.0,
          backgroundColor: Colors.transparent, systemOverlayStyle: SystemUiOverlayStyle.dark,
          //brightness: Brightness.li,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                    alignment: Alignment.topRight,
                    height: 40,
                    width: 50,
                    margin: EdgeInsets.fromLTRB(300, 0, 0, 0),
                    //  padding: const EdgeInsets.fromLTRB(300, 0, 0, 0),
                    child: IconButton(
                      icon: Icon(Icons.edit,size: 30 ,color: buttomcolor),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => edit_info()));
                      },
                    ),
                  ),//icon edit
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 200, 0),
                          child: Text(
                            'User Name',
                            style: TextStyle(
                              color: text_color,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),),
                        Text(
                          username,
                          style: TextStyle(
                            color: text_color,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 200, 0),
                          child: Text(
                            'Full Name',
                            style: TextStyle(
                              color: text_color,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),),
                        Text(
                          '@${fullname}',
                          style: TextStyle(
                            color: text_color,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 200, 0),
                          child: Text(
                            'Date Of Birth',
                            style: TextStyle(
                              color: text_color,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),),
                        Text(
                          dateofbirth,
                          style: TextStyle(
                            color: text_color,
                            fontSize: 20.0,
                          ),
                        ),
            Row(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
              child: Text(
                'Theme',
                style: TextStyle(
                  color: text_color,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),),
            Container(
                alignment: Alignment.topRight,
                height: 40,
                width: 50,
                margin: EdgeInsets.fromLTRB(150, 20, 0, 0),
                //  padding: const EdgeInsets.fromLTRB(300, 0, 0, 0),
                child:
                Switch(
                  value:  th,
                  onChanged: (value){
                    if(th){
                      setState(() {
                        back_ground = Colors.black;
                        text_color =Colors.white;
                        back_Container =  Colors.purple.shade100;
                        buttomcolor =  Colors.purple[300];
                        th=false;
                      });}
                    else{
                      setState(() {
                        back_ground = Colors.white;
                        text_color =Colors.black;
                        back_Container =Colors.black26;
                        buttomcolor =  Colors.blue[400];
                        th=true;
                      });
                    }
                  },


                )),]),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
              child: Text(
                'Quizes you add',
                style: TextStyle(
                  color: text_color,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),),
            Container(
              //width: 500,
                child:
                StreamBuilder(
                  stream: FirebaseFirestore.instance.
                  collection('quizzes').
                  where("user_id", isEqualTo: Authentication.auth.currentUser!.uid).
                  snapshots(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snap.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snap.data!.docs[index];
                          return
                            Container(
                              margin: EdgeInsets.only(bottom: 15, left: 10 ,right: 10),
                              padding: const EdgeInsets.all(8.0),
                             child:  quiz_widgit_for_user(
                                l: quizmodel(
                                    quiz_image: snap.data!.docs[index]['quiz_image'],
                                    questions: (snap.data!.docs[index]['questions'] as List).cast<Map>(),
                                    quiz_title: snap.data!.docs[index]['quiz_title'],
                                    quiz_des: snap.data!.docs[index]['quiz_des'],
                                    quiz_id: snap.data!.docs[index].id
                                ),
                              ));

                        },
                      );
                    }
                  },
                ))

            
                      ],
                    ),
                  ),



      ),
    );
  }
}