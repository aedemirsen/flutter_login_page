import 'dart:io';

import 'package:dio/dio.dart';
import 'package:login/model/signup_response.dart';
import 'package:login/model/signin_response.dart';
import 'package:login/model/user.dart';
import 'package:login/service/IService.dart';

class Service extends IService {
  Service(Dio dio) : super(dio);

  @override
  Future<SigninResponse?> getUserSignIn(User model) async {
    if (model.email != "" && model.password != "") {
      final response = await dio.get(
        endpoint,
        queryParameters: {
          'email': model.email,
        },
      );
      //check whether password is correct
      if (response.statusCode == HttpStatus.ok &&
          response.data[0]['password'].toString() == model.password) {
        return SigninResponse.fromJson(response.data[0]);
      } else {
        return null;
      }
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
