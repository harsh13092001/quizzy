import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:quizzy/service/auth.dart';
import 'package:quizzy/views/Home.dart';
import 'package:quizzy/views/userdata.dart';
import 'package:quizzy/service/user.dart';

import 'SignIn.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController    passwordTextEditingController = new TextEditingController();
  TextEditingController otpTextEditingController = new TextEditingController();
  bool obscure_Text = true;

  void obscureText () async{
    setState(() {
      obscure_Text = !obscure_Text;
    });
  }
   EmailAuth emailAuth =  new EmailAuth(sessionName: "Sample session");
  void sendOtp() async {
   
  bool result = await emailAuth.sendOtp(
      recipientMail: emailTextEditingController.value.text, otpLength: 5
      );
  }
  void verifyOtp()async{
   bool verify= await  emailAuth.validateOtp(
        recipientMail: emailTextEditingController.value.text,
        userOtp: otpTextEditingController.value.text);
    if(verify==true){
      Auth().signUpWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text);
      User.mailid=emailTextEditingController.text;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>userInfo(mailId:emailTextEditingController.text,kidsName: userNameTextEditingController.text,)));
      
    }
  }
  @override
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
              height: MediaQuery.of(context).size.height / 2.2,
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
                        controller: userNameTextEditingController,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: "child name",
                          
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        )),
                    TextFormField(
                        controller: emailTextEditingController,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+")
                                  .hasMatch(val!)
                              ? null
                              : "Please sign in with  email Id";
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          suffixIcon: TextButton(
                              child: Text("Send OTP"),
                              // onPressed: () => sendOTP(),),
                              onPressed: () {
                                sendOtp();
                              }),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        )),
                        
                      TextFormField(
                          obscureText: obscure_Text ,
                          validator: (val) {
                            return val!.isNotEmpty && val.length > 6
                                ? null
                                : "Please provide a valid Password with 6+ character";
                          },
                          controller: passwordTextEditingController,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                          decoration: InputDecoration(hintText: "Password", suffixIcon: TextButton(child: obscure_Text? Text("Show"):Text("Hide"),
                            onPressed: () => obscureText(),),
                               focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors. black, width: 2.0),
                              borderRadius: BorderRadius. circular(20.0),
                            ),)),
                            TextFormField(
                            validator: (val) {
                                  return val!.length > 0
                                      ? null
                                      : "Please enter OTP";
                                },
                            

                                controller: otpTextEditingController,
                                style: TextStyle(color: Colors.black, fontSize: 14),
                                decoration: InputDecoration(hintText: "OTP",
                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors. black, width: 2.0),
                              borderRadius: BorderRadius. circular(20.0),
                            ),
                          )),
                          RaisedButton(onPressed: (){
                            verifyOtp();
                          },color: Colors.blue,
                          child: Text("Next"),),
                           TextButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignIn())));
            }, child: Text("signin"))
                  ],
                ),
              ),
            ),
           
          ],
        )));
  }
}
