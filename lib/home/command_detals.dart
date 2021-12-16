import 'package:babdraeats/profil/favorites.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'service/add_commande.dart';

class CommandDetails extends StatefulWidget {
  final String idpanier;
  const CommandDetails({Key? key, required this.idpanier}) : super(key: key);

  @override
  _CommandDetailsState createState() => _CommandDetailsState();
}

class _CommandDetailsState extends State<CommandDetails> {
  CollectionReference repasGet =
      FirebaseFirestore.instance.collection('panier');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: repasGet.where('idpanier', isEqualTo: widget.idpanier).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: List.generate(snapshot.data!.docs.length, (index) {
                int qte = int.parse(snapshot.data!.docs[index]['qte']);
                int prixcom =
                    int.parse(snapshot.data!.docs[index]['prix']) * qte;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width,
                      height: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  snapshot.data!.docs[index]['image']),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        snapshot.data!.docs[index]['nom'],
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "XAF. " + snapshot.data!.docs[index]['prix'],
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF033D69)),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Quantité : " + snapshot.data!.docs[index]['qte'],
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF033D69)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () {
                          AddCommandes().addCommandes(
                              currentUser!.uid,
                              prixcom.toString(),
                              snapshot.data!.docs[index]['nom']);
                        },
                        child: Container(
                          height: 50,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              "Commandez au prix de ${prixcom}",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
