import 'package:flutter/material.dart';
import 'package:login/model/signin_response.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key, required this.model}) : super(key: key);

  final SigninResponse model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Welcome,${model.email}"),
      ),
    );
  }
}
