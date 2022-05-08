import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PageRouter {
  //Page Transitions Offset values
  //1 - down to up
  static Offset downToUp = const Offset(0.0, 1.0);
  //2 - up to down
  static Offset upToDown = const Offset(0.0, -1.0);
  //3 - left to right
  static Offset leftToRight = const Offset(-1.0, 0.0);
  //4 - right to left
  static Offset rightToLeft = const Offset(1.0, 0.0);

  //Page Route
  //Offset value tells us which direction the page will open and close.
  static Future changePageWithAnimation(
      context, dynamic _page, Offset offset) async {
    await Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) => _page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = offset;
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(
            CurveTween(curve: curve),
          );
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  static Future changePageWithoutAnimation(context, dynamic _page,
      {int? data}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _page,
        // Pass the arguments as part of the RouteSettings. The
        // DetailScreen reads the arguments from these settings.
        settings: RouteSettings(
          arguments: data,
        ),
      ),
    );
  }
}
