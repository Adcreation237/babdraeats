import 'package:babdraeats/home/service/add_comment.dart';
import 'package:babdraeats/home/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import 'load_comment.dart';

class AddCommentsPage extends StatefulWidget {
  final String idets;
  final String nameEts;
  const AddCommentsPage({Key? key, required this.idets, required this.nameEts})
      : super(key: key);

  @override
  _AddCommentsPageState createState() => _AddCommentsPageState();
}

class _AddCommentsPageState extends State<AddCommentsPage> {
  TextEditingController commentText = TextEditingController();
  final formKey = GlobalKey<FormState>();

  CollectionReference firebasefirebase =
      FirebaseFirestore.instance.collection('commentaires');
  AddComments addComments = AddComments();
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    commentText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: Color(0xFF033D69),
        title: Text(
          widget.nameEts,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  LineIcons.comment,
                  size: 15,
                  color: Color(0xFF033D69),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "People say about ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                Text(
                  widget.nameEts + "...",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
              child: Divider(),
            ),
            FutureBuilder(
              future: firebasefirebase
                  .where('idets', isEqualTo: widget.idets)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return load_comment();
                }
                if (snapshots.hasData) {
                  return Container(
                    height: 380,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            List.generate(snapshots.data!.docs.length, (index) {
                          //calcul taille
                          var taille = snapshots
                                      .data!.docs[index]['commentaires']
                                      .toString()
                                      .length *
                                  10 +
                              30;
                          if (taille >= 300) {
                            taille = 260;
                          }
                          var datetake = DateTime.fromMillisecondsSinceEpoch(
                              snapshots.data!.docs[index]['date'].seconds *
                                  1000);
                          var dateshow =
                              DateFormat('dd-M-yyyy H:mm').format(datetake);
                          return Column(
                            children: [
                              snapshots.data!.docs[index]['idcommenter'] !=
                                      currentUser!.uid
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 2),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Color(0xFF033D69),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Icon(
                                              Icons.person_outline,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width:
                                                double.parse(taille.toString()),
                                            decoration: BoxDecoration(
                                                color: Color(0xFF033D69)
                                                    .withOpacity(0.05),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12, horizontal: 15),
                                              child: Text(
                                                snapshots.data!
                                                    .docs[index]['commentaires']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF033D69),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 2),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Color(0xFF660C54),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Icon(
                                              Icons.person_outline,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width:
                                                double.parse(taille.toString()),
                                            decoration: BoxDecoration(
                                                color: Color(0xFF033D69)
                                                    .withOpacity(0.05),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12, horizontal: 15),
                                              child: Text(
                                                snapshots.data!
                                                    .docs[index]['commentaires']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF033D69),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(dateshow.toString(),style: TextStyle(fontSize: 10),),
                                    Divider(),
                                  ],
                                ),
                              )
                            ],
                          );
                        }),
                      ),
                    ),
                  );
                }
                return load_comment();
              },
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 90,
        width: size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.black.withOpacity(0.1),
              ),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Form(
            key: formKey,
            child: Row(
              children: [
                Container(
                  height: 45,
                  padding: EdgeInsets.only(left: 20, right: 5),
                  width: 260,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextFormField(
                    keyboardAppearance: Brightness.light,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "write your comment...",
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                    ),
                    controller: commentText,
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return "Please enter your comment !";
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF033D69),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          addComments.addCommentaires(
                              currentUser!.uid.toString(),
                              widget.idets,
                              commentText.text);
                              commentText.clear();
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
