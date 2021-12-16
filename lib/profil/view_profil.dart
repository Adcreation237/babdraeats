import 'package:babdraeats/auth/user_form.dart';
import 'package:babdraeats/home/widgets/promotion_one.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'account_view.dart';
import 'favorites.dart';
import 'settings.dart';

class ViewProfil extends StatefulWidget {
  const ViewProfil({Key? key}) : super(key: key);

  @override
  _ViewProfilState createState() => _ViewProfilState();
}

class _ViewProfilState extends State<ViewProfil> {
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    currentUser!.email.toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage("assets/images/profil.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Column(
            children: [
              /*Button_Profil(
                icon: Icons.favorite_border,
                press: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Favorites()));
                },
                text: 'Mes favoris',
              ),*/
              Button_Profil(
                icon: Icons.tag_faces_sharp,
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PromotionOne(
                                text: 'publicite',
                              )));
                },
                text: 'Promotion',
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  height: 5,
                ),
              ),
              Button_Profil(
                icon: Icons.share_outlined,
                press: () {},
                text: 'Partager',
              ),
              Button_Profil(
                icon: Icons.help_outline,
                press: () {},
                text: 'Aide',
              ),
              Button_Profil(
                icon: Icons.settings,
                press: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingsUsers()));
                },
                text: 'Paramètres',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Button_Profil extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function() press;
  const Button_Profil({
    required this.text,
    required this.icon,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(
            horizontal: 5,
          ),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Icon(icon),
              SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
