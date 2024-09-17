import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_maker2/screens/Home.dart';
import '../color.dart';
import '../firebase_options.dart';
import '../navi.dart';
import 'package:path/path.dart';
import 'package:quiz_maker2/controls/firebase.dart';

import '../widgit/logo.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(signup_info());
}

class signup_info extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<signup_info> {

  DateTime _selectedDate = DateTime.now(); // Initial selected date

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }}



  TextEditingController username = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController code = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    fname.dispose();
    lname.dispose();
    username.dispose();
    phone.dispose();
    code.dispose();
  }


  bool getimage = false;
  File? file;
  TextEditingController title = TextEditingController();
  String url = "hassan";

  UploadImage_gallery() async {
    try{
      ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          file = File(image!.path);
          getimage = true;
        });

        var metadata = SettableMetadata(
          contentType: "image/jpeg",
        );
        var imgname = basename(image.path);
        var ref = FirebaseStorage.instance.ref(imgname);
        await ref.putFile(file!, metadata);
        var downloadUrl = await ref.getDownloadURL();

        setState(() {
          // Update the URL after retrieval
          url = downloadUrl;
        });
      }
    }
    catch(error) {
      print("error: $error");
    }
  }

  UploadImage_camera() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        file = File(image!.path);
        getimage = true;
      });

      var metadata = SettableMetadata(
        contentType: "image/jpeg",
      );
      var imgname = basename(image.path);
      var ref = FirebaseStorage.instance.ref(imgname);
      await ref.putFile(file!, metadata);

      url = await ref.getDownloadURL();
    }
  }

  Widget upload_way() {
    return Container(
      padding: EdgeInsets.all(15),
      width: 300,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color:  Colors.black,
          width: 2,
        ),
      ),
      child:
      Center(
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () async {
                  await UploadImage_gallery();
                },
                child: Container(
                  height: 90,
                  width: 120,
                  decoration: BoxDecoration(
                    color:  Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Icon(Icons.image, size: 40, color:  Colors.blue[900]),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Add from gallery',
                        style: TextStyle(
                            color:  Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () async {
                  await UploadImage_camera();
                },
                child: Container(
                  height: 90,
                  width: 120,
                  decoration: BoxDecoration(
                    color:  Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Icon(Icons.camera,
                          size: 40, color:  Colors.blue[900]),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Add from Camera',
                        style: TextStyle(
                            color:  Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(

              title: Center(child: AppLogo(),),
              elevation: 0.0,
              backgroundColor: Colors.transparent, systemOverlayStyle: SystemUiOverlayStyle.dark,
              //brightness: Brightness.li,
            ),
            body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child:
                      Row(children: [
                        Padding(padding: EdgeInsets.only(left: 20, right: 40),
                          child: Icon(Icons.arrow_back_ios, color: Colors.black,
                            size: 30,),),
                        Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: Text(
                              '   ACCOUNT \n INFORMATION',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            )),
                      ]),),
                    SizedBox(
                      height: 20,
                    ),
                    getimage?
                    GestureDetector(
                      onTap: () {
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:FileImage(file!),
                      ),
                    )
                        :
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          SmartDialog.show(builder: (context) {
                            return upload_way();
                          });

                        });
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:NetworkImage("https://th.bing.com/th/id/R.c98530977183534ed0e49e6db725bd7d?rik=qRXJBwOokn7dSQ&pid=ImgRaw&r=0"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: Text(
                          '   user name',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        )),
                    Container(
                      width: 350,
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: TextField(
                        controller: username,
                        decoration: InputDecoration(
                          labelText: "User Name",
                          filled: true,
                          fillColor: Colors.grey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Column(children: [
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                'first name',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                              )),
                          Container(
                            width: 180,
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: TextField(
                              controller: fname,
                              decoration: InputDecoration(
                                labelText: "First Name",
                                filled: true,
                                fillColor: Colors.grey,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 0.3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                        Container(
                            margin: EdgeInsets.only(left: 20),
                            child:
                            Column(children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                                  child: Text(
                                    'last name',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  )),
                              Container(
                                width: 180,
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: TextField(
                                  controller: lname,
                                  decoration: InputDecoration(
                                    labelText: "Last Name",
                                    filled: true,
                                    fillColor: Colors.grey,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 0.3,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ])),
                      ],
                    ),

                    Row(children: [
                      Column(children: [
                        Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              'code',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            )),
                        Container(
                          width: 100,
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: TextField(
                            controller: code,
                            decoration: InputDecoration(
                              labelText: "Code",
                              filled: true,
                              fillColor: Colors.grey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 0.3,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child:
                          Column(children: [
                            Container(
                              //alignment: Alignment.topLeft,
                                padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                child: Text(
                                  'phone',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                )),
                            Container(
                              width: 270,
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: TextField(
                                controller: phone,
                                decoration: InputDecoration(
                                  labelText: "Phone",
                                  filled: true,
                                  fillColor: Colors.grey,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 0.3,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],))
                    ],),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Row(children: [
                        Text(
                          'Selecte Date of Birth:',
                          style: TextStyle(fontSize: 15.0, color:Colors.black),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          '   ${_selectedDate.year}-${_selectedDate
                              .month}-${_selectedDate.day}      ',
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: Text('Select Date', style: TextStyle(
                              color: Colors.black),),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey),
                        ),
                      ],),),


                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 40,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          try{
                            String fullName = '${fname.text} ${lname.text}';
                            String date = "${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}";
                            String phone_number="${code.text} ${phone.text}";
                            firestore.Add_user_info(fullName,username.text.trim(),phone_number,
                                date, url,
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));

                          }
                          catch(e){
                            print(e);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        child:  Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}
