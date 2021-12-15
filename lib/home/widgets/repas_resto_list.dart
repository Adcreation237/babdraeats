import 'package:babdraeats/home/theme/colors.dart';
import 'package:babdraeats/home/widgets/repas_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RepasRestoList extends StatefulWidget {
  final String nameEts;
  final String idEts;
  const RepasRestoList({Key? key, required this.nameEts, required this.idEts})
      : super(key: key);

  @override
  _RepasRestoListState createState() => _RepasRestoListState();
}

class _RepasRestoListState extends State<RepasRestoList> {
  CollectionReference repasGet =
      FirebaseFirestore.instance.collection('produits');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: Color(0xFF033D69),
        title: Text(
          widget.nameEts,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: StreamBuilder(
              stream: repasGet
                  .where('idEts', isEqualTo: widget.idEts)
                  .snapshots()
                  .asBroadcastStream(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: CircularProgressIndicator()),
                        SizedBox(
                          height: 80,
                        ),
                        Center(
                          child: Text("Chargement encours..."),
                        )
                      ],
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return Column(
                    children:
                        List.generate(snapshot.data!.docs.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => RepasView(
                                      desc: snapshot.data!.docs[index]['desc'],
                                      idEts: snapshot.data!.docs[index]
                                          ['idEts'],
                                      idpro: snapshot.data!.docs[index]
                                          ['idpro'],
                                      images: snapshot.data!.docs[index]
                                          ['image'],
                                      ingredients: snapshot.data!.docs[index]
                                          ['ingredients'],
                                      menu: snapshot.data!.docs[index]['menu'],
                                      nompro: snapshot.data!.docs[index]
                                          ['nompro'],
                                      prix: snapshot.data!.docs[index]['prix'],
                                    )),
                          );
                        },
                        child: Card(
                          child: Stack(
                            children: [
                              Container(
                                height: 110,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        snapshot.data!.docs[index]['image']
                                            .toString(),
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: Container(
                                  height: 110,
                                  width: MediaQuery.of(context).size.width / 2,
                                  color: Color(0xFF033D69).withOpacity(0.7),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]['nompro'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data!.docs[index]
                                                  ['menu'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10),
                                            ),
                                            Text(
                                              "XAF " +
                                                  snapshot.data!.docs[index]
                                                      ['prix'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          snapshot.data!.docs[index]['desc'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.no_food_outlined,
                          size: 40,
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Center(
                          child: Text("Pas de repas pour le moment..."),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
