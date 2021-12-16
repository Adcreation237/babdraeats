import 'package:flutter/material.dart';

class NoteLivreur extends StatefulWidget {
  const NoteLivreur({Key? key}) : super(key: key);

  @override
  _NoteLivreurState createState() => _NoteLivreurState();
}

class _NoteLivreurState extends State<NoteLivreur> {
  TextEditingController commentText = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
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
                    image: AssetImage('assets/images/profil.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
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
                    ],
                  ),
                )
              ],
            ),
            Choice(
              title: 'Nom du Livreur : ',
              desc: 'ATANGANA Bertin',
            ),
            Choice(
              title: 'Spécialité ',
              desc: 'Etudiant',
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
                        if (formKey.currentState!.validate()) {}
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

class Choice extends StatelessWidget {
  final String title;
  final String desc;
  const Choice({
    Key? key,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Container(
            height: 50,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blueGrey)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  desc,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
