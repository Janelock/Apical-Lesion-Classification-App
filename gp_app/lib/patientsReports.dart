import 'dart:io';
import 'package:gp_app/FullReports.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gp_app/scanScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';


class patientsReports extends StatefulWidget {
  String? user;
  patientsReports({super.key, required this.user});

  @override
  State<patientsReports> createState() => _patientsReports();
}

class _patientsReports extends State<patientsReports> {

  @override
  void initState() {
    super.initState();
  }
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
                  SizedBox(width: 65,),
                  Text("Patient Selection",
                    style: TextStyle(fontWeight: FontWeight.bold,
                        fontFamily: 'SegoeUI',
                        fontSize: 25,
                        color: Colors.black87),),
                ],),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 30,),
                  Text("Patient ID", style: TextStyle(color: Color(0xff2699A1),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 30, 0),
                      child: Container(
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                            suffixIcon: Icon(Icons.search),
                            hintText: 'Search by patient ID...',
                            hintStyle: TextStyle(color: Colors.black54,fontSize: 15),
                            border: InputBorder.none,
                          ),
                        ),
                        width: 250,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          // Circular shape
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Divider(color: Color(0xff2699a1), indent: 20, endIndent: 20,),
              SizedBox(height: 10,),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection(widget.user.toString()).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No data available'));
                  }

                  return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) => SizedBox(height: 20),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var patient = snapshot.data!.docs[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> FullReports(patientID: patient.id,user:  widget.user,)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25,0,25,0),
                          child: Container(
                            width: 370,
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.circle, color: Color(0xff2699a1), size: 15,),
                                SizedBox(width: 10,),
                                Text(
                                  patient.id,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff2699a1),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Expanded(
                                  child: Text(
                                    softWrap: false,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    patient['Name'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              )

            ],
          ),
        )
    );
  }
}
