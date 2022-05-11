import 'package:dio/dio.dart';
import 'package:login/model/signin_response.dart';
import 'package:login/model/signup_response.dart';
import 'package:login/model/user.dart';

abstract class IService {
  final Dio dio;

  IService(this.dio);

  final String endpoint = "/users";

  Future<SigninResponse?> getUserSignIn(User model);

  Future<SignUpResponse?> postUserSignUp(SignUpResponse model);
}
