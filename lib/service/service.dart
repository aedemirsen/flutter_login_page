import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/model/google_signin_response.dart';
import 'package:login/model/signup_response.dart';
import 'package:login/model/signin_response.dart';
import 'package:login/model/user.dart' as user;
import 'package:login/service/IService.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/signup_request.dart';

class Service extends IService {
  Service(Dio dio) : super(dio);

  @override
  Future<SigninResponse?> getUserSignIn(user.User model) async {
    if (model.email != "" && model.password != "") {
      try {
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
        }
      } on Exception {
        return null;
      }
    }
    return null;
  }

  @override
  Future<SignUpResponse?> postUserSignUp(SignupRequest model) async {
    try {
      final response = await dio.post(endpoint, data: model);

      if (response.statusCode == HttpStatus.created) {
        return SignUpResponse.fromJson(response.data);
      }
    } on Exception {
      return null;
    }
    return null;
  }

  @override
  Future<GoogleSigninResponse?> googleSignin(FirebaseAuth auth) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');

        await auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );
          UserCredential userCredential =
              await auth.signInWithCredential(credential);

          return GoogleSigninResponse(
              name: userCredential.user?.displayName,
              mail: userCredential.user?.email,
              uid: userCredential.user?.uid);
        }
      }
    } on Exception {
      return null;
    }
    return null;
  }
}
