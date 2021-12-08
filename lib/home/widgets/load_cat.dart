import 'package:flutter/material.dart';

class showCategorieLoading extends StatelessWidget {
  const showCategorieLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.all(10),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10)
            ),
          ),
        ],
      ),
    );
  }
}
