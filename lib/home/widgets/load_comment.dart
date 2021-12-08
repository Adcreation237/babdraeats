
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class load_comment extends StatelessWidget {
  const load_comment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 180,
            decoration: BoxDecoration(
                color: Color(0xFF033D69).withOpacity(0.2),
                borderRadius: BorderRadius.circular(30)),
          ),
          SizedBox(height: 10,),
          Container(
            height: 40,
            width: 90,
            decoration: BoxDecoration(
                color: Color(0xFF033D69).withOpacity(0.2),
                borderRadius: BorderRadius.circular(30)),
          ),
          SizedBox(height: 10,),
          Container(
            height: 40,
            width: 140,
            decoration: BoxDecoration(
                color: Color(0xFF033D69).withOpacity(0.2),
                borderRadius: BorderRadius.circular(30)),
          ),
          SizedBox(height: 10,),
          Container(
            height: 40,
            width: 270,
            decoration: BoxDecoration(
                color: Color(0xFF033D69).withOpacity(0.2),
                borderRadius: BorderRadius.circular(30)),
          ),
          SizedBox(height: 10,),
          Container(
            height: 40,
            width: 220,
            decoration: BoxDecoration(
                color: Color(0xFF033D69).withOpacity(0.2),
                borderRadius: BorderRadius.circular(30)),
          ),
          SizedBox(height: 10,),
          Container(
            height: 40,
            width: 190,
            decoration: BoxDecoration(
                color: Color(0xFF033D69).withOpacity(0.2),
                borderRadius: BorderRadius.circular(30)),
          ),
          SizedBox(height: 10,),
          Container(
            height: 40,
            width: 180,
            decoration: BoxDecoration(
                color: Color(0xFF033D69).withOpacity(0.2),
                borderRadius: BorderRadius.circular(30)),
          ),
          SizedBox(height: 10,),
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
}