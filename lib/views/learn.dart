

import 'package:flutter/material.dart';
import 'package:quizzy/service/database.dart';
import 'package:video_viewer/video_viewer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Learn extends StatefulWidget {
  final String title;
  const Learn({Key? key, required this.title}) : super(key: key);
  

  @override
  State<Learn> createState() => _LearnState();
}

class _LearnState extends State<Learn>  with WidgetsBindingObserver{
  final Vcontroller = VideoViewerController();
  
  List video=[];
  void initState() {
    WidgetsBinding.instance?.addObserver(this); // <--
     DatabaseMethods().getVideo(widget.title).then((value){
      setState(() {
        video=value()['videoList'];
      });
      video=value()['videoList'];
     });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(widget.title,style: TextStyle(color: Colors.pink[300]),)),backgroundColor: Colors.yellowAccent,
      ),
  
     body:Column(
      children: [
        Text(widget.title),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('video').where('exp',isEqualTo: widget.title).snapshots(),
            builder:(context,  AsyncSnapshot snapshots) {
                 if(snapshots.hasData){
          
              
                
                video=snapshots.data!.docs[0].data()["videoList"];
                
           
               return ListView.builder(
              itemCount:video.length ,
              itemBuilder: (context,item){
                
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                              height: MediaQuery.of(context).size.height / 1.9,
                              width: MediaQuery.of(context).size.width / 1.2,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(width: 3),
                                  borderRadius: BorderRadius.all(Radius.circular(8))),
                              child: VideoViewer(
                                controller: Vcontroller,
                                source: {
                                  "SubRip Text": VideoSource(
                                    video: VideoPlayerController.network(video[item]),
                                  )
                                },
                              ),
                            ),
                  ],
                ),
              );
                      
            }
            );}
            else{
              return Container();
            }
            }
          ),
        ),
      ],
    )
    );
    
  }
}