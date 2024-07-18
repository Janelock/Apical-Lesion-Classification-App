import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gp_app/scanScreen.dart';
import 'package:gp_app/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gp_app/transitionScreen.dart';

class signUp extends StatefulWidget{
  @override
  State<signUp> createState() => _signUp();
}

class _signUp extends State<signUp> {
  bool _obscureText = false;
  final  auth = FirebaseAuth.instance;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController userName = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        resizeToAvoidBottomInset : false,
        body: Stack(
            children: [
              Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bg3.png'),
                      fit: BoxFit.cover,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(40,0,40,0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 200,),
                    Text("Create\naccount",style: TextStyle(color: Colors.white,fontSize: 40, fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
                    SizedBox(height: 135,),
                    TextFormField(
                      controller: userName,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey,fontFamily: 'SegoeUI'),
                        labelText: 'Name',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 20.0), // Adjust left padding for the prefix icon
                          child: Image.asset("assets/name icon.png"),
                        ),
                        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                        contentPadding: EdgeInsets.only(bottom: 0,top:0), // Adjust the bottom padding as needed
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff2699A1),width: 2.2)
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff2699A1)), // Border color when focused
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey,fontFamily: 'SegoeUI'),
                        labelText: 'Example@gmail.com',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 20.0), // Adjust left padding for the prefix icon
                          child: Image.asset("assets/email icon.png"),
                        ),
                        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                        contentPadding: EdgeInsets.only(bottom: 0,top:0), // Adjust the bottom padding as needed
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff2699A1),width: 2.2)
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff2699A1)), // Border color when focused
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: password,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey,fontFamily: 'SegoeUI'),
                        labelText: 'Password',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 20.0), // Adjust left padding for the prefix icon
                          child: Image.asset("assets/password icon.png"),
                        ),
                        contentPadding: EdgeInsets.only(bottom: 0,top:0), // Adjust the bottom padding as needed
                        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility : Icons.visibility_off,color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff2699A1),width: 2.2)
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff2699A1)), // Border color when focused
                        ),
                      ),
                    ),
                    SizedBox(height: 25,),
                    ElevatedButton(
                      onPressed: () async {
                        try{
                          await auth.createUserWithEmailAndPassword(email: email.text, password: password.text);
                          print("created new user");

                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  transitionScreen(user: email.text,)));
                        }
                        catch(e){
                          print(e);
                        }
                      },
                      child: Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 17,fontFamily: 'SegoeUI',fontWeight: FontWeight.bold),),
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Adjust the corner radius here
                          ),
                          backgroundColor: Color(0xff2699A1), // Background color of the button
                          minimumSize: Size(double.infinity, 45)
                      ),),
                    Row(
                        children: <Widget>[
                          Expanded(
                              child: Divider()
                          ),

                          Text("  OR  ",style: TextStyle(color: Colors.grey,fontWeight:FontWeight.bold,fontFamily: 'SegoeUI'),),

                          Expanded(
                              child: Divider()
                          ),
                        ]
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => signIn()),
                        );
                      },
                      child: Text('Log In',style: TextStyle(color: Color(0xff2699A1),fontSize: 17,fontFamily: 'SegoeUI',fontWeight: FontWeight.bold),),
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xff2699A1),width: 2.2),
                            borderRadius: BorderRadius.circular(10), // Adjust the corner radius here
                          ),
                          backgroundColor: Colors.white, // Background color of the button
                          minimumSize: Size(double.infinity, 45)
                      ),),
                  ],
                ),
              )
            ]
        ));
  }
}