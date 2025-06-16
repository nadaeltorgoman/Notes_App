import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  Future<void> pushTo(BuildContext context, Widget page) {
    return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  Future<void> pushToReplacement(BuildContext context, Widget page) {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }
}
