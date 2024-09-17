
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_maker2/color.dart';
import 'package:quiz_maker2/controls/firebase.dart';
import 'package:quiz_maker2/models/questionmodel.dart';
import 'package:quiz_maker2/screens/profile.dart';
import 'package:quiz_maker2/screens/result.dart';
import 'package:quiz_maker2/widgit/quiz_list.dart';
import 'package:quiz_maker2/widgit/quiz_play_widgit.dart';

import '../controls/auth.dart';
import '../models/quizmodel.dart';
import '../widgit/logo.dart';




class QuizPlay extends StatefulWidget {
  String quiz_id ;List<Map> questions;
 QuizPlay({required this.quiz_id ,required this.questions});

 @override
  _QuizPlayState createState() => _QuizPlayState();
}



class _QuizPlayState extends State<QuizPlay> {



  int total = 0;



@override
void initState() {
  super.initState();
  total = widget.questions.length;
    correct =0;

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  back_ground,
        appBar: AppBar(
        title: AppLogo(),
    elevation: 0.0,
    backgroundColor: Colors.transparent, systemOverlayStyle: SystemUiOverlayStyle.dark,
    //brightness: Brightness.li,
    ),
    body:
    SingleChildScrollView( child:
    Column( children: [
      SizedBox(
        height: 10,
      ),


    Container(
        height: MediaQuery.sizeOf(context).height*0.75,
        child:ListView.builder(
          itemCount: widget.questions.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Container(
              height: MediaQuery.sizeOf(context).height*0.4,
              width: MediaQuery.sizeOf(context).width,
              padding: EdgeInsets.only(bottom: 10),
              child: quiz_play_widgit(
                k: QuestionModel(
                  question: widget.questions[index]['question'],
                  option1:widget.questions[index]['option1'],
                  option2: widget.questions[index]['option2'],
                  option3: widget.questions[index]['option3'],
                  option4: widget.questions[index]['option4'],
                  correct_answer: widget.questions[index]['correct_answer'],
                ),
              ),
            );
          },
        )

    ),

      GestureDetector(
        onTap: ()  {
          // incorrect=total-correct;
          print('$correct         $incorrect' );
          if((correct+incorrect) == total){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Results(incorrect: incorrect,correct: correct, total: total, )),
          );
          }

        },
        child: Container(
          height: MediaQuery.sizeOf(context).height*0.08,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 2 - 20,
          padding: EdgeInsets.symmetric(
              horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
              color: buttomcolor,
              borderRadius: BorderRadius.circular(30)),
          child: Text(
            "RESULT",
            style:
            TextStyle(fontSize: 16, color: text_color),
          ),
        ),
      ),
      SizedBox(
        width: 8,
      ),

    ]))

    );}}



