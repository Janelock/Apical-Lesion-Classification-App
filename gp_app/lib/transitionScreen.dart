import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gp_app/patientsReports.dart';
import 'package:gp_app/profileScreen.dart';
import 'package:gp_app/resultScreen.dart';
import 'package:gp_app/scanScreen.dart';
import 'package:gp_app/signIn.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class transitionScreen extends StatefulWidget {
  String? user;
  transitionScreen({super.key,required this.user});

  @override
  _transitionScreenState createState() => _transitionScreenState();
}

class _transitionScreenState extends State<transitionScreen> {
  int selectedIndex=1;
  late List screens;

  @override

  void initState() {
    screens=[profileScreen(user: widget.user,), scanScreen(user: widget.user,),patientsReports(user: widget.user,)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int indx){
          setState(() {
            selectedIndex=indx;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Image.asset("assets/Vector-1.png",color: Color(0xff2699A1),),
            icon: Image.asset("assets/Vector-1.png",width: 25,height: 27,),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset("assets/home.png",color: Color(0xff2699A1)),
            icon: Image.asset("assets/home.png",color: Colors.grey,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/database.png"),
            activeIcon: Image.asset("assets/database.png",color: Color(0xff2699A1)),
            label: '',
          ),
        ],
      ),
    );
  }
}
