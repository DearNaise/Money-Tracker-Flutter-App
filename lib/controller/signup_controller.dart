import 'package:checklist_app/view/home/navigation.dart';
import 'package:flutter/material.dart';
import 'package:checklist_app/firebase_authentication.dart';
import '../../model/signup_model.dart';

class SignupController {
  final AuthModel authModel = AuthModel();

  Future<void> signup(SignupData data, BuildContext context) async {
    // Call createUser method
    await authModel.createUser({
      'username': data.username,
      'email': data.email,
      'password': data.password,
    }, context);
    // Navigate to next screen after successful signup
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NavBar()),
    );
  }
}