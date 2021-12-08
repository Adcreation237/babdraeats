import 'package:babdraeats/home/search_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:line_icons/line_icons.dart';

import 'theme/colors.dart';
import 'widgets/categories_widget.dart';
import 'widgets/custom_slider.dart';
import 'widgets/new_resto_explore.dart';
import 'widgets/popular_resto.dart';
import 'widgets/safety_foods.dart';
import 'widgets/the_best_resto.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => SearchResult()));
                  },
                  icon: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      LineIcons.search,
                      size: 20,
                    ),
                  ),
                ),
              ),
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
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 1000));
        },
        child: getBody(),
      ),
    );
  }

  Widget noConnection() {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off,
                size: 100,
              ),
              Text("No Internet connection")
            ],
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Welcome",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  currentUser!.email.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          CustomSliderWidget(
            items: [
              'assets/banner/level1.png',
              'assets/banner/level2.png',
              'assets/banner/level3.png',
            ],
          ),
          Categories(size: size),
          SizedBox(
            height: 5,
          ),
          TheBestResto(size: size),
          SizedBox(
            height: 15,
          ),
          Container(
            width: size.width,
            height: 10,
            decoration: BoxDecoration(color: textFieldColor),
          ),
          SizedBox(
            height: 5,
          ),
          NewRestoExplore(size: size),
          SizedBox(
            height: 15,
          ),
          Container(
            width: size.width,
            height: 10,
            decoration: BoxDecoration(color: textFieldColor),
          ),
          SizedBox(
            height: 5,
          ),
          ThePopularResto(size: size),
          SizedBox(
            height: 15,
          ),
          Container(
            width: size.width,
            height: 10,
            decoration: BoxDecoration(color: textFieldColor),
          ),
          SizedBox(
            height: 5,
          ),
          SafetyFoods(size: size),
        ],
      ),
    );
  }
}
