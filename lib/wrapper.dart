import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/wrapper_auth.dart';
import 'onboard/onboarding.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int? onView;
  @override
  void initState() {
    sharedFunction();
    // TODO: implement initState
    super.initState();
  }

  sharedFunction() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    onView = preferences.getInt("onView");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: StreamBuilder(
            stream: Connectivity().onConnectivityChanged,
            builder: (BuildContext context,
                AsyncSnapshot<ConnectivityResult> snapshot) {
              if (snapshot.data == ConnectivityResult.none) {
                return noConnection();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: CircularProgressIndicator()),
                      SizedBox(
                        height: 60,
                      ),
                      Center(
                        child: Text(
                          "Chargement encours...",
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                );
              }
              if (snapshot.hasData) {
                return onView == 1 ? WrapperAuth() : OnBoarding();
              }
              if (snapshot.hasError) {
                return Container(
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.equalizer_rounded,
                          size: 50,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Refresh page",
                          style: TextStyle(fontSize: 20, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                    SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: Text(
                        "Veuillez patienter\nChargement encours...",
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
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
}
