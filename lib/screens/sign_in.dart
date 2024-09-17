// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:quiz_maker2/screens/sign%20up.dart';
// import '../color.dart';
// import '../controls/auth.dart';
// import '../firebase_options.dart';
// import '../navi.dart';
// import '../widgit/logo.dart';
// void main()async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(login());
// }
//
// class login extends StatefulWidget {
//   @override
//   State<login> createState() => _StoryWidgetState();
// }
//
// class _StoryWidgetState extends State<login> {
//
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: AppLogo(),
//           elevation: 0.0,
//           backgroundColor: Colors.transparent, systemOverlayStyle: SystemUiOverlayStyle.dark,
//           //brightness: Brightness.li,
//         ),
//         body: SingleChildScrollView(
//           child:
//           Container(
//             alignment: Alignment.center,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(padding: EdgeInsets.only(top: 10,bottom: 30), child:  Text(
//                   'Tiktok ',
//                   style: TextStyle(
//                     fontSize: 35,
//                     color: buttonColor,
//                     fontWeight: FontWeight.w900,
//                   ),
//                 ),),
//                 SizedBox(
//                   height: 25,
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   margin: const EdgeInsets.symmetric(horizontal: 20),
//                   child: TextField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                       labelText: "Email",
//                       filled: true,
//                       fillColor: backgroundColor,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide(
//                           color: buttonColor,
//                           width: 0.3,
//                         ),
//                       ),
//                       hintText: "Enter your Email ",
//                       hintStyle: TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                       ) ,
//                       prefixIcon: Icon(Icons.email_sharp,  color: borderColor,),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   margin: const EdgeInsets.symmetric(horizontal: 20),
//                   child: TextField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: "Password",
//                       filled: true,
//                       fillColor: backgroundColor,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide(
//                           color:  buttonColor,
//                           width: 0.3,
//                         ),
//                       ),
//                       hintText: "Enter your Password ",
//                       hintStyle: TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                       ) ,
//                       suffixIcon: Icon(Icons.visibility, color: borderColor,),
//                       prefixIcon: Icon(Icons.lock, color:borderColor,),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width - 40,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: buttonColor,
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(20),
//                     ),
//                   ),
//                   child:ElevatedButton(
//                     onPressed: (){
//                       try{
//
//                         Authentication.signin_with_email(_emailController.text.trim(), _passwordController.text.trim());
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>navie()));
//
//                       }
//                       catch(e){
//                         print(e);
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:  buttonColor,
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Login',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 20),
//                   width: MediaQuery.of(context).size.width - 40,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: buttonColor,
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(20),
//                     ),
//                   ),
//                   child:ElevatedButton(
//                     onPressed: (){},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:  buttonColor,
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Login with Google ',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Don\'t have an account? ',
//                       style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.white
//                       ),
//                     ),
//                     SizedBox(width: MediaQuery.sizeOf(context).width*.03,),
//                     TextButton(
//                       child: Text(
//                         'Sign up',
//                         style: TextStyle(fontSize: 20,color: buttonColor),
//                       ),
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>signup()));
//                       },
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),)
//
//     );
//   }}


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_maker2/screens/sign_up.dart';

import '../controls/auth.dart';
import '../firebase_options.dart';
import '../navi.dart';
import '../widgit/logo.dart';
import 'home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(signin());
}
class signin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:MyHome()
    );
  }
}

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
            body: SingleChildScrollView(
                child:Padding(
                    padding:EdgeInsets.fromLTRB(10, 16, 16, 5),// Outer padding for the entire screen
                    child:   Column(
                      children:[
                        Container(
                            alignment: Alignment.topLeft,
                            margin:EdgeInsets.fromLTRB( 10, 30, 0,0) ,
                            child: const Text(
                              'LOGIN TO  \nYOUR ACCOUNT',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            )),

                        Container(
                            alignment: Alignment.topLeft,
                            padding:EdgeInsets.fromLTRB(20, 15, 0, 0),
                            child: const Text(
                              'Your Email :',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            )),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: email_filed,
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
                            margin:EdgeInsets.fromLTRB( 10, 15, 0,0) ,
                            child:
                            ElevatedButton(
                              child: const Text('Login',style: TextStyle(
                                  color: Colors.black),),
                              onPressed: () {
                                try{

                                  Authentication.signin_with_email(email_filed.text.trim(),pass_filed.text.trim());
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));

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
                            margin:EdgeInsets.fromLTRB( 10, 10, 0,0) ,
                            child:ElevatedButton(
                              child: const Text('sign in with Google',style: TextStyle(
                                  color: Colors.black),),
                              onPressed: () {
                                // try{
                                //   Authentication.signInWithGoogle();
                                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>navie()));
                                // } catch(e){print(e);}
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
                              child: Text('Does not have account?'),),
                            Padding(padding: EdgeInsets.fromLTRB(15, 10, 10, 0),
                                child: TextButton(
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>signup()));
                                  },
                                ))
                          ],)
                      ],
                    ))))
    );

  }
}
