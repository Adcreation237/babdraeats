// ignore_for_file: unnecessary_null_comparison

import 'package:babdraeats/categories/categories_view.dart';
import 'package:babdraeats/commandes/commandes.dart';
import 'package:babdraeats/home/home.dart';
import 'package:babdraeats/profil/view_profil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final int pages;
  const BottomBar({Key? key, required this.pages}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var currentUser = FirebaseAuth.instance.currentUser;
  bool noti = false;
  void verifyCommande() async {
    await FirebaseFirestore.instance
        .collection('commandes')
        .where('iduser', isEqualTo: currentUser!.uid)
        .where('statut', isEqualTo: 'Traitée')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          noti = true;
        });
      } else {
        setState(() {
          noti = false;
        });
      }
    });
  }

  int? selectIndex;

  List<Widget> optionPage = <Widget>[
    HomePage(),
    CategoriesPages(),
    Text("Bientôt disponible"),
    CommandeScreen(),
    ViewProfil(),
  ];

  void onItemTap(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  void initState() {
    verifyCommande();
    super.initState();
    if (widget.pages == null) {
      selectIndex = 0;
    } else {
      selectIndex = widget.pages;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: optionPage.elementAt(selectIndex!),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business_outlined),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_sharp),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chair_outlined),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: noti == true
                ? Stack(
                    children: [
                      Icon(
                        Icons.content_paste_outlined,
                      ),
                      Positioned(
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                    ],
                  )
                : Icon(
                    Icons.content_paste_outlined,
                  ),
            label: "Commandes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Compte",
          ),
        ],
        currentIndex: selectIndex!,
        onTap: onItemTap,
        selectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(color: Colors.black, opacity: 2),
        showUnselectedLabels: true,
        unselectedIconTheme: IconThemeData(color: Colors.grey, opacity: 2),
        enableFeedback: true,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        unselectedLabelStyle: TextStyle(fontSize: 8),
        selectedLabelStyle: TextStyle(fontSize: 8),
      ),
    );
  }
}
