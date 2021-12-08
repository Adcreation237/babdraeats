import 'package:babdraeats/home/theme/colors.dart';
import 'package:babdraeats/home/theme/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../resto_details.dart';

class PromotionOne extends StatefulWidget {
  final String text;
  const PromotionOne({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  _PromotionOneState createState() => _PromotionOneState();
}

class _PromotionOneState extends State<PromotionOne> {
  CollectionReference pubStream =
      FirebaseFirestore.instance.collection('promotion');
  CollectionReference restoStream =
      FirebaseFirestore.instance.collection('usersResto');
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
                  Text(
                    widget.text.toUpperCase(),
                    style: customTitle,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
                child: Divider(),
              ),
              RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(Duration(milliseconds: 1000));
                },
                child: StreamBuilder<QuerySnapshot>(
                  stream: pubStream
                      .where('theme', isEqualTo: widget.text)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      return Container(
                        width: size.width,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: List.generate(snapshot.data!.docs.length,
                                (index) {
                              String id = snapshot.data!.docs[index]['idresto']
                                  .toString();
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                      child: Column(
                                        children: List.generate(
                                            snapshots.data!.docs.length,
                                            (indexe) {
                                          var doc =
                                              snapshots.data!.docs[indexe];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
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
                                                                    idEts:
                                                                        id)));
                                                  },
                                                  child: Container(
                                                    width: size.width,
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
                                                              BorderRadius
                                                                  .circular(3)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Icon(
                                                          Icons
                                                              .hourglass_bottom,
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
                                                              BorderRadius
                                                                  .circular(3)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
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
                                                              BorderRadius
                                                                  .circular(3)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .phone_iphone_outlined,
                                                              color:
                                                                  Colors.blue,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
