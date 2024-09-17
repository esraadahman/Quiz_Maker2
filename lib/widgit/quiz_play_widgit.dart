import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_maker2/models/quizmodel.dart';
import 'package:quiz_maker2/screens/profile.dart';
import '../models/questionmodel.dart';


int correct = 0;
int incorrect = 0;



class quiz_play_widgit extends StatefulWidget {
  QuestionModel? k;
    quiz_play_widgit ({required this.k});

  @override
  _HomeState createState() => _HomeState();
  }

  class _HomeState extends State<quiz_play_widgit> {
  String selectedOption = '';
bool answer= false;
  @override
  void initState() {
    super.initState();
    correct =0;
    incorrect=0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: back_ground,
        body:
        SingleChildScrollView(
            child:
         Column(
    children: [
      Container(
        margin: EdgeInsets.only(left: 15,right: 15),
        padding: EdgeInsets.only(left: 15,right: 15),
        width: MediaQuery.sizeOf(context).width*.9,
        height: MediaQuery.sizeOf(context).height*.05,
        color: buttomcolor,
        child: Text('${widget.k!.question} ', style: TextStyle(color: text_color, fontSize: 20),),),
      RadioListTile(
        title: Text(widget.k!.option1! , style: TextStyle(color: text_color),),
        value: widget.k!.option1!,
        groupValue: selectedOption,
        onChanged:(value) {
          if(answer != true ){
          setState(() {
            answer=true;
            selectedOption = value!;
            if (value == widget.k!.correct_answer) {
              correct++; // Increment the count of correct answers
            }
            else{
              incorrect++;
            }
          }) ;
        };}
      ),
      RadioListTile(
          title: Text(widget.k!.option2!, style: TextStyle(color: text_color),),
          value: widget.k!.option2!,
          groupValue: selectedOption,
         onChanged:(value) {
           setState(() {
             selectedOption = value!;
             if (value == widget.k!.correct_answer) {
               correct++; // Increment the count of correct answers
             }
             else{
               incorrect++;
             }
           }) ;
         },
        ),
        RadioListTile(
          title: Text(widget.k!.option3!, style: TextStyle(color: text_color),),
          value: widget.k!.option3!,
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value!;
              if (value == widget.k!.correct_answer) {
                correct++; // Increment the count of correct answers
              }
              else{
                incorrect++;
              }
            });
          },
        ),
      RadioListTile(
        title: Text(widget.k!.option4!, style: TextStyle(color: text_color),),
        value: widget.k!.option4!,
        groupValue: selectedOption,
        onChanged: (value) {
          setState(() {
            selectedOption = value!;
            if (value == widget.k!.correct_answer) {
              correct++; // Increment the count of correct answers
            }
            else{
              incorrect++;
            }
          });
        },
      ),



    ],
  )));

}}



