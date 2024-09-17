

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_maker2/screens/Home.dart';
import 'package:quiz_maker2/screens/sign_in.dart';
import 'package:quiz_maker2/screens/sign_up_info.dart';

import '../controls/auth.dart';
import '../firebase_options.dart';
import '../navi.dart';
import '../widgit/logo.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(signup());
}
class signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:MyHome()
    );
  }
}
// first time to login
class MyHome extends StatelessWidget {

  TextEditingController email_filed = TextEditingController();
  TextEditingController pass_filed = TextEditingController();

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
        Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(

              title: Center(child: AppLogo(),),
              elevation: 0.0,
              backgroundColor: Colors.transparent, systemOverlayStyle: SystemUiOverlayStyle.dark,
              //brightness: Brightness.li,
            ),
            body:SingleChildScrollView(
                child:  Column(
                  children:[
                    Container(
                        alignment: Alignment.topLeft,
                        margin:EdgeInsets.fromLTRB( 15, 20, 0,0) ,
                        child: const Text(
                          ' CREATE \n ACCOUNT',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        )),

                    Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 15),
                        padding:EdgeInsets.fromLTRB(20, 15, 0, 0),
                        child: const Text(
                          'Your Email :',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        )),
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: TextField(
                        controller: email_filed,
                      //  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Email",
                    filled: true,
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color:  Colors.black,
                        width: 0.3,
                      ),
                    ),
                    hintText: "Enter your Email ",
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ) ,
                   // suffixIcon: Icon(Icons.visibility, color: Colors.blue[200],),
                    prefixIcon: Icon(Icons.person_rounded,color:  Colors.blue[200],),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
                    Container(
                        alignment: Alignment.topLeft,
                        padding:EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: const Text(
                          'Your Password :',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        )),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        controller: pass_filed,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          filled: true,
                          fillColor: Colors.grey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color:  Colors.black,
                              width: 0.3,
                            ),
                          ),
                          hintText: "Enter your Password ",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ) ,
                          suffixIcon: Icon(Icons.visibility, color: Colors.blue[200],),
                          prefixIcon: Icon(Icons.lock,color:  Colors.blue[200],),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                        height: 50,
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Create Account',style: TextStyle(
                              color: Colors.black),),
                          onPressed: () {
                            try{
                              print("${email_filed.text}     ${pass_filed.text}");
                              Authentication.createuser(email_filed.text.trim(),pass_filed.text.trim());
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>signup_info()));
                            }
                            catch(e){
                              print(e);
                            }

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                            ),
                          ),
                        )
                    ),
                    Container(
                        height: 50,
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child:ElevatedButton(
                          child: const Text('sign up with Google',style: TextStyle(
                              color: Colors.black),),
                          onPressed: () {
                            try{
                              Authentication.signInWithGoogle();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                            } catch(e){print(e);}
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                            ),
                          ),
                        )
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(15, 10, 10, 0),
                          child: Text('Already have account?'),),
                        Padding(padding: EdgeInsets.fromLTRB(15, 10, 10, 0),
                            child: TextButton(
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>signin()));
                              },
                            ))
                      ],)
                  ],
                )))

    );

  }
}



