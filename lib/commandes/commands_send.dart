import 'package:babdraeats/home/resto_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommandSend extends StatelessWidget {
  const CommandSend({
    Key? key,
    required this.proStream,
    required this.currentUser,
  }) : super(key: key);

  final CollectionReference<Object?> proStream;
  final User? currentUser;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 4000));
      },
      child: FutureBuilder<QuerySnapshot>(
        future: proStream
            .where('iduser', isEqualTo: currentUser!.uid)
            .where('statut', isEqualTo: "Envoye")
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Loading...")
                ],
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Container(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.content_paste_outlined,
                        color: Colors.grey,
                        size: 40,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Aucune commande pour le moment",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Lorsque vous passerez une commande, elle sera visible ici",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RestoList()));
                        },
                        height: 45,
                        minWidth: 250,
                        color: Color(0xFF033D69),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Afficher les restaurants",
                          style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[100],
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var doc = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/iconapp.png'))),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 150,
                                        child: Text(
                                          '${doc['nom']}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              height: 1,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Au prix de ',
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            ' XAF.${doc['prix']}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                height: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        print('Annuler');
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: Colors.blueAccent),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        height: 25,
                                        width: 80,
                                        child: Center(
                                          child: Text(
                                            'Annuler',
                                            style: TextStyle(
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
