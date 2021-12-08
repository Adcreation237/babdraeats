import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'resto_details.dart';
import 'theme/colors.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({
    Key? key,
  }) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  CollectionReference firebasefirebase =
      FirebaseFirestore.instance.collection('usersResto');
  TextEditingController searchInput = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  Container(
                    width: 250,
                    height: 40,
                    child: TextField(
                      controller: searchInput,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Search...",
                        suffixIcon: IconButton(
                            onPressed: () {
                              searchInput.clear();
                            },
                            icon: Icon(Icons.close)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
                child: Divider(),
              ),
              Text(
                "Result of " + "'" + searchInput.text + "'",
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(Duration(milliseconds: 1000));
                },
                child: StreamBuilder<QuerySnapshot>(
                  stream: firebasefirebase.snapshots().asBroadcastStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error");
                    }
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
                      return Column(children: [
                        ...snapshot.data!.docs
                            .where((QueryDocumentSnapshot<Object?> element) =>
                                element['nomEts']
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchInput.text.toLowerCase()))
                            .map((QueryDocumentSnapshot<Object?>
                                documentSnapshot) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                       Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        RestoDetails(idEts: documentSnapshot['idEts'])));
                                      },
                                      child: Container(
                                        width: size.width - 30,
                                        height: 160,
                                        child: Image(
                                          image: NetworkImage(
                                              documentSnapshot['images'][1]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 15,
                                      right: 15,
                                      child: Icon(
                                        Icons.favorite,
                                        size: 20,
                                        color: white,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                    Row(
                                      children: [
                                        Text(
                                          documentSnapshot['nomEts'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.check_circle,
                                          color: Colors.blue,
                                          size: 15,
                                        )
                                      ],
                                    ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      documentSnapshot['menus'],
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: textFieldColor,
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Icon(
                                          Icons.hourglass_bottom,
                                          color: primary,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: textFieldColor,
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          documentSnapshot['temps_livraison'],
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: textFieldColor,
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.phone_iphone,
                                              color: primary,
                                              size: 17,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              documentSnapshot['phone'],
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        })
                      ]);
                    }
                    return Container(
                      child: Text("data"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
