

import 'package:flutter/material.dart';
import 'package:quizzy/service/database.dart';
import 'package:quizzy/views/EditProfile.dart';
import 'package:quizzy/service/database.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizzy/service/user.dart';
import 'package:quizzy/views/signin.dart';
class Profile extends StatefulWidget {
  
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<String> options = <String>['ICSE','CBSE','State Board','IGCSE','NIOS','Others'];
  String? board='Others';
  String? _setDate;
  TextEditingController _dateController = TextEditingController();
   DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;

        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("profile",style: TextStyle(color: Colors.pink[300]),)),),
      body: StreamBuilder(
        stream:FirebaseFirestore.instance.collection("user").where('mail id',isEqualTo:User.mailid).snapshots(),
  
        builder: (context, AsyncSnapshot snapshots){
          if(snapshots.hasData){
        return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Container(
                          width: 110.0,
                          height: 110.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            image: DecorationImage(
                                image:  NetworkImage(snapshots.data!.docs[0].data()["profile image"]),
                                fit: BoxFit.cover),
                          )),
                    ),
          Row(
            children: [
              Text("Kids Name:",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16),),
              Text(snapshots.data!.docs[0].data()["child's name"])
            ],
          ),
           Row(
            children: [
              Text("Father's Name:",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16),),
              Text(snapshots.data!.docs[0].data()["Father's name"])
            ],
          ),
          Row(
            children: [
              Text("Mother's Name:",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16),),
              Text(snapshots.data!.docs[0].data()["Mother's Name"])
            ],
          ),
          Row(
            children: [
              Text("Addess:",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16),),
              Text(snapshots.data!.docs[0].data()["Address"])
            ],
          ),
          Row(
            children: [
              Text("School:",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16),),
              Text(snapshots.data!.docs[0].data()["School"])
            ],
          ),
          Row(
            children: [
              Text("Class:",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16),),
              Text(snapshots.data!.docs[0].data()["class"])
            ],
          ),
          
                  Container(
                      height:5
                  ),Row(
            children: [
              Text("board:",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16),),
              Text(snapshots.data!.docs[0].data()["Board"])
            ],
          ),
          Row(
            children: [
              Text("Dob:",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16),),
              Text(snapshots.data!.docs[0].data()["DOB"])
            ],
          ),
      
          RaisedButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => EditProfile(profileMap: snapshots.data.docs[0].data(),))));
      
          },
          child:Text("edit")),
           RaisedButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignIn())));
      
          },
          child:Text("Logout")),
        ]);}
        else{
          return Container();
        }}
      ),
    );
    
  }
}