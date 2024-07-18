import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gp_app/patientsReports.dart';
import 'package:gp_app/resultScreen.dart';
import 'package:gp_app/signIn.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class scanScreen extends StatefulWidget {
  String? user;
  scanScreen({super.key,required this.user});

  @override
  State<scanScreen> createState() => _scanScreenState();
}

class _scanScreenState extends State<scanScreen> {
  int? predictionResult;
  XFile? pickedImage;

  Future<void> _pickImage() async {
    final returnedImage=await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = returnedImage;
    });
  }

  Future<void> predictImage() async {
    String apiUrl = 'http://10.0.2.2:5000/predict';

    List<int> imageBytes = await pickedImage!.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    // Prepare request body
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {'image': base64Image};

    // Encode the body to JSON
    String jsonBody = jsonEncode(body);

    // Make POST request
    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: jsonBody);

      if (response.statusCode == 200) {
        // Handle successful response
        var prediction = jsonDecode(response.body);
        setState(() {
          predictionResult = prediction['prediction'];
          print("hooooooooooooooooooooooon");
          print(predictionResult);
        });
      } else {
        // Handle error response
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      print('Exception encountered: $e');
    }
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                  children: [
                    Container(
                      width: 220.0,
                      height: 220.0,
                      decoration: BoxDecoration(
                        color: Color(0xff2db1ba).withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async{
                        await _pickImage();
                        await predictImage();
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => resultScreen(
                                user: widget.user,
                                imageFile: pickedImage!,
                                pred: predictionResult!,
                              ),
                            ),
                          );
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> resultScreen(imageFile: pickedImage!,pred: predictionResult!,user: widget.user,)));
                      },
                      child: Container(
                        child: Center(
                          child: Icon(Icons.file_upload_outlined,color: Colors.white,size: 86,),
                        ),
                        width: 190.0,
                        height: 190.0,
                        decoration: BoxDecoration(
                          color: Color(0xff2699A1),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),),
                    ),
                  ]
              ),
              SizedBox(height: 20,),
              Text("Click here to upload your image",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SegoeUI',
                  fontSize: 17
                ) ,)
            ],
          ),
        )
    );
  }
}
