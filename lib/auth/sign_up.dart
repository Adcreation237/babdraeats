import 'package:babdraeats/auth/user_form.dart';
import 'package:babdraeats/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  final Function? toggleScreen;

  const SignUp({Key? key, this.toggleScreen}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailControler.dispose();
    passwordControler.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  color: Color(0xFF033D69).withOpacity(0.5),
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
                        "Welcome Boss",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Join Us now.",
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
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UsersForm(
                                        email: emailControler.text,
                                        mdp: passwordControler.text)));
                          }
                        },
                        height: 50,
                        minWidth: double.infinity,
                        color: Color(0xFF033D69),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Next",
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
                          Text("Already Babdra Account ?"),
                          TextButton(
                              onPressed: () {
                                widget.toggleScreen!();
                              },
                              child: Text("Start here.")),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
