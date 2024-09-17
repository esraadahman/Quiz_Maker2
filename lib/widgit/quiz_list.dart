import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker2/color.dart';
import 'package:quiz_maker2/models/quizmodel.dart';

import '../screens/profile.dart';
import '../screens/quiz_play.dart';
class quiz_widgit extends StatefulWidget {
 quiz_widgit({
    super.key,
    required this.l,
  });
  quizmodel? l;

  @override
  State<quiz_widgit> createState() => _PostState();
}

class _PostState extends State<quiz_widgit> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("${widget.l!.quiz_id} in quiz list");
          Navigator.push(context, MaterialPageRoute(builder:
              (context) => QuizPlay(quiz_id: widget.l!.quiz_id!,questions: widget.l?.questions?? [],)));

      },
      child: Container(
        decoration:  BoxDecoration(
          border: Border.all(color: text_color,width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),),
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              if(widget.l?.quiz_image!=null && widget.l!.quiz_image!.startsWith("http"))
              Image.network(
                widget.l!.quiz_image!,
                fit: BoxFit.cover,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
              )
              else
             Center( child:  Icon(CupertinoIcons.photo, color: buttomcolor,
               size: 150,
             ),),
              Container(
                //color: back_Container,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.l!.quiz_title!,
                        style: TextStyle(
                            fontSize: 30,
                            color: text_color,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        widget.l!.quiz_des!,
                        style: TextStyle(
                            fontSize: 20,
                            color:  text_color,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        //alignment: Alignment.bottomRight,
                        child:
                        Text(
                          widget.l!.questions!.length.toString(),
                          style: TextStyle(
                              fontSize: 15,
                              color:  text_color,
                              fontWeight: FontWeight.w500),
                        ),)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}