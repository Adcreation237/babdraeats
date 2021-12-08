import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shimmer/shimmer.dart';

class RestoOfComments extends StatefulWidget {
  final String idEts;
  const RestoOfComments({Key? key, required this.idEts}) : super(key: key);

  @override
  _RestoOfCommentsState createState() => _RestoOfCommentsState();
}

class _RestoOfCommentsState extends State<RestoOfComments> {
  CollectionReference firebasefirebase =
      FirebaseFirestore.instance.collection('commentaires');
  @override
  Widget build(BuildContext context) {
    return Column(
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
              "People say...",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        FutureBuilder(
          future:
              firebasefirebase.where('idets', isEqualTo: widget.idEts).get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 180,
                      decoration: BoxDecoration(
                          color: Color(0xFF033D69).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                          color: Color(0xFF033D69).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ],
                ),
                baseColor: Colors.grey.withOpacity(0.5),
                highlightColor: Colors.blueGrey.withOpacity(0.5),
              );
            }
            if (snapshots.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(snapshots.data!.docs.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xFF033D69).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Text(
                              snapshots.data!.docs[index]['commentaires']
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF033D69),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }
            return Shimmer.fromColors(
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 180,
                      decoration: BoxDecoration(
                          color: Color(0xFF033D69).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                          color: Color(0xFF033D69).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ],
                ),
                baseColor: Colors.grey.withOpacity(0.5),
                highlightColor: Colors.blueGrey.withOpacity(0.5),
              );
          },
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
