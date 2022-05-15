import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/config/page_router.dart';
import 'package:login/model/signin_response.dart';
import 'package:login/view/signup_page.dart';
import '../config/config.dart' as conf;
import '../config/config.dart';

import '../cubit/cubit.dart';
import 'landing_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController signInMailController = TextEditingController();
  final TextEditingController signInPasswordController =
      TextEditingController();
  final GlobalKey<FormState> signinFormKey = GlobalKey();
  Color _emailIconColor = conf.editTextFieldsIconColorPassive;

  Color _passwordIconColor = conf.editTextFieldsIconColorPassive;

  Color _showIconColor = conf.editTextFieldsIconColorPassive;

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    AppConfig.screenHeight = MediaQuery.of(context).size.height;
    AppConfig.screenWidth = MediaQuery.of(context).size.width;
    return buildScaffold(context);
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: signinFormKey,
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topRight,
              radius: 2.5,
              stops: [
                0.1,
                1,
              ],
              colors: [
                conf.mainColor,
                Colors.white,
              ],
            ),
          ),
          child: Column(
            children: [
              //Sign In Header
              _signInHeader(),
              _fields(),
              _forgotPassword(),
              _signInButton(),
              //OR text
              _or(),
              //google sign in
              _signInWithGoogle(),
              const Spacer(),
              _signUp(context),
            ],
          ),
        ),
      ),
    );
  }

  _signInHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20.0,
        top: conf.topInset,
      ),
      child: SizedBox(
        height: 150,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(conf.leftRightInset, 50, 0, 0),
            child: const Text(
              'Sign In',
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _or() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: conf.leftRightInset,
                right: 8,
              ),
              child: const Divider(),
            ),
          ),
          const Text("OR"),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: conf.leftRightInset),
              child: const Divider(),
            ),
          ),
        ],
      ),
    );
  }

  _emailField() {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: conf.leftRightInset,
        right: conf.leftRightInset,
      ),
      child: Focus(
        onFocusChange: ((value) {
          setState(() {
            _emailIconColor = value
                ? conf.editTextFieldsIconColorActive
                : conf.editTextFieldsIconColorPassive;
          });
        }),
        child: TextFormField(
          validator: (value) => EmailValidator.validate(value!)
              ? null
              : "Please enter a valid email",
          controller: signInMailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            prefixIcon: Icon(
              conf.emailIcon,
              color: _emailIconColor,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: "E-Mail",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  _passwordField() {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: conf.leftRightInset,
        right: conf.leftRightInset,
      ),
      child: Focus(
        onFocusChange: ((value) {
          setState(() {
            _passwordIconColor = value
                ? conf.editTextFieldsIconColorActive
                : conf.editTextFieldsIconColorPassive;
          });
        }),
        child: TextFormField(
          validator: (value) =>
              (value ?? "").length > 8 ? null : 'Length must be greater than 8',
          controller: signInPasswordController,
          keyboardType: TextInputType.visiblePassword,
          obscureText: !_showPassword,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            prefixIcon: Icon(
              conf.passwordIcon,
              color: _passwordIconColor,
            ),
            //show password
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _showPassword = !_showPassword;
                  _showIconColor = _showPassword
                      ? conf.editTextFieldsIconColorActive
                      : conf.editTextFieldsIconColorPassive;
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 15, 8),
                child: Icon(
                  conf.showPasswordIcon,
                  color: _showIconColor,
                ),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  _fields() {
    return Column(
      children: [
        //email
        _emailField(),
        //password
        _passwordField(),
      ],
    );
  }

  _forgotPassword() {
    return Align(
      child: SizedBox(
        child: CupertinoButton(
          onPressed: () {},
          child: const Text(
            'Forgot Password?',
            style: TextStyle(
              color: conf.mainColor,
              fontSize: 14,
            ),
          ),
          color: Colors.transparent,
        ),
      ),
    );
  }

  _signInButton() {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is SigninSuccessful) {
          PageRouter.changePageWithAnimation(
            context,
            LandingPage(
              model: state.model,
              loginType: "email",
            ),
            PageRouter.leftToRight,
          );
        } else if (state is SigninFail) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('E-mail or Password is not correct!'),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {},
            ),
          ));
        }
      },
      builder: (context, state) {
        return CupertinoButton(
          onPressed: context.watch<LoginCubit>().isLoading
              ? null
              : () {
                  context.read<LoginCubit>().getUserModel(signinFormKey,
                      signInMailController.text, signInPasswordController.text);
                },
          child: Stack(
            children: [
              Visibility(
                visible: context.watch<LoginCubit>().isLoading,
                child: Container(
                  alignment: Alignment.center,
                  height: conf.textFieldHeight,
                  width: conf.textFieldWidth,
                  decoration: BoxDecoration(
                    color: conf.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !context.watch<LoginCubit>().isLoading,
                child: Container(
                  alignment: Alignment.center,
                  height: conf.textFieldHeight,
                  width: conf.textFieldWidth,
                  decoration: BoxDecoration(
                    color: conf.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 16,
                      color: conf.mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 0,
          ),
          borderRadius: BorderRadius.circular(10),
        );
      },
    );
  }

  _signInWithGoogle() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: SizedBox(
          height: 50,
          width: 50,
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is GoogleSigninSuccess) {
                PageRouter.changePageWithAnimation(
                  context,
                  LandingPage(
                    model: SigninResponse(email: state.model.mail),
                    loginType: "google",
                  ),
                  PageRouter.leftToRight,
                );
              } else if (state is GoogleSigninFail) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Google Authentication Failed!'),
                  action: SnackBarAction(
                    label: 'Close',
                    onPressed: () {},
                  ),
                ));
              }
            },
            builder: (context, state) {
              return GestureDetector(
                child: Image.asset('assets/images/google.png'),
                onTap: () {
                  context.read<LoginCubit>().signinWithGoogle();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  _signUp(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: CupertinoButton(
        onPressed: () {
          PageRouter.changePageWithAnimation(
            context,
            const SignupPage(),
            PageRouter.downToUp,
          );
          //context.read<LoginCubit>().navigateToSignup();
        },
        child: Container(
          height: conf.textFieldHeight,
          width: conf.textFieldWidth,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1.5,
              color: conf.secondaryColor,
            ),
          ),
          child: const Center(
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 16,
                color: conf.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
