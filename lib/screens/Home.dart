import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_maker2/color.dart';
import 'package:quiz_maker2/screens/profile.dart';
import 'package:quiz_maker2/screens/quiz_play.dart';
import 'package:quiz_maker2/screens/sign_in.dart';
import 'package:quiz_maker2/widgit/quiz_list.dart';

import '../controls/auth.dart';
import '../controls/firebase.dart';
import '../models/quizmodel.dart';
import '../widgit/logo.dart';
import 'package:quiz_maker2/screens/create_quiz.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  back_ground,
      appBar: AppBar(
        title:
        Row(children: [
          AppLogo(),
        Padding(padding: EdgeInsets.only(left: 130) ,child:
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => profile()),
            );
          },
          child: Icon(
            Icons.person_rounded,
            color: buttomcolor,
            size: 30, // Adjust size as needed
          ),
        ),),
        Padding(padding: EdgeInsets.only(left: 20) ,child:
        GestureDetector(
            onTap: () {
              Authentication.SignOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => signin()),
              );
            },
            child: Icon(
              Icons.logout, color: buttomcolor,
              size: 30, // Adjust size as needed
            ),
          ),)
        ],),

       // elevation: 0.0,
        backgroundColor: Colors.transparent, systemOverlayStyle: SystemUiOverlayStyle.dark,
        //brightness: Brightness.li,
      ),
      body:SingleChildScrollView( child:
      Container(
        //width: 500,
          child:
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('quizzes').snapshots(),
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
                       margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
                        padding: const EdgeInsets.all(8.0),
                        child: quiz_widgit(
                          l: quizmodel(
                            quiz_image: snap.data!.docs[index]['quiz_image'],
                              questions: (snap.data!.docs[index]['questions'] as List).cast<Map>(),
                            quiz_title: snap.data!.docs[index]['quiz_title'],
                            quiz_des: snap.data!.docs[index]['quiz_des'],
                            quiz_id: snap.data!.docs[index].id
                          ),
                        ),);

                  },
                );
              }
            },
          )),),
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttomcolor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateQuiz()),
          );
        },
        child: Icon(Icons.add , color: text_color,) ,
      ),

    );
  }
}
