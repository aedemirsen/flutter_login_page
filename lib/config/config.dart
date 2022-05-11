import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppConfig {
  static double screenWidth = 0, screenHeight = 0;
}

const String baseUrl = 'https://627801146ac99a9106533360.mockapi.io/api';
const double topInset = 75;
const double loginButtonHeight = 50;
final double loginButtonWidth = (textFieldWidth - 30) / 2;
const double textFieldHeight = 45;
final double textFieldWidth = AppConfig.screenWidth - 50;
const IconData emailIcon = CupertinoIcons.mail_solid;
const IconData mobilePhoneIcon = Icons.phone_android;
const IconData passwordIcon = Icons.vpn_key_rounded;
const IconData showPasswordIcon = Icons.visibility;
const Color editTextFieldsIconColorPassive = Colors.grey;
const Color editTextFieldsIconColorActive = Colors.deepPurple;
const Color mainColor = Colors.deepPurple;
const Color secondaryColor = Color.fromARGB(255, 14, 168, 130);
final double leftRightInset = (AppConfig.screenWidth - textFieldWidth) / 2;
