import 'package:babdraeats/home/resto_details.dart';
import 'package:babdraeats/home/resto_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

CollectionReference _usersStream =
    FirebaseFirestore.instance.collection('favorites');
CollectionReference restoStream =
    FirebaseFirestore.instance.collection('usersResto');
var currentUser = FirebaseAuth.instance.currentUser;

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF033D69),
        title: Text("Mes Favorites"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: FutureBuilder<QuerySnapshot>(
          future:
              _usersStream.where('iduser', isEqualTo: currentUser!.uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container(
                child: Column(
                  children: [
                    Icon(
                      Icons.warning,
                      size: 40,
                      color: Colors.red,
                    ),
                    Text(
                      "Something went wrong",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete_outline_rounded,
                      size: 150,
                      color: Colors.grey,
                    ),
                    Text("Vous n'avez pas ajouté de favorite"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RestoList()));
                        },
                        child: Text("Consulter la liste")),
                  ],
                ),
              );
            }

            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          var doc = snapshot.data!.docs[index];
                          String id = doc['idets'].toString();
                          return StreamBuilder(
                              stream: restoStream
                                  .where('idEts', isEqualTo: id)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshots) {
                                if (snapshots.hasData) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => RestoDetails(
                                                  idEts: doc['idets'],
                                                )),
                                      );
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        color: Colors.deepOrangeAccent
                                            .withOpacity(0.1),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 90,
                                              height: 70,
                                              child: AspectRatio(
                                                aspectRatio: 0.88,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFF5F6F9),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Image.network(
                                                    snapshot.data!.docs[index]
                                                        ['image'],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 180,
                                                  child: Text(
                                                    snapshot.data!.docs[index]
                                                        ['nom'],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 1,
                                                ),
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                    snapshot.data!
                                                        .docs[index]['location']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        height: 1.4),
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              });
                        }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
