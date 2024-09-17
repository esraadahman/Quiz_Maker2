

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_maker2/color.dart';
import 'package:quiz_maker2/screens/Home.dart';
import 'package:quiz_maker2/screens/profile.dart';

import '../controls/firebase.dart';
import '../widgit/logo.dart';
import 'create_quiz.dart';

class AddQuestion extends StatefulWidget {

   String quizId;
  AddQuestion(this.quizId);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  TextEditingController question = TextEditingController();
  TextEditingController option1 = TextEditingController();
  TextEditingController option2 = TextEditingController();
  TextEditingController option3 = TextEditingController();
  TextEditingController option4 = TextEditingController();
  TextEditingController correct_answer = TextEditingController();
  List<Map> quistions=[];


  @override
  Widget build(BuildContext context) {
      return  Scaffold(
        backgroundColor:  back_ground,
      appBar: AppBar(
        leading: BackButton(
          color: buttomcolor,
        ),
        title: AppLogo(),
        elevation: 0.0,
        backgroundColor: Colors.transparent, systemOverlayStyle: SystemUiOverlayStyle.dark,
        //brightness: Brightness.li,
      ),
      body:SingleChildScrollView(
          child: Container(
          height: MediaQuery.of(context).size.height*0.9, // Or any other fixed height
    child: Form(
      //  key: _formKey,
        child: Container(
         padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
         Padding(padding: EdgeInsets.only(bottom: 10,top: 20),
            child:
              TextFormField(
                controller: question,
                style: TextStyle(
                    color: text_color
                ),
                    decoration: InputDecoration(
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color:  text_color!,
              width: 0.3,
            ),),
                        hintText: "Question",
                      hintStyle: TextStyle(
                      color: text_color,
                      fontSize: 15,
                    ) ,

                ),

              ),),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: option1,
                  style: TextStyle(
                      color: text_color
                  ),
                decoration:
                InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color:  text_color!,
                        width: 0.3,
                      ),),
                    hintText: "Option1 ",
                hintStyle: TextStyle(
                  color: text_color,
                  fontSize: 15,
                ) ,)

              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: option2,
                  style: TextStyle(
                      color: text_color
                  ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color:  text_color,
                        width: 0.3,
                      ),),
                    hintText: "Option2",
                  hintStyle: TextStyle(
                    color: text_color,
                    fontSize: 15,
                  ) ,)
                ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: option3,
                  style: TextStyle(
                      color: text_color
                  ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color:  text_color,
                        width: 0.3,
                      ),),
                    hintText: "Option3",
                  hintStyle: TextStyle(
                    color: text_color,
                    fontSize: 15,
                  ) ,)
                ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: option4,
                  style: TextStyle(
                      color: text_color
                  ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color:  text_color,
                        width: 0.3,
                      ),),
                    hintText: "Option4",
                  hintStyle: TextStyle(
                    color: text_color,
                    fontSize: 15,
                  ) ,)
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                  controller: correct_answer,
                  style: TextStyle(
                      color: text_color
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color:  text_color,
                        width: 0.3,
                      ),),
                    hintText: "Correct Answer",
                    hintStyle: TextStyle(
                      color: text_color,
                      fontSize: 15,
                    ) ,)
              ),
              SizedBox(
                height: 8,
              ),
              Spacer(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      if( quistions.isNotEmpty){
                      try{
                        // firestore.AddQuestion(
                        //   widget.quizId,
                        //   question.text.trim(),
                        //     option1.text.trim(),
                        //     option2.text.trim(),
                        //   option3.text.trim(),
                        //   option4.text.trim(),
                        // );
                        quizzes.addAll({"questions": quistions});
                        print(quizzes);
                        CollectionReference users = FirebaseFirestore.instance.collection('quizzes');
                        await users
                            .add(
                            quizzes
                            )
                            .then((value) => print("User added successfully!"))
                            .catchError((error) => print("Failed to add user: $error"));
                        quizzes ={};
                        quistions=[];
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                      }
                      catch (e) {
                        print(e);
                      }}
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                          color: quistions.isEmpty? Colors.blue.withAlpha(50): buttomcolor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "Submit",
                        style:
                        TextStyle(fontSize: 16, color: quistions.isEmpty? Colors.blue.withAlpha(50):text_color),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () async {
                      try{
                        quistions.add({"question": question.text.trim(),
                         "option1": option1.text.trim(),
                          "option2":option2.text.trim(),
                          "option3": option3.text.trim(),
                          "option4": option4.text.trim(),
                          "correct_answer": correct_answer.text.trim(),
                        });
                        // firestore.AddQuestion(
                        //   widget.quizId,
                        //   question.text.trim(),
                        //   option1.text.trim(),
                        //   option2.text.trim(),
                        //   option3.text.trim(),
                        //   option4.text.trim(),
                        // );
                      //  Navigator.push(context, MaterialPageRoute(builder: (context) => AddQuestion(widget.quizId)));
                      setState(() {
                        option1.clear();
                        question.clear();
                        option2.clear();
                        option3.clear();
                        option4.clear();
                        correct_answer.clear();
                      });
                      }
                      catch (e) {
                        print(e);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                          color: buttomcolor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "Add Question",
                        style:
                        TextStyle(fontSize: 16, color: text_color),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),))
    );
  }
}