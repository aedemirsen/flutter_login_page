import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/config/page_router.dart';
import 'package:login/view/signup_page.dart';
import '../config/config.dart' as conf;
import '../config/config.dart';
import '../cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginApp extends StatefulWidget {
  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  final GlobalKey<FormState> signinFormKey = GlobalKey();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocus = FocusNode();

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
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20.0,
                  top: conf.topInset,
                ),
                child: SizedBox(
                  height: 150,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.fromLTRB(conf.leftRightInset, 50, 0, 0),
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
              ),
              _fields(),
              _forgotPassword(),
              _signInButton(context),
              //OR text
              Padding(
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
                        padding: EdgeInsets.only(
                            left: 8, right: conf.leftRightInset),
                        child: const Divider(),
                      ),
                    ),
                  ],
                ),
              ),
              //google sign in
              _signInWithGoogle(),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: _signUp(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _fields() {
    return Column(
      children: [
        //email
        SizedBox(
          height: conf.textFieldHeight,
          width: conf.textFieldWidth,
          child: CupertinoTextField(
            controller: emailController,
            focusNode: emailFocus,
            placeholder: 'E-Mail',
            onTap: () {
              // setState(() {
              //   _emailIconColor = conf.editTextFieldsIconColorActive;
              //   _passwordIconColor = conf.editTextFieldsIconColorPassive;
              // });
            },
            onSubmitted: (text) {
              // setState(() {
              //   _emailIconColor = conf.editTextFieldsIconColorPassive;
              // });
            },
            keyboardType: TextInputType.emailAddress,
            prefix: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 8, 8, 8),
              child: Icon(
                conf.emailIcon,
                color: _emailIconColor,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        //password
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            height: conf.textFieldHeight,
            width: conf.textFieldWidth,
            child: CupertinoTextField(
              controller: passwordController,
              placeholder: 'Password',
              obscureText: !_showPassword,
              onTap: () {
                // setState(() {
                //   _emailIconColor = conf.editTextFieldsIconColorPassive;
                //   _passwordIconColor = conf.editTextFieldsIconColorActive;
                // });
              },
              onSubmitted: (text) {
                // setState(() {
                //   _passwordIconColor = conf.editTextFieldsIconColorPassive;
                // });
              },
              keyboardType: TextInputType.visiblePassword,
              prefix: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 8, 8, 8),
                child: Icon(
                  conf.passwordIcon,
                  color: _passwordIconColor,
                ),
              ),
              suffix: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 15, 8),
                child: GestureDetector(
                  child: Icon(
                    conf.showPasswordIcon,
                    color: _showIconColor,
                  ),
                  onTap: () {
                    // setState(() {
                    //   _showPassword = !_showPassword;
                    //   _showIconColor = _showPassword
                    //       ? conf.editTextFieldsIconColorActive
                    //       : conf.editTextFieldsIconColorPassive;
                    // });
                  },
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
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

  _signInButton(BuildContext context) {
    return SizedBox(
      height: conf.textFieldHeight,
      width: conf.textFieldWidth,
      child: CupertinoButton(
        onPressed: () {},
        child: const Text(
          'Log In',
          style: TextStyle(
            fontSize: 16,
            color: conf.mainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        color: conf.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  _signInWithGoogle() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: SizedBox(
          height: 50,
          width: 50,
          child: GestureDetector(
            child: Image.asset('assets/images/google.png'),
          ),
        ),
      ),
    );
  }

  _signUp() {
    return CupertinoButton(
      onPressed: () {
        PageRouter.changePageWithAnimation(
          context,
          SignUp(),
          PageRouter.downToUp,
        );
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
    );
  }
}
