import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool isloadingL = false;
  bool get isLoadingL => isloadingL;
  bool isloadingR = false;
  bool get isLoadingR => isloadingR;
  String errormessage = "";
  String uid = "";
  String get errorMessage => errormessage;
  String get Uid => uid;

  Future createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    setLoadingR(true);
    try {
      UserCredential credential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      setLoadingR(false);
      setUid(user!.uid);
      return user;
    } on SocketException {
      setLoadingR(false);
      setMessage("No internet connection !");
    } on FirebaseAuthException catch (e) {
      setLoadingR(false);
      if (e.code == 'weak-password') {
        setMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        setMessage('The account already exists for that email.');
      }
    } catch (e) {
      setLoadingR(false);
      setMessage(e.toString());
    }
  }

  Future signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    setLoadingL(true);
    print("started");
    try {
      UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      setLoadingL(false);
    print("finished");
      return user;
    } on SocketException {
      setLoadingL(false);
      setMessage("No internet connection !");
    } on FirebaseAuthException catch (e) {
      setLoadingL(false);
      if (e.code == 'user-not-found') {
        setMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        setMessage('Wrong password provided for that user.');
      }
    } catch (e) {
      setLoadingL(false);
      setMessage(e.toString());
    }
  }

  Stream<User?>? get user {
    return firebaseAuth.authStateChanges().map((event) => event);
  }

  Future<void> signOut() async {
    return await firebaseAuth.signOut();
  }

  void setLoadingL(val) {
    isloadingL = val;
    notifyListeners();
  }

  void setLoadingR(val) {
    isloadingR = val;
    notifyListeners();
  }

  void setMessage(val) {
    errormessage = val;
    notifyListeners();
  }

  void setUid(val) {
    uid = val;
    notifyListeners();
  }
}
