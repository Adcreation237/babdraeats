import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddFavorite {
  String Panierid = "";
  String generateId({
    bool hasLetters = true,
    bool husNumbers = false,
  }) {
    final letterLowercase = 'abcdefghijklmnopqrstuvwxyz';
    final letterUppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final numbers = '0123456789';
    final length = 20;

    String chars = '';
    if (hasLetters) chars += '$letterLowercase$numbers$letterUppercase';
    if (husNumbers) chars += '$numbers';

    return List.generate(length, (index) {
      final indexRandow = Random.secure().nextInt(chars.length);
      return chars[indexRandow];
    }).join();
  }

  void addFavorites(
    String uid,
    String idresto,
  ) async {
    Panierid = generateId();
    CollectionReference users =
        FirebaseFirestore.instance.collection('favorites');
    await users.doc(Panierid.toString()).set({
      'idfavorites': Panierid.toString(),
      'iduser': uid.toString(),
      'idets': idresto.toString(),
    });
  }

  
}
