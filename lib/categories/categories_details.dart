import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ViewCategories extends StatefulWidget {
  final String menu;
  const ViewCategories({Key? key, required this.menu}) : super(key: key);

  @override
  _ViewCategoriesState createState() => _ViewCategoriesState();
}

class _ViewCategoriesState extends State<ViewCategories> {
  CollectionReference proStream =
      FirebaseFirestore.instance.collection('produits');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.menu);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF033D69),
        title: Text(
         widget.menu,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: FutureBuilder<QuerySnapshot>(
          future: proStream.where('menu', isEqualTo: widget.menu).get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

            if (snapshot.data!.docs.isEmpty) {
              return Container(
                  child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 140,
                    ),
                    Text(
                      "No product for this categories",
                    )
                  ],
                ),
              ));
            }

            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          var doc = snapshot.data!.docs[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 70,
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
                                        snapshot.data!.docs[index]['nompro'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 1,
                                      ),
                                      Container(
                                        width: 200,
                                        child: Text(
                                          snapshot.data!.docs[index]['desc']
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 10, height: 1.4),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFF5F5F5),
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.food_bank,
                                                    size: 12,
                                                    color: Color(0xFFCC6600),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[index]
                                                        ['menu'],
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFF5F5F5),
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.monetization_on,
                                                    size: 12,
                                                    color: Color(0xFFCC6600),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[index]
                                                        ['prix'],
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
