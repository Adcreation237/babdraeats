import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shimmer/shimmer.dart';

import 'categories_details.dart';

class CategoriesPages extends StatefulWidget {
  const CategoriesPages({Key? key}) : super(key: key);

  @override
  _CategoriesPagesState createState() => _CategoriesPagesState();
}

CollectionReference _usersStream =
    FirebaseFirestore.instance.collection('categories');

class _CategoriesPagesState extends State<CategoriesPages> {
  String searchInput = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF033D69),
        title: Text(
          "Babdra Eats",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
            children: [
              Center(
                child: IconButton(
                  onPressed: () {
                    /*Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_) => CartScreen()));*/
                  },
                  icon: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      LineIcons.shoppingCart,
                      size: 26,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 5, left: 25, right: 25, bottom: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchInput = value;
                    });
                  },
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search...",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            searchInput = "";
                          });
                        },
                        icon: Icon(Icons.close)),
                  ),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(40)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _usersStream.snapshots().asBroadcastStream(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        ...snapshot.data!.docs
                            .where((QueryDocumentSnapshot<Object?> element) =>
                                element['title']
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchInput.toLowerCase()))
                            .map((QueryDocumentSnapshot<Object?>
                                documentSnapshot) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_) => ViewCategories(menu: documentSnapshot['title'].toString(),)));
                            },
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: Container(
                                    height: 65,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(0, 1))
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 2),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            documentSnapshot['title'],
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 1,
                                          ),
                                          Container(
                                              width: 220,
                                              child: Text(
                                                'Lorem fdfdfdf fdfdllaka kfjfkdf kaksafd fsfs sdsdsds',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: Container(
                                    width: 85,
                                    height: 85,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: Offset(0, 1))
                                        ],
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                documentSnapshot['image']))),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                      ],
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Loading_2 extends StatelessWidget {
  const Loading_2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.blueGrey,
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: GridView.count(
          crossAxisCount: 3,
          children: [
            Card(
              child: InkWell(
                splashColor: Colors.deepOrangeAccent,
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        width: 60,
                        height: 20,
                        padding: EdgeInsets.all(10),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
