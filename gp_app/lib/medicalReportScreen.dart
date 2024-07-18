import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gp_app/patientsScreen.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class medicalReportScreen extends StatefulWidget {
  XFile? imageFile;
  String? user;
  String? Diagnosis;

  medicalReportScreen({super.key,required this.imageFile,required this.user, required this.Diagnosis});


  @override
  State<medicalReportScreen> createState() => _medicalReportScreen();
}

class _medicalReportScreen extends State<medicalReportScreen> {

  final TextEditingController notes = TextEditingController();
  String formattedDate = DateFormat('yyyy-MM-dd – hh:mm a').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading:false,
            backgroundColor: Color(0xff2699A1),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(
                  AssetImage('assets/tooth logo.png'), color: Colors.white,),
                SizedBox(width: 5,),
                Text("A L C A", style: TextStyle(fontWeight: FontWeight.bold,
                    fontFamily: 'SegoeUI',
                    color: Colors.white),)
              ],
            )
        ),
        
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(onPressed: () {
                    Navigator.pop(context);
                  }, icon: Image.asset("assets/back.png")),
                  SizedBox(width: 80,),
                  Text("Medical Report", style: TextStyle(fontWeight: FontWeight.bold,
                      fontFamily: 'SegoeUI',
                      fontSize: 25,
                      color:Colors.black87 ),),
                ],),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    height: 350,
                    width: 340,
                    // Optional: to add padding inside the border
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff2699A1), // Border color
                        width: 3, // Border width
                      ),
                      borderRadius: BorderRadius.circular(
                          10), // Border radius (optional)
                    ),
                    child: Image.file(File(widget.imageFile!.path))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 40,),
                  Text("Diagnosis:",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 20),),
                  SizedBox(width: 20,),
                  Text(widget.Diagnosis.toString(),style: TextStyle(color: Color(0xff2699a1),fontWeight: FontWeight.bold,fontSize: 20),),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 40,),
                  Text("Date:",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 20),),
                  SizedBox(width: 20,),
                  Text(formattedDate,style: TextStyle(color: Color(0xff2699a1),fontWeight: FontWeight.bold,fontSize: 20),),
                ],
              ),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 25,),
                  Text("Notes",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 25),),
                  SizedBox(width: 20,),
                ],
              ),
              Divider(color: Color(0xff2699a1),indent: 20,endIndent: 20,),
              Padding(
                padding: const EdgeInsets.fromLTRB(40,8,40,8.0),
                child: SizedBox(
                  child: TextField(
                    controller: notes,
                    maxLines: null, // Expands to fit content
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Write your notes here...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              Divider(color: Color(0xff2699a1),indent: 20,endIndent: 20,),
              Row(
                children: [
                  SizedBox(width: 305,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            patientsScreen(
                              user: widget.user,
                          imageFile:widget.imageFile,
                          Diagnosis: widget.Diagnosis,
                          date_time: formattedDate,
                          Notes: notes.text,
                        )));
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Text("Next",style: TextStyle(color:Color(0xff2699A1),fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
                            SizedBox(width: 15,),
                            Column(
                              children: [
                                SizedBox(height: 5,),
                                Image.asset("assets/11.png",width: 17,height: 17,),
                              ],
                            )
                          ],
                        ),
                      ),
                  ),
                ],
              ),
              SizedBox(height:70)
            ],
          ),
        )
    );
  }
}
