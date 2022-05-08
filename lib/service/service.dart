import 'dart:io';

import 'package:dio/dio.dart';
import 'package:login/model/signup_response.dart';
import 'package:login/model/signin_response.dart';
import 'package:login/service/IService.dart';

class Service extends IService {
  Service(Dio dio) : super(dio);

  @override
  Future<SignInResponse?> getUserSignIn(SignInResponse model) async {
    final response = await dio.get(
      endpoint,
      queryParameters: {
        'email': model.email,
        'password': model.password,
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return SignInResponse.fromJson(response.data);
    } else {
      return null;
    }
  }

  @override
  Future<SignUpResponse?> postUserSignUp(SignUpResponse model) async {
    final response = await dio.post(endpoint, data: model);

    if (response.statusCode == HttpStatus.ok) {
      return SignUpResponse.fromJson(response.data);
    } else {
      return null;
    }
  }
}
