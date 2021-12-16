import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'commands_delivering.dart';
import 'commands_encours.dart';
import 'commands_send.dart';
import 'commands_traited.dart';

class CommandeScreen extends StatefulWidget {
  const CommandeScreen({Key? key}) : super(key: key);

  @override
  _CommandeScreenState createState() => _CommandeScreenState();
}

class _CommandeScreenState extends State<CommandeScreen>
    with SingleTickerProviderStateMixin {
  var currentUser = FirebaseAuth.instance.currentUser;
  bool isCommande = false;
  CollectionReference proStream =
      FirebaseFirestore.instance.collection('commandes');
  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vos commandes",
          softWrap: true,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Color(0xFF033D69),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          labelStyle: TextStyle(fontSize: 10),
          tabs: [
            Tab(
              icon: Icon(Icons.compare_arrows),
              text: "Envoyées",
            ),
            Tab(
              icon: Icon(Icons.pending_actions),
              text: "Encours",
            ),
            Tab(
              icon: Icon(Icons.delivery_dining_outlined),
              text: "Livraison",
            ),
            Tab(
              icon: Icon(Icons.library_add_check_outlined),
              text: "Traitées",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          CommandSend(proStream: proStream, currentUser: currentUser),
          CommandEncours(proStream: proStream, currentUser: currentUser),
          CommandDeliviring(proStream: proStream, currentUser: currentUser),
          CommandTraited(proStream: proStream, currentUser: currentUser),
        ],
      ),
    );
  }
}
