import 'package:checklist_app/firebase_authentication.dart';
import 'package:checklist_app/view/home/navigation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:checklist_app/widget_style/widget_color.dart';
import 'package:checklist_app/view/authentication/signup.dart';


class LoginPage extends StatefulWidget {
  final FirebaseAuth auth;

  const LoginPage({Key? key, required this.auth}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  WidgetColor myColor = WidgetColor();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? emailError;
  String? passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColor.mainBackground,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 100,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    // Login title area
                    Column(
                      children: <Widget> [
                        Text("Login",
                          style: TextStyle(
                              color: myColor.mainText,
                              fontSize: 30, fontWeight: FontWeight.bold
                          ),),

                        Container(
                          height: 180,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/logo.png"),
                                fit: BoxFit.fitHeight
                            ),
                          ),
                        ),
                        Text(
                          "Login to your account",
                          style: TextStyle(
                            color: myColor.mainText.withOpacity(.5),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),

                    // Email & Password input area
                    const SizedBox(height: 10,),
                    Column(
                      children: <Widget>[
                        inputFile(labelText: "Email", controller: emailController, errorText: emailError),
                        inputFile(labelText: "Password", obscureText: true, controller: passwordController, errorText: passwordError),
                      ],
                    ),

                    // Login button
                    SizedBox(
                      height: 60,
                      width: 350,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myColor.loginButton,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: const BorderSide(color: Colors.black87),
                          ),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: myColor.subText,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account?  ", style: TextStyle(
                          color: myColor.mainText.withOpacity(.5),),),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                          },
                          child: Text("Signup",
                            style: TextStyle(
                              color: myColor.mainText.withOpacity(.7),
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Reset errors
    setState(() {
      emailError = null;
      passwordError = null;
    });

    // Check if email or password is empty
    if (email.isEmpty) {
      setState(() {
        emailError = 'Please enter an email';
      });
      return;
    }

    if (password.isEmpty) {
      setState(() {
        passwordError = 'Please enter a password';
      });
      return;
    }

    try {
      // Attempt to login with email and password
      await AuthModel().login({'email': email, 'password': password}, context);

      // If login is successful, navigate to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavBar()),
      );
    } catch (e) {
      // Handle exceptions and show an error dialog
      // Check for specific error types, or use generic error message
      _showErrorDialog('Login error: please try again');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget inputFile({required String labelText, bool obscureText = false, required TextEditingController controller, String? errorText})
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          key: Key('${labelText}_field'),
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
}