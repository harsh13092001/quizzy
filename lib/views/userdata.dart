import 'package:flutter/material.dart';
import 'package:quizzy/views/Home.dart';

import '../service/database.dart';

class userInfo extends StatefulWidget {
  final String mailId;
  final String kidsName;
   userInfo({Key? key, required this.mailId, required this.kidsName}) : super(key: key);

  @override
  State<userInfo> createState() => _userInfoState();
}

class _userInfoState extends State<userInfo> {
  @override
  TextEditingController fatherNameController= new TextEditingController();
  TextEditingController motherNameController= new TextEditingController();
  TextEditingController phoneNumberController =new TextEditingController();
  void userinfo()async{
    Map<String, dynamic> profileMap = new Map<String, dynamic>();
      profileMap = {
        "Father's name":fatherNameController.text,
        "Mother's Name":motherNameController.text,
        "phone number":phoneNumberController.text,
        'mail id':widget.mailId,
        "child's name":widget.kidsName,
        'profile image':"https://firebasestorage.googleapis.com/v0/b/student-connect-5cd77.appspot.com/o/groupFile%2FIMG-20210820-WA0019.jpg?alt=media&token=d896ef63-a921-4124-b0c3-fc70de44cc9a",
        'DOB':"_",
        'School':"_",
        'class':"_",
        'Board':"_",
        'Address':"_",



      };
      await DatabaseMethods().saveUserData(profileMap);

      
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Quizzy",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                    color: Colors.pink[300],)),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                        validator: (val) {
                          return val!.isEmpty && val.length < 4
                              ? "Please enter a valid User Name!"
                              : null;
                        },
                        controller: fatherNameController,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: "Father's name",
                          
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        )),
                        TextFormField(
                        validator: (val) {
                          return val!.isEmpty && val.length < 4
                              ? "Please enter a valid User Name!"
                              : null;
                        },
                        controller: motherNameController,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: "Mother's name",
                          
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        )),
                    TextFormField(
                        controller: phoneNumberController,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        validator: (val) {
                          return val!.isEmpty && val.length < 10
                              ? "Please enter a phone number!"
                              : null;
                        },
                        decoration: InputDecoration(
                          hintText: "phone number",
                          
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        )),
                        
                      
                          RaisedButton(onPressed: (){
                            userinfo();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
      
                          },color: Colors.blue,
                          child: Text("Next"),)
                  ],
                ),
              ),
            ),
          ],
        )));
    
  }
}