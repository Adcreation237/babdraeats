import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewProfil extends StatefulWidget {
  const ViewProfil({ Key? key }) : super(key: key);

  @override
  _ViewProfilState createState() => _ViewProfilState();
}


class _ViewProfilState extends State<ViewProfil> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}