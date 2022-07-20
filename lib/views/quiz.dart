import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:quizzy/views/Home.dart';
 

 
class Quiz_ extends StatefulWidget {
  
  const Quiz_({Key? key}) : super(key: key);
 
  @override
  State<StatefulWidget> createState() {
    return _Quiz_State();
  }
}
 
class _Quiz_State extends State<Quiz_> {
  final _questions = const [
    {
      'questionText': 'Q1. Who created Flutter?',
      'answers': [
        {'text': 'Facebook', 'score': -2},
        {'text': 'Adobe', 'score': -2},
        {'text': 'Google', 'score': 10},
        {'text': 'Microsoft', 'score': -2},
      ],
    },
    {
      'questionText': 'Q2. What is Flutter?',
      'answers': [
        {'text': 'Android Development Kit', 'score': -2},
        {'text': 'IOS Development Kit', 'score': -2},
        {'text': 'Web Development Kit', 'score': -2},
        {
          'text':
              'SDK to build beautiful IOS, Android, Web & Desktop Native Apps',
          'score': 10
        },
      ],
    },
    {
      'questionText': ' Q3. Which programing language is used by Flutter',
      'answers': [
        {'text': 'Ruby', 'score': -2},
        {'text': 'Dart', 'score': 10},
        {'text': 'C++', 'score': -2},
        {'text': 'Kotlin', 'score': -2},
      ],
    },
    {
      'questionText': 'Q4. Who created Dart programing language?',
      'answers': [
        {'text': 'Lars Bak and Kasper Lund', 'score': 10},
        {'text': 'Brendan Eich', 'score': -2},
        {'text': 'Bjarne Stroustrup', 'score': -2},
        {'text': 'Jeremy Ashkenas', 'score': -2},
      ],
    },
    {
      'questionText':
          'Q5. Is Flutter for Web and Desktop available in stable version?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
  ];
 
  var _questionIndex = 0;
  var _totalScore = 0;
 
  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }
 
  void _answerQuestion(int score) {
    _totalScore += score;

      _questionIndex = _questionIndex + 1;
    
    // ignore: avoid_print
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      // ignore: avoid_print
      print('We have more questions!');
    } else {
      // ignore: avoid_print
      print('No more questions!');
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: const Text('quizzy',style: TextStyle(color: Color.fromRGBO(240, 98, 146, 1)),)),
          backgroundColor: Colors.yellowAccent,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                 itemCount: _questions.length,
            
                  itemBuilder: (context, item) {
              
              return
                
            
                 Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: _questionIndex < _questions.length
                      ? Quiz(
                          answerQuestion: _answerQuestion,
                          questionIndex: item,
                          questions: _questions,
                        ) //Quiz
                      :Container()// Result(_totalScore, _resetQuiz),
                );}
              ),
            ),
            RaisedButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
            child: Text("Submit"),)
          ],
        ), 
        //Padding
      ), //Scaffold
      
    ); //MaterialApp
  }
}
class Quiz extends StatefulWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;
 
   Quiz({
    Key? key,
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  }) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
 bool onpress= false;

 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Text(
        widget.questions[widget.questionIndex]['questionText'].toString(),
        style: const TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ), //Text
    ), //Contaier
       //Question
        ...(widget.questions[widget.questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (){
          print("Hi");
          setState(() {
            onpress=!onpress;
          });
          
          
        },
        style: ButtonStyle(
            textStyle:
               onpress ? MaterialStateProperty.all(const TextStyle(color: Colors.yellowAccent)):
               MaterialStateProperty.all(const TextStyle(color: Color.fromRGBO(76, 175, 80, 1))),
            backgroundColor: MaterialStateProperty.all(Colors.yellowAccent)
            ),
        child: Text(answer['text'].toString(),style: TextStyle(backgroundColor: onpress?Colors.yellow:Colors.pink),),
      ));
        }).toList()
      ],
    ); //Column
  }
}
