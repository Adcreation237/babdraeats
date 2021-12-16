import 'package:babdraeats/services/add_user.dart';
import 'package:babdraeats/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../bottom_bar.dart';

class UpdateForm extends StatefulWidget {
  @override
  _UpdateFormState createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController ville = TextEditingController();
  TextEditingController localisation1 = TextEditingController();
  TextEditingController localisation2 = TextEditingController();

  final formKey = GlobalKey<FormState>();
  ManipulateUsers manipulateUsers = ManipulateUsers();

  FlutterLocalNotificationsPlugin? localNotification;
  Future showNotification(String email) async {
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "channelName",
        channelDescription: "Confirmation of Authentification",
        importance: Importance.high);

    var iOSDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await localNotification!.show(
        0,
        "Babdra Eats",
        "Hello ! $email. Vos Informations ont été modifiées",
        generalNotificationDetails);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var androidInitialize = new AndroidInitializationSettings("background");
    var iOSInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification!.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Form(
            key: formKey,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Update your \nInformations",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Babdra Eats the right way.",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      controller: name,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          if (value.length > 3) {
                            return null;
                          } else {
                            return "Most have more than 3 caracters !";
                          }
                        } else {
                          return "Please enter your Name !";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Your Name",
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xFFCC6600),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      controller: ville,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return "Please enter your City !";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Your City",
                        prefixIcon: Icon(
                          Icons.location_history_rounded,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xFFCC6600),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.phone,
                      maxLength: 9,
                      controller: phone,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          if (value.length == 9) {
                            return null;
                          } else {
                            return "Invalid Phone number !";
                          }
                        } else {
                          return "Please enter your Phone number !";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Your Phone number",
                        prefixIcon: Icon(
                          Icons.phone_android_outlined,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xFFCC6600),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Home address.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      controller: localisation1,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return "Please enter your Home address !";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Your Home address",
                        prefixIcon: Icon(
                          Icons.location_history,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.deepOrangeAccent),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Work address.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      controller: localisation2,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return "Please enter your Work address !";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Your Work address",
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.deepOrangeAccent),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomBar(pages: 3)));
                        }
                      },
                      height: 50,
                      minWidth: authService.isLoadingR ? null : double.infinity,
                      color: Color(0xFF033D69),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: authService.isLoadingR
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              "Update informations",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Positioned(
                  child: authService.errorMessage != ""
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 80, left: 40, right: 40),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.redAccent,
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(0.0, 0.0),
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text(
                                authService.errorMessage,
                                style: TextStyle(color: Colors.red),
                              ),
                              leading: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    authService.setMessage("");
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  )),
                            ),
                          ),
                        )
                      : Center(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
