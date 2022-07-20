
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizzy/service/user.dart';
class DatabaseMethods{
  getUserData()async{
    return await FirebaseFirestore.instance.collection("user").where('mail id',isEqualTo: User.mailid).snapshots();
  }
   saveUserData(userMap)async{
    return await FirebaseFirestore.instance.collection("user").add(userMap);
  }
   updateUserData(userMap)async{
    return await FirebaseFirestore.instance.collection("user").doc(User.mailid).update(userMap);}
  getVideo(String video)async{
    return await FirebaseFirestore.instance.collection('video').where('exp',isEqualTo: video).snapshots();
  }


}