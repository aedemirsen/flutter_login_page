import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/config/page_router.dart';
import 'package:login/cubit/cubit.dart';
import 'package:login/service/service.dart';
import 'package:login/view/landing_page.dart';
import 'package:login/view/signin_page.dart';
import 'config/config.dart' as conf;
import 'view/signup_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      home: Scaffold(
        body: LoginApp(),
      ),
    );
  }
}

class LoginApp extends StatelessWidget {
  final GlobalKey<FormState> signinFormKey = GlobalKey();

  final GlobalKey<FormState> signupFormKey = GlobalKey();

  final TextEditingController signinEmailController = TextEditingController();

  final TextEditingController signinPasswordController =
      TextEditingController();

  final TextEditingController signupEmailController = TextEditingController();

  final TextEditingController signupPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        SigninState(),
        signinEmailController,
        signinPasswordController,
        signupEmailController,
        signupPasswordController,
        signinFormKey,
        signupFormKey,
        service: Service(Dio(BaseOptions(baseUrl: conf.baseUrl))),
      ),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is SignupState) {
            PageRouter.changePageWithAnimation(
              context,
              SignupPage(
                signupFormKey: signupFormKey,
                signupEmailController: signupEmailController,
                signupPasswordController: signupPasswordController,
              ),
              PageRouter.downToUp,
            );
          } else if (state is SigninSuccessful) {
            PageRouter.changePageWithAnimation(
              context,
              LandingPage(
                model: state.model,
              ),
              PageRouter.leftToRight,
            );
          }
        },
        builder: (context, state) {
          return SigninPage(
            signinFormKey: signinFormKey,
            signinEmailController: signinEmailController,
            signinPasswordController: signinPasswordController,
          );
        },
      ),
    );
  }
}
