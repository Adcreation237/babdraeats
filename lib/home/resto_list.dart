import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'resto_details.dart';
import 'theme/colors.dart';

class RestoList extends StatefulWidget {
  const RestoList({Key? key}) : super(key: key);

  @override
  _RestoListState createState() => _RestoListState();
}

class _RestoListState extends State<RestoList> {
  CollectionReference restoStream =
      FirebaseFirestore.instance.collection('usersResto');
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF033D69),
        title: Text(
          "All Restaurants",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: restoStream.get(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
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
          if (snapshots.hasError) {
            return Text(snapshots.error.toString());
          }

          if (!snapshots.hasData) {
            return Text("empty");
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: List.generate(snapshots.data!.docs.length, (indexe) {
                  var doc = snapshots.data!.docs[indexe];
                  String id = snapshots.data!.docs[indexe]['idEts'].toString();
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => RestoDetails(idEts: id)));
                          },
                          child: Container(
                            width: size.width - 30,
                            height: 160,
                            child: Image(
                              image: NetworkImage(doc['images'][1]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              doc['nomEts'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            doc['num_contribuable'] != ''
                                ? Icon(
                                    Icons.check_circle,
                                    color: Colors.blue,
                                    size: 15,
                                  )
                                : Text(""),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 300,
                              child: Text(
                                doc['menus'],
                                style: TextStyle(
                                  fontSize: 14,
                                ),
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
                                  borderRadius: BorderRadius.circular(3)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.hourglass_bottom,
                                  color: Colors.blue,
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
                                  borderRadius: BorderRadius.circular(3)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  doc['temps_livraison'],
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
                                  borderRadius: BorderRadius.circular(3)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.phone_iphone_outlined,
                                      color: Colors.blue,
                                      size: 17,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      doc['phone'],
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
                }),
              ),
            );
          }
        },
      ),
    );
  }
}
