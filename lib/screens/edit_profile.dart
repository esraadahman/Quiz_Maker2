import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_maker2/color.dart';
import 'package:quiz_maker2/screens/profile.dart';
import 'package:quiz_maker2/controls/firebase.dart';
import 'package:quiz_maker2/screens/profile.dart';
import '../widgit/logo.dart';
import 'Home.dart';

void main() {
  runApp(edit_info());
}

class edit_info extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<edit_info> {
  static final auth=FirebaseAuth.instance;
  String? fullname; String? username1; String? phonenumber;
  String? dateofbirth; String? locetion; String? userimage; bool? isolder16;
  List<dynamic>? posts;  List<dynamic>? stories;

  Future<void> get_user_info() async{
    await FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid).get().then((snapshot) {
      if(snapshot.exists){
        setState(() {
          fullname= snapshot.data()!['fullname'];
          username1 =snapshot.data()!['username'];
          dateofbirth =  snapshot.data()!['dateofbirth'];
          phonenumber =  snapshot.data()!['phone'];
          userimage =  snapshot.data()!['userimage'];
        });
      }
      else print("no data");

    });
  }






  void initState(){
    super.initState();
    get_user_info();
  }
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
    }
  }

  TextEditingController username = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController code = TextEditingController();

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor:  back_ground,
            appBar: AppBar(
              title:
              Row(children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>Home()),
                    );
                  },
                  child: Icon(
                    Icons.arrow_back_ios, color: buttomcolor,
                    size: 30, // Adjust size as needed
                  ),
                ),
                Padding( padding: EdgeInsets.only(left: 100), child: AppLogo(),),
              ]),
              elevation: 0.0,
              backgroundColor: Colors.transparent, systemOverlayStyle: SystemUiOverlayStyle.dark,
              //brightness: Brightness.li,
            ),
            body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 30) , child:
                    Row(children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(15, 10, 0, 0),
                        child:  Text(
                          'Edit ACCOUNT \n INFORMATION',
                          style: TextStyle(
                              color:  text_color,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        )),
                      Container(
                        margin: EdgeInsets.fromLTRB(100, 0, 0, 0),
                        width: 50.0, // Set the width of the container
                        height: 50.0, // Set the height of the container
                        child: GestureDetector(
                          onTap: () {
                            try {
                              String fullName = '${fname.text} ${lname.text}';
                              String date =
                                  "${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}";
                              firestore.Add_user_info(
                                  fullName,
                                  username.text.trim(), date,
                                  phone.text.trim(),
                                  "https://images.pexels.com/photos/417074/pexels-photo-417074.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
                              );
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => Home()));
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Icon(
                            Icons.check,
                            size: 40.0,
                            color: buttomcolor,
                          ),
                        ),
                      ),
                    ]),),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: Text(
                          '   user name',
                          style: TextStyle(
                              color: text_color,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        )),
                    Container(
                      width: 350,
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: TextField(
                        controller: username,
                        style: TextStyle(
                          color: text_color
                        ),
                        decoration: InputDecoration(
                          labelText: "$username1",
                          filled: true,
                          fillColor: text_color,
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

                        Column(children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                '   full name',
                                style: TextStyle(
                                    color: text_color,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                              )),
                          Container(
                            width: 350,
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: TextField(
                              controller: fname,
                              style: TextStyle(
                                color: text_color
                              ),
                              decoration: InputDecoration(
                                labelText: "$fullname",
                                filled: true,
                                fillColor: text_color,
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
                          margin: EdgeInsets.only(left: 10),
                          child:
                          Column(children: [
                            Container(
                              //alignment: Alignment.topLeft,
                                padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                child: Text(
                                  'phone',
                                  style: TextStyle(
                                      color: text_color,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                )),
                            Container(
                              width: 270,
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: TextField(
                                controller: phone,
                                style: TextStyle(
                                  color: text_color
                                ),
                                decoration: InputDecoration(
                                  labelText: "$phonenumber",
                                  filled: true,
                                  fillColor:  text_color,
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
                          ],)),

                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Row(children: [
                        Text(
                          'Selecte Date of Birth:',
                          style: TextStyle(fontSize: 15.0, color: text_color),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          '   ${_selectedDate.year}-${_selectedDate
                              .month}-${_selectedDate.day}      ',
                          style: TextStyle(fontSize: 15.0, color:  text_color),
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: Text('Select Date', style: TextStyle(
                              color: Colors.black),),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttomcolor),
                        ),
                      ],),),


                  ],
                ))));
  }
}
