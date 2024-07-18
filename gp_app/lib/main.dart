import 'package:flutter/material.dart';
import 'package:gp_app/FullReports.dart';
import 'package:gp_app/medicalReportScreen.dart';
import 'package:gp_app/patientsReports.dart';
import 'package:gp_app/patientsScreen.dart';
import 'package:gp_app/resultScreen.dart';
import 'package:gp_app/scanScreen.dart';
import 'package:gp_app/signIn.dart';
import 'package:gp_app/signUp.dart';
import 'package:gp_app/splashScreen.dart';
import 'package:gp_app/editingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gp_app/transitionScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: splashScreen(),
    );
  }

}
