import 'package:babdraeats/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  final Function? toggleScreen;

  const SignIn({Key? key, this.toggleScreen}) : super(key: key);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailControler.dispose();
    passwordControler.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -77,
            right: -77,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(125)),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          widget.toggleScreen!();
                        },
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Sign In to start.",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 14,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        controller: emailControler,
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          } else {
                            return "Please enter your Email address !";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Your Email",
                          prefixIcon: Icon(
                            Icons.mail,
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
                        height: 20,
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        obscureText: true,
                        controller: passwordControler,
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            if (value.length >= 8) {
                              return null;
                            } else {
                              return "Password too short. 8 characters requiered !";
                            }
                          } else {
                            return "Please enter your Password !";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Your Password",
                          prefixIcon: Icon(
                            Icons.vpn_key,
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
                        height: 40,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            print("Email : ${emailControler.text}");
                            print("Email : ${passwordControler.text}");

                            await authService.signInWithEmailAndPassword(
                                emailControler.text, passwordControler.text);
                          }
                        },
                        height: 50,
                        minWidth:
                            authService.isLoadingL ? null : double.infinity,
                        color: Color(0xFFCC6600),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: authService.isLoadingL
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                "Start now",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("No Babdra Account ?"),
                          TextButton(
                              onPressed: () {
                                widget.toggleScreen!();
                              },
                              child: Text("Register here.")),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: authService.errorMessage != ""
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: 80, left: 40, right: 40),
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
    );
  }
}
