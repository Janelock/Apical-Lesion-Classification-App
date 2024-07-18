import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gp_app/scanScreen.dart';
import 'package:gp_app/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gp_app/transitionScreen.dart';

class signIn extends StatefulWidget{
  @override
  State<signIn> createState() => _signIn();
}

class _signIn extends State<signIn> {
  bool _obscureText = true;
  final auth = FirebaseAuth.instance;
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
      image: AssetImage('assets/bg2.png'),
      fit: BoxFit.cover,
      ),
      )),
      Padding(
        padding: const EdgeInsets.fromLTRB(40,0,40,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 230,),
            Text("Welcome \nback!",style: TextStyle(color: Colors.white,fontSize: 40, fontWeight: FontWeight.bold,fontFamily: 'SegoeUI'),),
            SizedBox(height: 135,),
            TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
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
                fillColor: Colors.white.withOpacity(0.8),
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
                labelStyle: TextStyle(color: Colors.grey, fontFamily: 'SegoeUI'),
                labelText: 'Password',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 20.0), // Adjust left padding for the prefix icon
                  child: Image.asset("assets/password icon.png"),
                ),
                contentPadding: EdgeInsets.only(bottom: 0,top:0), // Adjust the bottom padding as needed
                prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff2699A1),width: 2.2)
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff2699A1)), // Border color when focused
                ),
              ),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    // Action to perform when text is clicked
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontFamily: 'SegoeUI',
                      color: Color(0xff2699A1),
                      fontSize: 13,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25,),
            ElevatedButton(
              onPressed: () async {
                try{
                  await auth.signInWithEmailAndPassword(email: email.text, password: password.text);
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          transitionScreen(user: email.text,)));
                }
                catch(e){
                  print(e);
                }
              },
              child: Text('Log In',style: TextStyle(color: Colors.white,fontSize: 17,fontFamily: 'SegoeUI', fontWeight: FontWeight.bold),),
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
                  MaterialPageRoute(builder: (context) => signUp()),
                );
              },
              child: Text('Sign Up',style: TextStyle(color: Color(0xff2699A1),fontSize: 17,fontFamily: 'SegoeUI',fontWeight: FontWeight.bold),),
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