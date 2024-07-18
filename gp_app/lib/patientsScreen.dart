import 'dart:io';
import 'package:gp_app/transitionScreen.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gp_app/scanScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class patientsScreen extends StatefulWidget {
  XFile? imageFile;
  String? Notes;
  String? Diagnosis;
  String? date_time;
  String? user;
  patientsScreen({super.key,required this.imageFile, required this.Diagnosis,required this.date_time, required this.Notes, required this.user});

  @override
  State<patientsScreen> createState() => _patientsScreen();
}

class _patientsScreen extends State<patientsScreen> {

  Future<String?> uploadImg() async {
    final path = 'Images/${widget.imageFile!.name}';
    final file = File(widget.imageFile!.path);

    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(file);

    // Wait for upload to complete and return download URL
    TaskSnapshot snapshot = await uploadTask;
    String? downloadURL = await snapshot.ref.getDownloadURL();

    return downloadURL;
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
                  Text("Patient ID", style: TextStyle(color: Colors.black87,
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
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Container(
                                width: 250.0,
                                height: 30.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            patient.id,
                                            style: TextStyle(color: Color(0xff2699a1),fontWeight: FontWeight.bold),
                                          ),
                                          Text("   will be updated")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            content: Container(
                                              width: 250.0,
                                              height: 110.0,
                                              child: Center(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Center(child: CircularProgressIndicator(color: Color(0xff2699a1),)),
                                                    SizedBox(height: 20,),
                                                    Text("Updating..."),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );

                                        final CollectionReference collection =
                                        FirebaseFirestore.instance.collection(patient.id.toString()+" Reports");
                                        String documentId = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

                                        String? url = await uploadImg();

                                        Map<String, dynamic> data = {
                                            'ImageUrl': url,
                                            'Diagnosis':widget.Diagnosis,
                                            'Date_Time': widget.date_time,
                                            'Notes': widget.Notes,
                                        };

                                        collection.doc(documentId).set(data).then((value) {
                                            print('Document added with ID: $documentId');
                                          }).catchError((error) {
                                            print('Error adding document: $error');
                                          });

                                        Navigator.pop(context);
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            Future.delayed(Duration(seconds: 2), () {
                                              Navigator.of(context).pop(true);
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>transitionScreen(user: widget.user)));
                                            });
                                            return AlertDialog(
                                              content: Container(
                                                width: 250.0,
                                                height: 110.0,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Center(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 30.0,
                                                            backgroundColor: Color(0xff2699a1),
                                                            child: Icon(
                                                              Icons.check,
                                                              color: Colors.white,
                                                              size: 30.0,
                                                            ),
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Text("Updated successfully!")
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        );
                                      },
                                      child: Text("Confirm",),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
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
