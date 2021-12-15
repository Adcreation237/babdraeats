import 'package:animate_do/animate_do.dart';
import 'package:babdraeats/home/command_detals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference firebasefirebase =
      FirebaseFirestore.instance.collection('panier');

  int total = 0;
  int prix = 0;
  DateTime now = DateTime.now();

  Future DeleteElementFav(String idpanier) async {
    await FirebaseFirestore.instance
        .collection("panier")
        .doc(idpanier.toString())
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 4000));
          firebasefirebase
              .where('iduser', isEqualTo: currentUser!.uid.toString())
              .get();
        },
        child: FutureBuilder(
          future: firebasefirebase
              .where('iduser', isEqualTo: currentUser!.uid.toString())
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SafeArea(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                          Column(
                            children: [
                              Text(
                                "Your Cart",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Text(
                                "${snapshot.data!.docs.length} items",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Container(
                              child: Icon(
                            Icons.error_outlined,
                            color: Colors.transparent,
                          )),
                        ],
                      ),
                    ),
                    Column(
                      children:
                          List.generate(snapshot.data!.docs.length, (index) {
                        return FadeInLeft(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => CommandDetails(
                                          idpanier: snapshot.data!.docs[index]
                                              ['idpanier'],
                                        )),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Dismissible(
                                key:
                                    Key(snapshot.data!.docs[index]['idpanier']),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  snapshot.data!.docs.remove(index);
                                  DeleteElementFav(
                                      snapshot.data!.docs[index]['idpanier']);
                                  setState(() {
                                    prix = 0;
                                    total = 0;
                                  });
                                },
                                background: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFCC6600),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 60,
                                      child: AspectRatio(
                                        aspectRatio: 0.88,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFFF5F6F9),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Image.network(
                                            snapshot.data!.docs[index]['image'],
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
                                        Text(
                                          snapshot.data!.docs[index]['nom'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "XAF" +
                                                  snapshot.data!.docs[index]
                                                      ['prix'],
                                              style: TextStyle(
                                                color: Color(0xFFCC6600),
                                              ),
                                            ),
                                            Text(
                                              " x " +
                                                  snapshot.data!.docs[index]
                                                      ['qte'],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    LineIcons.bug,
                    size: 50,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text("You cart is empty")
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
