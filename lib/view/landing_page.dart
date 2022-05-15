import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/cubit/cubit.dart';
import 'package:login/model/signin_response.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key, required this.model, required this.loginType})
      : super(key: key);

  final SigninResponse model;
  final String loginType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is GoogleSignoutSuccess) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return GestureDetector(
              child: const Icon(
                Icons.arrow_back_sharp,
                size: 40,
              ),
              onTap: () async {
                context.read<LoginCubit>().signoutWithGoogle();
              },
            );
          },
        ),
      ),
      body: Center(
        child: Text("Welcome,${model.email}"),
      ),
    );
  }
}
