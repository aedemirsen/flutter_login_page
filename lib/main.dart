import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/config/page_router.dart';
import 'package:login/cubit/cubit.dart';
import 'package:login/service/service.dart';
import 'package:login/view/landing_page.dart';
import 'package:login/view/signin_page.dart';
import 'config/config.dart' as conf;
import 'config/config.dart';
import 'cubit/cubit.dart';
import 'view/signup_page.dart';

void main() => runApp(
      BlocProvider(
        create: (context) => LoginCubit(
          SigninState(),
          service: Service(Dio(BaseOptions(baseUrl: conf.baseUrl))),
        ),
        child: const LoginApp(),
      ),
    );

class LoginApp extends StatelessWidget {
  const LoginApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      home: SigninPage(),
    );
  }
}
