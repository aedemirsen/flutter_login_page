import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage(
      {Key? key,
      required this.signupFormKey,
      required this.signupEmailController,
      required this.signupPasswordController})
      : super(key: key);

  final GlobalKey<FormState>? signupFormKey;

  final TextEditingController? signupEmailController;

  final TextEditingController? signupPasswordController;

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(color: Colors.red),
    );
  }
}
