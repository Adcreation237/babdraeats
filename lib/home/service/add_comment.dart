import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddComments {

  String Panierid = "";
  DateTime _dateTime = DateTime.now();

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

  void addCommentaires(
    String uid,
    String idresto,
    String commentaires,
  ) async {
    Panierid = generateId();
    CollectionReference users =
        FirebaseFirestore.instance.collection('commentaires');
    await users.doc(Panierid.toString()).set({
      'idcomment': Panierid.toString(),
      'idcommenter': uid.toString(),
      'idets': idresto.toString(),
      'commentaires': commentaires.toString(),
      'date': _dateTime,
    }).then((value) {});
  }
}
