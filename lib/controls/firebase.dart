import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_maker2/screens/add_question.dart';

class firestore{
  //static int quiz_id=1;
  static final auth=FirebaseAuth.instance;
  static String? fullname ;static String? username ; static String? phonenumber;
  static String? dateofbirth ;static String? locetion ;static String? userimage ;static bool? isolder16;


  static Future<void> Add_user_info(String fullname , String username , String phonenumber,
      String dateofbirth ,  String userimage
      ) async{
    await FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid).set({
      'fullname': fullname,
      'username': username,
      'dateofbirth' :dateofbirth,
      'phone':phonenumber,
      'userimage':userimage,
    });
    print("ADDED user info");
  }

 static Future<void> removeQuiz(String quizId) async {
    try {
      await FirebaseFirestore.instance.collection('quizzes').doc(quizId).delete();

      print('Quiz removed successfully');
    } catch (e) {
      print('Error removing quiz: $e');
      // Handle any errors that occur during the deletion process
    }
  }

}