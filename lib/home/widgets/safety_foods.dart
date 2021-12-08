import 'package:babdraeats/home/resto_details.dart';
import 'package:babdraeats/home/theme/colors.dart';
import 'package:babdraeats/home/theme/styles.dart';
import 'package:babdraeats/home/widgets/promotion_one.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SafetyFoods extends StatelessWidget {
  const SafetyFoods({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    CollectionReference pubStream =
        FirebaseFirestore.instance.collection('promotion');
    CollectionReference restoStream =
        FirebaseFirestore.instance.collection('usersResto');
    var currentUser = FirebaseAuth.instance.currentUser;

    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Safety Foods",
                style: customTitle,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PromotionOne(
                                text: 'safety',
                              )));
                },
                icon: Icon(Icons.more_horiz),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: pubStream.where('theme', isEqualTo: 'safety').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                return Container(
                  width: size.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          List.generate(snapshot.data!.docs.length, (index) {
                        String id =
                            snapshot.data!.docs[index]['idresto'].toString();
                        print(id);
                        return StreamBuilder(
                          stream: restoStream
                              .where('idEts', isEqualTo: id)
                              .snapshots()
                              .asBroadcastStream(),
                          builder: (BuildContext contexts,
                              AsyncSnapshot<QuerySnapshot> snapshots) {
                            if (snapshots.connectionState ==
                                ConnectionState.waiting) {
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
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                      snapshots.data!.docs.length, (indexe) {
                                    var doc = snapshots.data!.docs[indexe];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          RestoDetails(
                                                              idEts: id)));
                                            },
                                            child: Container(
                                              width: size.width - 30,
                                              height: 160,
                                              child: Image(
                                                image: NetworkImage(
                                                    doc['images'][1]),
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
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .phone_iphone_outlined,
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
                        );
                      }),
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
