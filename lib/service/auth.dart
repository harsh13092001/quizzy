import "package:firebase_auth/firebase_auth.dart";
class Auth{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user ;

      if(result.user !=null){
       return true;
        

     }
    } catch (e) {
       //Fluttertoast.showToast(msg: "invalid username or password");
       
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if(result.user !=null){
       return true;
        

     }
    } catch (e) {
      print(e.toString());
    }
  }
  Future SignOut()async{
    return await _auth.signOut();
  }
}