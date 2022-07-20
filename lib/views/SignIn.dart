import 'package:flutter/material.dart';
import 'package:quizzy/views/signUp.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController    passwordTextEditingController = new TextEditingController();
  
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
                         RegExp(
                                 r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+")
                                  .hasMatch(val!)
                              ? null
                              : "Please sign in with  email Id";
                        },
                        controller: emailTextEditingController,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: "Email Id",
                          
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        )),
                    TextFormField(
                        controller: passwordTextEditingController,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+")
                                  .hasMatch(val!)
                              ? null
                              : "Please sign in with university email Id";
                        },
                        decoration: InputDecoration(
                          hintText: "phone number",
                          
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        )),
                        
                      
                          RaisedButton(onPressed: (){},color: Colors.blue,
                          child: Text("Next"),),
                           TextButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignUp())));
            }, child: Text("signUp"))
                  ],
                ),
              ),
            ),
          ],
        )));
    
    
  }
}