import 'package:flutter/material.dart';
import 'package:login/model/signin_response.dart';
import 'package:login/model/signup_response.dart';
import 'package:bloc/bloc.dart';
import 'package:login/service/IService.dart';

import '../model/user.dart';

class LoginCubit extends Cubit<LoginState> {
  //sign in
  final TextEditingController signInMailController;
  final TextEditingController signInPasswordController;
  //sign up
  final TextEditingController signUpMailController;
  final TextEditingController signUpPasswordController;
  //form keys
  final GlobalKey<FormState> signinFormKey;
  final GlobalKey<FormState> signupFormKey;

  //service
  final IService service;

  bool isLoginFail = false;
  bool isLoading = false;

  LoginCubit(
      LoginState initialState,
      this.signInMailController,
      this.signInPasswordController,
      this.signUpMailController,
      this.signUpPasswordController,
      this.signinFormKey,
      this.signupFormKey,
      {required this.service})
      : super(initialState);

  Future<void> postUserModel() async {
    // if (signinFormKey.currentState != null &&
    //     signupFormKey.currentState!.validate()) {
    //   changeLoadingView();
    //   final data = await service.postUserLogin(LoginRequest(
    //       email: emailController.text.trim(),
    //       password: passwordController.text.trim()));
    //   changeLoadingView();

    //   if (data is LoginResponse) {
    //     emit(LoginSuccess(data));
    //   }
    // } else {
    //   isLoginFail = true;
    //   emit(LoginValidateState(isLoginFail));
    // }
  }

  Future<void> getUserModel() async {
    if (signinFormKey.currentState !=
            null /*&&
        signupFormKey.currentState!.validate()*/
        ) {
      changeLoadingView(true);
      final data = await service.getUserSignIn(
        User(
          email: signInMailController.text,
          password: signInPasswordController.text,
        ),
      );
      changeLoadingView(false);

      if (data is SigninResponse) {
        emit(SigninSuccessful(data));
      }
    } else {
      isLoginFail = true;
      emit(ValidationState(isLoginFail));
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

class SigninSuccessful extends LoginState {
  final SigninResponse model;

  SigninSuccessful(this.model);
}

class SignupSuccessful extends LoginState {
  final SignUpResponse model;

  SignupSuccessful(this.model);
}
