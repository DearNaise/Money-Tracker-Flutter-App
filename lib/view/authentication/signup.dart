import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:checklist_app/widget_style/widget_color.dart';
import 'package:checklist_app/view/authentication/login.dart';
import '../../controller/signup_controller.dart';
import '../../model/signup_model.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  WidgetColor myColor = WidgetColor();
  SignupController signupController = SignupController();
  String? passwordError;
  String? usernameError;
  String? emailError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColor.mainBackground,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, size: 20,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 150,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Sign up",
                    style: TextStyle(
                      color: myColor.mainText,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    "Create a new account",
                    style: TextStyle(
                      fontSize: 15,
                      color: myColor.mainText.withOpacity(.5),
                    ),
                  ),
                ],
              ),

              Column(
                children: <Widget>[
                  inputFile(labelText: "Username", controller: usernameController, errorText: usernameError),
                  inputFile(labelText: "Email", controller: emailController, errorText: emailError),
                  inputFile(labelText: "Password", obscureText: true, controller: passwordController),
                  inputFile(labelText: "Confirm password", obscureText: true, controller: confirmPasswordController),

                  if (passwordError != null)
                    Text(
                      passwordError!,
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),

              // Sign up button
              Column(
                children: [
                  SizedBox(
                    height: 60,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: _handleSignup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: myColor.signupButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(color: Colors.black87),
                        ),
                      ),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: myColor.subText,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?  ", style: TextStyle(
                    color: myColor.mainText.withOpacity(.5),
                  ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final firebaseAuth = FirebaseAuth.instance;

                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(auth: firebaseAuth)));
                    },
                    child: Text("Login",
                      style: TextStyle(
                        color: myColor.mainText.withOpacity(.7),
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignup() {
    // Get user input
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    // Validate username
    if (username.isEmpty) {
      setState(() {
        usernameError = "Please enter a username";
      });
      return;
    } else {
      setState(() {
        usernameError = null;
      });
    }

    // Validate email
    if (email.isEmpty) {
      setState(() {
        emailError = "Please enter an email";
      });
      return;
    } else {
      setState(() {
        emailError = null;
      });
    }

    // Validate password
    if (password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        passwordError = "Please enter a password";
      });
      return;
    } else {
      setState(() {
        passwordError = null;
      });
    }

    // Validate password match
    if (password != confirmPassword) {
      setState(() {
        passwordError = "Passwords do not match. Please try again.";
      });
      return;
    }

    setState(() {
      passwordError = null;
    });

    // Call signup method
    signupController.signup(
      SignupData(
        username: username,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      ),
      context,
    );
  }
}

Widget inputFile({required String labelText, bool obscureText = false, required TextEditingController controller, String? errorText})
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15.0),
          labelText: labelText,
          errorText: errorText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      const SizedBox(height: 25,)
    ],
  );
}