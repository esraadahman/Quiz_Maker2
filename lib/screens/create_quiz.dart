import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_maker2/color.dart';
import 'package:quiz_maker2/screens/Home.dart';
import 'package:quiz_maker2/screens/profile.dart';
import 'package:random_string/random_string.dart';
import '../controls/firebase.dart';
import '../widgit/logo.dart';
import 'add_question.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
Map<String , dynamic> quizzes ={};
 
class CreateQuiz extends StatefulWidget {


  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  static final auth=FirebaseAuth.instance;

  TextEditingController quiz_image = TextEditingController();
  TextEditingController quiz_title = TextEditingController();
  TextEditingController quiz_des = TextEditingController();

 String quiz_id = randomAlphaNumeric(16);


  Future<String?> uploadImageFromUrl() async {
    try {
      final response = await http.get(Uri.parse(quiz_image.text));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final fileName = path.basename(quiz_image.text); // Extract filename from URL
        Reference ref = FirebaseStorage.instance.ref().child('images/$fileName');
        UploadTask uploadTask = ref.putData(bytes);

        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      } else {
        print('Failed to load image: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Form(
       // key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24 ,vertical: 15),
          child: Column(
            children: [
          Padding(padding: EdgeInsets.only(bottom: 10), child:
        TextFormField(
                controller: quiz_image,
                style: TextStyle(
                  color: text_color
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color:  text_color,
                      width: 0.3,
                    ),
                  ),
                    hintText: "Quiz Image Url (Optional)",
                  hintStyle: TextStyle(
                    color: text_color,
                    fontSize: 15,
                  ) ,
                ),
                onChanged: (val){
               //   quizImgUrl = val;
                },
              ),),
              SizedBox(height: 5,),
        Padding(padding: EdgeInsets.only(bottom: 10), child:
        TextFormField(
                controller: quiz_title,
          style: TextStyle(
              color: text_color
          ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color:  text_color,
                      width: 0.3,
                    ),
                  ),
                    hintText: "Quiz Title",
                  hintStyle: TextStyle(
                    color: text_color,
                    fontSize: 15,
                  ) ,
                ),
                onChanged: (val){
               //   quizTitle = val;
                },
              ),),
              SizedBox(height: 5,),
        Padding(padding: EdgeInsets.only(bottom: 10), child:
        TextFormField(
                controller: quiz_des,
          style: TextStyle(
              color: text_color
          ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color:  text_color,
                      width: 0.3,
                    ),
                  ),
                    hintText: "Quiz Description",
                  hintStyle: TextStyle(
                    color: text_color,
                    fontSize: 15,
                  ) ,
                ),
                onChanged: (val){
                 // quizDesc = val;
                },
              ),),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  try{
                    quizzes.addAll({
                      "quiz_image":quiz_image.text.trim(),
                      "quiz_title": quiz_title.text.trim(),
                      "quiz_des":quiz_des.text.trim(),
                      "user_id":auth.currentUser!.uid,
                      "quiz_id":quiz_id,

                    });
                    // firestore.Add_quiz(
                    //     quiz_image.text.trim(),
                    //     quiz_title.text.trim(),
                    //     quiz_des.text.trim(),
                    //   quiz_id,
                    // );
                    // print("$quiz_id in create quiz");
                    // quiz_image.dispose();
                    // quiz_des.dispose();
                    // quiz_title.dispose();
                  if(quiz_image != null && quiz_image.text.startsWith('http'))
                    uploadImageFromUrl();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddQuestion(quiz_id)));
                  }
                  catch (e) {
                    print(e);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: buttomcolor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Create Quiz",
                    style: TextStyle(
                        fontSize: 16, color: text_color),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],)
          ,),
      ),
    );
  }
}