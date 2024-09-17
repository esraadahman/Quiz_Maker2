import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_maker2/color.dart';
import 'package:quiz_maker2/screens/Home.dart';
import 'package:quiz_maker2/screens/profile.dart';
import 'package:quiz_maker2/screens/quiz_play.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import '../navi.dart';
import '../widgit/quiz_play_widgit.dart';


class Results extends StatefulWidget {
  final int total, correct, incorrect;
  Results({required  this.incorrect, required this.total, required this.correct});
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  late ValueNotifier<double> valueNotifier;
  late double progressPercentage;

  @override
  void initState() {
    super.initState();
    progressPercentage = (widget.correct / widget.total) * 100;
    valueNotifier = ValueNotifier(progressPercentage);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: back_ground,
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SimpleCircularProgressBar(
                size: 100,
                valueNotifier: valueNotifier,
                progressStrokeWidth: 20,
                animationDuration: 3,
                backStrokeWidth: 20,
                mergeMode: true,
                onGetText: (value) {
                  return Text(
                    '${value.toInt()}%',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
                progressColors: const [Colors.cyan, Colors.purple],
                backColor: Colors.black.withOpacity(0.4),
              ),
              Padding(padding: EdgeInsets.only(top: 15),child:  Text("${widget.correct} / ${widget.total}", style: TextStyle(fontSize: 25),),),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "you answered ${widget.correct} answers correctly and ${widget.incorrect} answeres incorrectly",
                  textAlign: TextAlign.center,),

              ),
              SizedBox(height: 24,),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text("Go to home", style: TextStyle(color: Colors.white, fontSize: 19),),
                ),
              )
            ],),
        ),
      ),
    );
  }
}