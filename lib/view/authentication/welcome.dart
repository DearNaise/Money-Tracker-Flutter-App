import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:checklist_app/widget_style/widget_color.dart';
import 'package:checklist_app/view/authentication/login.dart';
import 'package:checklist_app/view/authentication/signup.dart';

class WelcomePage extends StatelessWidget{

  @override
  Widget build (BuildContext context){
    WidgetColor myColor = WidgetColor();

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: <Widget> [
                Column(
                  children: <Widget>[
                    Text(
                      "Focus Point",
                      style: TextStyle(
                        color: myColor.mainText,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/logo.png"),
                      )
                  ),
                ),
                Column(
                  children: [
                    //Login button
                    SizedBox(
                      height: 60,
                      width: 350,
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(auth: FirebaseAuth.instance),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myColor.loginButton, // Set your button color here
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Colors.black87),
                          ),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: myColor.subText,
                              fontWeight: FontWeight.w600,
                              fontSize: 18
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 25), // for padding space between buttons

                    //Signup button
                    SizedBox(
                      height: 60,
                      width: 350,
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myColor.signupButton, // Set your button color here
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Colors.black87),
                          ),
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: myColor.subText,
                              fontWeight: FontWeight.w600,
                              fontSize: 18
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}