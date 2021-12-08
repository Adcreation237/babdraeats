// ignore_for_file: unnecessary_null_comparison

import 'package:babdraeats/auth/toggle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bottom_bar.dart';

class WrapperAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<User?>(context);
    var currentUser = FirebaseAuth.instance.currentUser;
    
    return currentUser != null
        ? BottomBar(
            pages: 0,
          )
        : ToggleChanger();
  }
}
