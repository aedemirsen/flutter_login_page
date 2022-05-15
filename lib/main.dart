import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/cubit/cubit.dart';
import 'package:login/firebase_options.dart';
import 'package:login/service/service.dart';
import 'package:login/view/signin_page.dart';
import 'config/config.dart' as conf;
import 'cubit/cubit.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    BlocProvider(
      create: (context) => LoginCubit(
        SigninState(),
        service: Service(Dio(BaseOptions(baseUrl: conf.baseUrl))),
        firebaseAuth: FirebaseAuth.instance,
      ),
      child: const LoginApp(),
    ),
  );
}

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
