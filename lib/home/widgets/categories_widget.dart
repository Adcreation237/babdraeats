import 'package:babdraeats/bottom_bar.dart';
import 'package:babdraeats/categories/categories_details.dart';
import 'package:babdraeats/home/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'load_cat.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    CollectionReference catStream =
        FirebaseFirestore.instance.collection('categories');

    return Container(
      width: size.width,
      decoration: BoxDecoration(color: textFieldColor),
      child: Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Container(
          decoration: BoxDecoration(color: white),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 15,
              bottom: 15,
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: catStream.limit(5).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(0.2),
                    highlightColor: Colors.blueGrey.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          showCategorieLoading(),
                          showCategorieLoading(),
                          showCategorieLoading(),
                          showCategorieLoading(),
                        ],
                      ),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Row(
                            children: List.generate(snapshot.data!.docs.length,
                                (index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 35),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => ViewCategories(
                                                  menu: snapshot.data!
                                                      .docs[index]['title']
                                                      .toString(),
                                                )));
                                  },
                                  child: Column(
                                    children: [
                                      Card(
                                        child: Image.network(
                                          snapshot.data!.docs[index]['image'],
                                          width: 40,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['title'],
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 35),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => BottomBar(pages: 1)));
                              },
                              child: Column(
                                children: [
                                  Card(
                                    child: Icon(
                                      Icons.add,
                                      size: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Plus",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.2),
                  highlightColor: Colors.blueGrey.withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        showCategorieLoading(),
                        showCategorieLoading(),
                        showCategorieLoading(),
                        showCategorieLoading(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
