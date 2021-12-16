import 'package:animate_do/animate_do.dart';
import 'package:babdraeats/profil/update_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../wrapper.dart';

class SettingsUsers extends StatefulWidget {
  const SettingsUsers({Key? key}) : super(key: key);

  @override
  _SettingsUsersState createState() => _SettingsUsersState();
}

class _SettingsUsersState extends State<SettingsUsers> {
  CollectionReference userGet = FirebaseFirestore.instance.collection('users');
  var currentUser = FirebaseAuth.instance.currentUser;
  String? email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (currentUser != null) {
      email = currentUser!.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeInUp(
        duration: Duration(seconds: 1),
        child: Column(
          children: [
            Stack(
              overflow: Overflow.visible,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 80.0,
                  color: Color(0xFF033D69),
                ),
                Positioned(
                  bottom: -40.0,
                  child: Container(
                    height: 90.0,
                    width: 90.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      image: DecorationImage(
                        image: AssetImage("assets/images/profil.png"),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -60.0,
                  child: Text(
                    email.toString(),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            FutureBuilder(
              future:
                  userGet.where('iduser', isEqualTo: currentUser!.uid).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          var doc = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 90, left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Lieux enrégistrés",
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(
                                  height: 10,
                                ),
                                Option_Profil(
                                  desc: doc['Haddress'],
                                  icon: Icons.home_outlined,
                                  press: () {},
                                  title: 'Domicile',
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Option_Profil(
                                  desc: doc['Waddress'],
                                  icon: Icons.home_repair_service_outlined,
                                  press: () {},
                                  title: 'Travail',
                                ),
                                SizedBox(
                                  height: 35,
                                ),
                                Text("Autres options",
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateForm()));
                                  },
                                  child: Text(
                                    "Modifier son compte",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      // ignore: non_constant_identifier_names
                                      MaterialPageRoute(builder: (Context) {
                                        return Wrapper();
                                      }),
                                      (route) => false,
                                    );
                                  },
                                  child: Text(
                                    "Se déconnecter",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepOrangeAccent),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  child: Text(
                                    "Supprimer son compte",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Option_Profil extends StatelessWidget {
  final IconData icon;
  final String title, desc;
  final Function() press;

  const Option_Profil({
    required this.icon,
    required this.title,
    required this.desc,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                icon,
                size: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    desc,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
