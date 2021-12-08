import 'package:babdraeats/home/widgets/add_comment.dart';
import 'package:babdraeats/home/widgets/repas_resto_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'comment_of_resto.dart';
import 'maps_view.dart';
import 'service/add_favorite.dart';

class RestoDetails extends StatefulWidget {
  final String idEts;
  const RestoDetails({Key? key, required this.idEts}) : super(key: key);

  @override
  _RestoDetailsState createState() => _RestoDetailsState();
}

class _RestoDetailsState extends State<RestoDetails> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference firebasefirebase =
      FirebaseFirestore.instance.collection('usersResto');
  AddFavorite addFavorite = AddFavorite();
  String like = "0";
  String nbreComment = "0";

  String idfavo = "jkjk";
  bool isFavorite = false;

  Future<void> countLike() async {
    await FirebaseFirestore.instance
        .collection('favorites')
        .where('idets', isEqualTo: widget.idEts)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          like = querySnapshot.docs.length.toString();
        });
      } else {
        setState(() {
          like = '0';
        });
      }
      print('there is ' + like);
    });
  }

  Future<void> countComments() async {
    await FirebaseFirestore.instance
        .collection('commentaires')
        .where('idets', isEqualTo: widget.idEts)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          nbreComment = querySnapshot.docs.length.toString();
        });
      } else {
        setState(() {
          nbreComment = '0';
        });
      }
    });
  }

  void verifyFavo() async {
    await FirebaseFirestore.instance
        .collection('favorites')
        .where('idets', isEqualTo: widget.idEts)
        .where('iduser', isEqualTo: currentUser!.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        setState(() {
          isFavorite = false;
        });
      } else {
        setState(() {
          isFavorite = true;
        });
        for (var i = 0; i < querySnapshot.docs.length; i++) {
          setState(() {
            idfavo = querySnapshot.docs[i].get('idfavorites');
          });
        }
      }
    });
  }

  Future DeleteElementFav() async {
    await FirebaseFirestore.instance
        .collection("favorites")
        .doc(idfavo.toString())
        .delete();
  }

  @override
  void initState() {
    //compter les likes
    countLike();

    //compter les commentaires
    countComments();

    //compter les likes
    verifyFavo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 4000));
        countLike();
        countComments();
        verifyFavo();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FutureBuilder(
              future: firebasefirebase
                  .where('idEts', isEqualTo: widget.idEts)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 60,
                          ),
                          Text("Loading...")
                        ],
                      ),
                    ),
                  );
                }

                if (snapshot.hasData) {
                  return Column(
                    children:
                        List.generate(snapshot.data!.docs.length, (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                      snapshot.data!.docs[index]['images']
                                          .length, (i) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 160,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0.0, 2.0),
                                            blurRadius: 6.0,
                                          )
                                        ],
                                      ),
                                      child: Image(
                                        image: NetworkImage(snapshot
                                            .data!.docs[index]['images'][i]),
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              SafeArea(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
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
                                    Row(
                                      children: [
                                        isFavorite == false
                                            ? IconButton(
                                                icon: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.favorite_border,
                                                      size: 18,
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    isFavorite = true;
                                                    verifyFavo();
                                                  });
                                                  addFavorite.addFavorites(
                                                    currentUser!.uid,
                                                    widget.idEts,
                                                  );
                                                  countLike();
                                                })
                                            : IconButton(
                                                icon: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      shape: BoxShape.circle),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    isFavorite = false;
                                                    verifyFavo();
                                                  });
                                                  DeleteElementFav();
                                                  countLike();
                                                },
                                              ),
                                        IconButton(
                                          icon: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle),
                                            child: Center(
                                              child: Icon(
                                                Icons.comment_sharp,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => AddCommentsPage(
                                                  idets: snapshot.data!
                                                      .docs[index]['idEts'],
                                                  nameEts: snapshot.data!
                                                      .docs[index]['nomEts'],
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data!.docs[index]['nomEts']
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    snapshot.data!
                                                .docs[index]['num_contribuable']
                                                .toString() !=
                                            ' '
                                        ? Icon(
                                            Icons.check_circle,
                                            color: Colors.blue,
                                            size: 22,
                                          )
                                        : Text(""),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "  " +
                                      snapshot.data!.docs[index]['menus']
                                          .toString(),
                                  style: TextStyle(fontSize: 13, height: 1.3),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFFF5F5F5),
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Padding(
                                          padding: EdgeInsets.all(3),
                                          child: Icon(
                                            Icons.hourglass_bottom_rounded,
                                            color: Color(0xFF033D69),
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFFF5F5F5),
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            snapshot
                                                    .data!
                                                    .docs[index]
                                                        ['temps_livraison']
                                                    .toString() +
                                                " min",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
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
                                                Icons.thumb_up_off_alt,
                                                size: 14,
                                                color: Color(0xFF033D69),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                like.toString(),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
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
                                                LineIcons.comment,
                                                size: 14,
                                                color: Color(0xFF033D69),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                nbreComment.toString(),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFFF5F5F5),
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Padding(
                                          padding: EdgeInsets.all(3),
                                          child: Icon(
                                            Icons.access_time,
                                            color: Color(0xFF033D69),
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFFF5F5F5),
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            snapshot
                                                .data!.docs[index]['heure_act']
                                                .toString(),
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.add_business,
                                            size: 16,
                                            color: Color(0xFF033D69),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]['type']
                                                    .toString() +
                                                " Info",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              snapshot.data!
                                                  .docs[index]['localisation']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black
                                                      .withOpacity(0.6)),
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (_) => MapsView(),
                                                  ),
                                                );
                                              },
                                              child: Text("See \nMore"))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                RestoOfComments(idEts: widget.idEts),
                                Container(
                                  padding: EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border(
                                        bottom: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.5)),
                                        left: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.5)),
                                        right: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.5)),
                                        top: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.5))),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Description",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.grey),
                                        textAlign: TextAlign.justify,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 220,
                                            child: Text(
                                              snapshot.data!.docs[index]['desc']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14, height: 1.4),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                          Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey
                                                      .withOpacity(0.6),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Icon(
                                                Icons.arrow_circle_up_outlined,
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => RepasRestoList(
                                          nameEts: snapshot.data!.docs[index]
                                              ['nomEts'],
                                          idEts: snapshot.data!.docs[index]
                                              ['idEts'],
                                        ),
                                      ),
                                    );
                                  },
                                  height: 50,
                                  minWidth: double.infinity,
                                  color: Color(0xFF033D69),
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    "View Menu",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  );
                }

                return Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }
}
