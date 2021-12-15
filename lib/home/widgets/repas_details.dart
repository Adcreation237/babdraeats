import 'package:babdraeats/home/service/add_panier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../cart.dart';

class RepasView extends StatefulWidget {
  final String idEts;
  final String idpro;
  final String images;
  final String ingredients;
  final String menu;
  final String nompro;
  final String prix;
  final String desc;
  const RepasView(
      {Key? key,
      required this.idEts,
      required this.idpro,
      required this.images,
      required this.ingredients,
      required this.menu,
      required this.nompro,
      required this.prix,
      required this.desc})
      : super(key: key);

  @override
  _RepasViewState createState() => _RepasViewState();
}

class _RepasViewState extends State<RepasView> {
  var currentUser = FirebaseAuth.instance.currentUser;
  AddPanier addPanier = AddPanier();
  int qte = 1;
  int prixcom = 0;
  int prix = 0;

  @override
  void initState() {
    super.initState();
    prix = int.parse(widget.prix);
    prixcom = prix;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomSheet: getFooter(),
    );
  }

  Widget getFooter() {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 70,
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.black.withOpacity(0.1),
            ),
          )),
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                addPanier.addPanier(
                    widget.idpro,
                    widget.idEts,
                    currentUser!.uid,
                    widget.images,
                    widget.nompro,
                    prixcom.toString(),
                    qte.toString());
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => CartScreen()),
                );
              },
              child: Container(
                height: 40,
                width: 280,
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    "Ajouter ${qte} au panier ${prixcom}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: size.width,
                  height: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.images),
                          fit: BoxFit.cover)),
                ),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              size: 18,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.nompro,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "XAF. " + widget.prix,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrangeAccent),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border(
                          bottom:
                              BorderSide(color: Colors.grey.withOpacity(0.5)),
                          left: BorderSide(color: Colors.grey.withOpacity(0.5)),
                          right:
                              BorderSide(color: Colors.grey.withOpacity(0.5)),
                          top: BorderSide(color: Colors.grey.withOpacity(0.5))),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(widget.desc),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Ingrédients",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: (size.width),
                    child: Text(
                      widget.ingredients,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      qte <= 1
                          ? Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.grey.withOpacity(0.1)),
                              child: Icon(Icons.remove),
                            )
                          : Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.grey.withOpacity(0.5)),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    qte = qte - 1;
                                    print(qte);
                                    prixcom = prixcom - prix;
                                    print(prixcom);
                                  });
                                },
                                icon: Icon(Icons.remove),
                              ),
                            ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        '${qte}',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey.withOpacity(0.5)),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              qte = qte + 1;
                              prixcom = prixcom + prix;
                              print(prixcom);
                            });
                          },
                          icon: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
