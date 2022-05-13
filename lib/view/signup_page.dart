import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/config/config.dart' as conf;

import '../cubit/cubit.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController signupEmailController = TextEditingController();

  final TextEditingController signupPasswordController =
      TextEditingController();

  final TextEditingController signupConfirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> signupFormKey = GlobalKey();

  Color _emailIconColor = conf.editTextFieldsIconColorPassive;

  Color _passwordIconColor = conf.editTextFieldsIconColorPassive;

  Color _confirmPasswordIconColor = conf.editTextFieldsIconColorPassive;

  Color _showIconColor = conf.editTextFieldsIconColorPassive;

  Color _showConfirmIconColor = conf.editTextFieldsIconColorPassive;

  bool _showPassword = false;

  bool _showConfirmPassword = false;

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return buildScaffold(context);
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: signupFormKey,
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
              //back button
              _backButton(),
              //Sign In Header
              _signInHeader(),
              //fields
              _fields(),
              _termsOfService(),
              _signUp(context),
            ],
          ),
        ),
      ),
    );
  }

  _backButton() {
    return Padding(
      padding: EdgeInsets.only(
        left: conf.leftRightInset,
        top: conf.topInset,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: (() => Navigator.pop(context)),
          child: const Icon(
            Icons.arrow_back_sharp,
            size: 40,
          ),
        ),
      ),
    );
  }

  _signInHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20.0,
      ),
      child: SizedBox(
        height: 150,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(conf.leftRightInset, 50, 0, 0),
            child: const Text(
              'Sign Up',
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

  _emailField() {
    return Padding(
      padding: EdgeInsets.only(
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
          controller: signupEmailController,
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
          controller: signupPasswordController,
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

  _confirmPasswordField() {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: conf.leftRightInset,
        right: conf.leftRightInset,
      ),
      child: Focus(
        onFocusChange: ((value) {
          setState(() {
            _confirmPasswordIconColor = value
                ? conf.editTextFieldsIconColorActive
                : conf.editTextFieldsIconColorPassive;
          });
        }),
        child: TextFormField(
          validator: (value) => value == signupPasswordController.text
              ? null
              : 'Passwords must be matched',
          controller: signupConfirmPasswordController,
          keyboardType: TextInputType.visiblePassword,
          obscureText: !_showConfirmPassword,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            prefixIcon: Icon(
              conf.passwordIcon,
              color: _confirmPasswordIconColor,
            ),
            //show password
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _showConfirmPassword = !_showConfirmPassword;
                  _showConfirmIconColor = _showConfirmPassword
                      ? conf.editTextFieldsIconColorActive
                      : conf.editTextFieldsIconColorPassive;
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 15, 8),
                child: Icon(
                  conf.showPasswordIcon,
                  color: _showConfirmIconColor,
                ),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: "Confirm Password",
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
        //confirm password
        _confirmPasswordField(),
      ],
    );
  }

  _termsOfService() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: _isChecked,
            onChanged: (bool? value) {
              setState(() {
                _isChecked = value!;
              });
            },
          ),
          const Text("I accept the "),
          GestureDetector(
            onTap: (() => print("Privacy Policy")),
            child: const Text(
              "Privacy Policy ",
              style: TextStyle(
                color: conf.mainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text("and "),
          GestureDetector(
            onTap: (() => print("Terms")),
            child: const Text(
              "Terms",
              style: TextStyle(
                color: conf.mainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _signUp(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is SignupSuccessful) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(
                'Signed Up Successfuly! Redirecting Sign In Page...'),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {},
            ),
          ));
          await Future.delayed(const Duration(seconds: 2));
          Navigator.pop(context);
        } else if (state is SignupFail) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Signup Fail'),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {},
            ),
          ));
        }
      },
      builder: (context, state) {
        return CupertinoButton(
          onPressed: () {
            if (_isChecked) {
              context.read<LoginCubit>().postUserModel(signupFormKey,
                  signupEmailController.text, signupPasswordController.text);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Please accept Terms and Privacy Policy'),
                action: SnackBarAction(
                  label: 'Close',
                  onPressed: () {},
                ),
              ));
            }
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
                  height: conf.textFieldHeight,
                  width: conf.textFieldWidth,
                  decoration: BoxDecoration(
                    color: conf.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        color: conf.mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          borderRadius: BorderRadius.circular(10),
        );
      },
    );
  }
}
