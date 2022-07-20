import'package:flutter/material.dart';
import 'package:quizzy/views/learn.dart';
import 'quiz.dart';
import 'Profile.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  @override
  List experiment=['lava lamp',"making a Volcano","Dry erase",'orange fizz','supper cool soda'];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("experiments",style: TextStyle(color: Colors.pink[300]),)),backgroundColor: Colors.yellowAccent,
      actions: [Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: (() {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Profile()));
            
          }),
          child: CircleAvatar(radius: 10,child: Icon(Icons.person))
          ),
      ),
      
        ],),
     body:ListView.builder(
      itemCount: experiment.length,

      itemBuilder: (context, item) {
        
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
             
             showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Open'),
          content: const Text('would you like to open quiz or Experiment'),
          actions: <Widget>[
            TextButton(
              onPressed: () =>Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex)=>Quiz_())),
              child: const Text('quiz'),
            ),
            TextButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex)=>Learn(title:experiment[item]))),
              child: const Text('Experiment'),
            ),
          ],
        ),
      );
            },
            child: Container(
              decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 220, 223, 224),
                                        offset: const Offset(
                                          0.0,
                                          5.0,
                                        ),
                                        blurRadius: 10.0,
                                        spreadRadius: 2.0,
                                      ),
                                      BoxShadow(
                                        color: Colors.white,
                                        offset: const Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      ), //BoxShadow
                                    ],
                                  ),
              height: MediaQuery.of(context).size.height/9,
              child:Center(
                
                child:Text(experiment[item],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)
              )
            ),
          ),
        );
      },
    ));
    
  }
}