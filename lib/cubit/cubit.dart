import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/model/google_signin_response.dart';
import 'package:login/model/signin_response.dart';
import 'package:login/model/signup_response.dart';
import 'package:bloc/bloc.dart';
import 'package:login/service/IService.dart';

import '../model/google_signin_response.dart';
import '../model/signup_request.dart';
import '../model/user.dart' as user;

class LoginCubit extends Cubit<LoginState> {
  //service
  final IService service;
  final FirebaseAuth firebaseAuth;

  bool isSigninFail = false;
  bool isSignupFail = false;
  bool isLoading = false;

  LoginCubit(LoginState initialState,
      {required this.service, required this.firebaseAuth})
      : super(initialState);

  Future<void> postUserModel(
    GlobalKey<FormState> signupFormKey,
    String mail,
    String password,
  ) async {
    if (signupFormKey.currentState!.validate()) {
      changeLoadingView(true);
      final data = await service.postUserSignUp(
        SignupRequest(email: mail, password: password),
      );
      changeLoadingView(false);
      if (data is SignUpResponse) {
        emit(SignupSuccessful(data));
      } else if (data == null) {
        emit(SignupFail());
      }
    } else {
      isSignupFail = true;
      emit(ValidationState(isSignupFail));
    }
  }

  Future<void> getUserModel(
    GlobalKey<FormState> signinFormKey,
    String mail,
    String password,
  ) async {
    if (signinFormKey.currentState!.validate()) {
      changeLoadingView(true);
      final data = await service.getUserSignIn(
        user.User(
          email: mail,
          password: password,
        ),
      );
      changeLoadingView(false);

      if (data is SigninResponse) {
        emit(SigninSuccessful(data));
      } else if (data == null) {
        emit(SigninFail());
      }
    } else {
      isSigninFail = true;
      emit(ValidationState(isSigninFail));
      isSigninFail = false;
    }
  }

  Future<void> signinWithGoogle() async {
    final data = await service.googleSignin(firebaseAuth);
    if (data is GoogleSigninResponse) {
      emit(GoogleSigninSuccess(data));
    } else if (data == null) {
      emit(GoogleSigninFail());
    }
  }

  Future<void> signoutWithGoogle() async {
    final data = await service.googleSignOut();
    if (data) {
      emit(GoogleSignoutSuccess());
    }
  }

  void changeLoadingView(bool b) {
    isLoading = b;
    emit(LoadingState(isLoading));
  }

  void navigateToSignup() {
    emit(SignupState());
  }
}

abstract class LoginState {}

class SigninState extends LoginState {}

class SignupState extends LoginState {}

class ValidationState extends LoginState {
  final bool validationSuccess;

  ValidationState(this.validationSuccess);
}

class LoadingState extends LoginState {
  final bool isLoading;

  LoadingState(this.isLoading);
}

class GoogleSigninSuccess extends LoginState {
  final GoogleSigninResponse model;

  GoogleSigninSuccess(this.model);
}

class GoogleSignoutSuccess extends LoginState {}

class SigninSuccessful extends LoginState {
  final SigninResponse model;

  SigninSuccessful(this.model);
}

class SigninFail extends LoginState {}

class GoogleSigninFail extends LoginState {}

class SignupFail extends LoginState {}

class SignupSuccessful extends LoginState {
  final SignUpResponse model;

  SignupSuccessful(this.model);
}
