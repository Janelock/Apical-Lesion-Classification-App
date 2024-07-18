import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gp_app/signIn.dart';

class profileScreen extends StatefulWidget {
  String? user;
  profileScreen({super.key,required this.user});

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
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

        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(onPressed: () {
                    Navigator.pop(context);
                  }, icon: Image.asset("assets/back.png")),
                  SizedBox(width: 120,),
                  Text("Profile",
                    style: TextStyle(fontWeight: FontWeight.bold,
                        fontFamily: 'SegoeUI',
                        fontSize: 25,
                        color: Colors.black87),),
                ],),
              SizedBox(height: 10,),
              Divider(color: Color(0xff2699a1), indent: 20, endIndent: 20,),
              SizedBox(height: 20,),
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 15,),
                  CircleAvatar(radius: 60,
                    backgroundImage: AssetImage("assets/tooth.jpg"),
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 26,),
                      Text(widget.user!, style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: 'SegoeUI',
                      ),
                      ),
                      Text("Dentist", style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'SegoeUI',))
                    ],
                  ),

                ],
              ),
              SizedBox(height: 350,),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0,0,30,0),
                child: Container(
                  width: double.infinity,
                  child:  ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> signIn()));

                      } catch (e) {
                        print('Error signing out: $e');
                      }
                    },
                    child: Text('Sign Out',style: TextStyle(color: Colors.white,fontSize: 17,fontFamily: 'SegoeUI',fontWeight: FontWeight.bold),),
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Adjust the corner radius here
                        ),
                        backgroundColor: Colors.redAccent, // Background color of the button
                        minimumSize: Size(double.infinity, 45)
                    ),),
                ),
              )
            ],
          ),
        )
    );
  }
}
