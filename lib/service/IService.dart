import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/model/signin_response.dart';
import 'package:login/model/signup_response.dart';
import 'package:login/model/user.dart' as user;

import '../model/google_signin_response.dart';
import '../model/signup_request.dart';

abstract class IService {
  final Dio dio;

  IService(this.dio);

  final String endpoint = "/users";

  Future<SigninResponse?> getUserSignIn(user.User model);

  Future<SignUpResponse?> postUserSignUp(SignupRequest model);

  Future<GoogleSigninResponse?> googleSignin(FirebaseAuth auth);
}
