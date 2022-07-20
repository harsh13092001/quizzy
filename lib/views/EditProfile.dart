import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'dart:ffi';
import "package:image_picker/image_picker.dart";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quizzy/service/database.dart';
import 'package:quizzy/views/Profile.dart';
class EditProfile extends StatefulWidget {
   Map<String, dynamic> profileMap ;
   EditProfile({Key? key, required this.profileMap}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;

        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }
  bool changeImage=false;
Stream? get_Image;
  XFile? image;
  String? image_url;
  String? x;
  Future getImage( ImageSource source) async {
    ImagePicker picker = ImagePicker();
     var img = await picker.pickImage(source: source,
  );//pickImage(source: source );
    setState(() {
      image = img;
    });
    var profileImage = await FirebaseStorage.instance.ref().child(image!.name);
    var task = await profileImage.putFile(File(image!.path));
    image_url = await (await task).ref.getDownloadURL();
    setState(() {
      image_url=image_url;
    });
    
    
  }
  
  

  Widget bottomSheet(){
    if(changeImage){
    return  BottomSheet(
        onClosing: () {
 
        },
        builder: (context) {
          return
     Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30
      ),
      child: Column(
          children:<Widget>[
            Text(
                "Choose Profile photo",
                style: TextStyle(
                    fontSize:20.0
                )
            ),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton.icon(onPressed: (){getImage(ImageSource.camera);}, icon: Icon(Icons.camera_alt), label: Text("Camera")),
                FlatButton.icon(onPressed: (){getImage(ImageSource.gallery);}, icon: Icon(Icons.image), label: Text("Gallery")),
              ],),
              Text("Tap again on image to roll down the sheet  ")

          ]
      ),
    );});}
    else{
      return Container(height: 0,);
    }
  }
  @override
  void initState() {
    image_url=widget.profileMap["profile image"];
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController childNameTextEditingController = new TextEditingController(text: widget.profileMap["child's name"]);
    TextEditingController FatherNameTextEditingController = new TextEditingController(text: widget.profileMap["Father's name"]);
    TextEditingController motherNameTextEditingController = new TextEditingController(text: widget.profileMap["Mother's Name"]);
    TextEditingController addressTextEditingController = new TextEditingController(text: widget.profileMap["Address"]);
    TextEditingController mailTextEditingController = new TextEditingController(text: widget.profileMap["mail id"]);
    TextEditingController phoneTextEditingController = new TextEditingController(text: widget.profileMap["phone number"]);
    TextEditingController schoolNameTextEditingController = new TextEditingController(text: widget.profileMap["School"]);
    TextEditingController classTextEditingController = new TextEditingController(text: widget.profileMap["class"]);
     
    return Scaffold(
       bottomSheet: bottomSheet(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
             
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap :() {setState(() {
                    changeImage=!changeImage;
                  });},
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Container(
                          width: 110.0,
                          height: 110.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            image: DecorationImage(
                                image:  NetworkImage(image_url!),
                                fit: BoxFit.cover),
                          )),
                    ),
                    ),
                GestureDetector(
                  onTap :() {setState(() {
                    changeImage=!changeImage;
                  });},
                  child: Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Text('Change Photo',
                        style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ),
                  )
              ],
            ),
              
              TextFormField(
                            validator: (val) {
                              return val!.isEmpty && val.length < 4
                                  ? "Please enter a valid User Name!"
                                  : null;
                            },
                            controller: childNameTextEditingController,
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
                            validator: (val) {
                              return val!.isEmpty && val.length < 4
                                  ? "Please enter a valid User Name!"
                                  : null;
                            },
                            controller: FatherNameTextEditingController,
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
                            controller: motherNameTextEditingController,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: "mother name",
                              
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
                            controller: addressTextEditingController,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: " address",
                              
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
                            controller: mailTextEditingController,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: "mail id",
                              
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
                            controller: phoneTextEditingController,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: "phone number",
                              
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
                            controller: schoolNameTextEditingController,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: "school name",
                              
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
                            controller: classTextEditingController,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: " class",
                              
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            )),
                      Container(
                          height:5
                      ),
                      Container(
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(30.0),
                                ),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.blue),
                              // hintText: "Name",
                              fillColor: Color(0xFF8F48F7),),
                          value: board,
                          onChanged: (String? newValue) {
                            setState(() {
                              board = newValue;
                            });
                          },
          
                          style: const TextStyle(color: Colors.blue),
                          selectedItemBuilder: (BuildContext context) {
                            return options!.map((String value) {
                              return Text(
                                board!,
                                style: const TextStyle(color: Colors.white),
                              );
                            }).toList();
                          },
                          items: options.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Column(
                              children: <Widget>[
                                Text(
                                  'Choose DOB',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5),
                                ),
                                InkWell(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 5,
                                    height: MediaQuery.of(context).size.height / 15,
                                    margin: EdgeInsets.only(top: 30),
                                    alignment: Alignment.center,
                                    decoration:
                                    BoxDecoration(color: Colors.grey[200]),
                                    child: TextFormField(
                                      style: TextStyle(
                                          fontSize:
                                          _dateController.text.isEmpty ? 0 : 20),
                                      textAlign: TextAlign.center,
                                      enabled: false,
                                      keyboardType: TextInputType.text,
                                      controller: _dateController,
                                      onSaved: (String? val) {
                                        _setDate = val!;
                                      },
                                      decoration: InputDecoration(
                                          disabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide.none),
                                          
                                          contentPadding: EdgeInsets.only(top: 0.0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
          
              RaisedButton(onPressed: ()async{
                widget.profileMap = {
            "Father's name":FatherNameTextEditingController.text,
            "Mother's Name":motherNameTextEditingController.text,
            "phone number":phoneTextEditingController.text,
            'mail id':mailTextEditingController.text,
            "child's name":childNameTextEditingController.text,
            'profile image':image_url,
            'DOB': _dateController.text,
            'School':schoolNameTextEditingController.text,
            'class':classTextEditingController.text,
            'Board':board,
      
      
      
          };
             await  DatabaseMethods().updateUserData(widget.profileMap);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => Profile())));
      
          
              },
              child:Text("save"))
            ]),
        ),
      )

    );
    
  }
}