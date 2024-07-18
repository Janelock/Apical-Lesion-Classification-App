import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gp_app/patientsScreen.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FullReports extends StatefulWidget {
  String? patientID;
  String? user;

  FullReports({super.key,required this.patientID, required this.user});

  @override
  State<FullReports> createState() => _FullReports();
}

class _FullReports extends State<FullReports> {

  final TextEditingController notes = TextEditingController();
  String formattedDate = DateFormat('yyyy-MM-dd – hh:mm a').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
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

        body: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: () {
                  Navigator.pop(context);
                }, icon: Image.asset("assets/back.png")),
                SizedBox(width: 70,),
                Text("Medical Reports", style: TextStyle(fontWeight: FontWeight.bold,
                    fontFamily: 'SegoeUI',
                    fontSize: 25,
                    color: Colors.black87),),
              ],),
            SizedBox(height: 20,),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection(widget.patientID.toString()+" Reports").snapshots(),
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
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var report = snapshot.data!.docs[index];
                          return Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5), // Shadow color
                                  spreadRadius: 5, // Spread radius
                                  blurRadius: 7, // Blur radius
                                  offset: Offset(0, 3), // Changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 350,
                                      width: 340,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xff2699A1), // Border color
                                          width: 3, // Border width
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            10), // Border radius (optional)
                                      ),
                                      child: Image.network(report["ImageUrl"]),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 15,),
                                      Text("Diagnosis:", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20),),
                                      SizedBox(width: 20,),
                                      Text(report["Diagnosis"], style: TextStyle(color: Color(0xff2699a1), fontWeight: FontWeight.bold, fontSize: 20),),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 15,),
                                      Text("Date:", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20),),
                                      SizedBox(width: 20,),
                                      Text(report["Date_Time"], style: TextStyle(color: Color(0xff2699a1), fontWeight: FontWeight.bold, fontSize: 20),),
                                    ],
                                  ),
                                  SizedBox(height: 40,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Notes", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 25),),
                                    ],
                                  ),
                                  Divider(color: Color(0xff2699a1),),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(25, 8, 40, 8.0),
                                    child: Text(report["Notes"],textAlign: TextAlign.left,),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                    );
                  }
              ),
            ),
          ],
        )
    );
  }
}
