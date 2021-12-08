import 'package:babdraeats/auth/sign_in.dart';
import 'package:babdraeats/auth/sign_up.dart';
import 'package:flutter/material.dart';

class ToggleChanger extends StatefulWidget {

  @override
  _ToggleChangerState createState() => _ToggleChangerState();
}

class _ToggleChangerState extends State<ToggleChanger> {
  bool isToggle = false;

  void toggleScreen(){
    setState(() {
      isToggle = !isToggle;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (isToggle) {
      return SignUp(toggleScreen:toggleScreen);
    } else {
      return SignIn(toggleScreen:toggleScreen);
    }
  }
}