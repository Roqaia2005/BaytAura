import 'package:flutter/material.dart';

extension Navigation on BuildContext{
  void pushNamed(String routeName, {Object? arguments}) {
    Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  void pushReplacementNamed(String routeName, {Object? arguments}) {
    Navigator.pushReplacementNamed(this, routeName, arguments: arguments);
  }
  void pushNamedAndRemoveUntil(String routeName, {Object? arguments}) {
    Navigator.pushNamedAndRemoveUntil(this, routeName, (route) => false, arguments: arguments);
  }

  void pop() {
    Navigator.pop(this);
  }
}