import 'package:dio/dio.dart';
import 'package:login/model/signin_response.dart';
import 'package:login/model/signup_response.dart';

abstract class IService {
  final Dio dio;

  IService(this.dio);

  final String endpoint = "/users";

  Future<SignInResponse?> getUserSignIn(SignInResponse model);

  Future<SignUpResponse?> postUserSignUp(SignUpResponse model);
}
