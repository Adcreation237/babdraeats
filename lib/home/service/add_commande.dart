import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AddCommandes {
   String Panierid = "";
  DateTime now = DateTime.now();
  String? dateCom, heureCom;
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

  void addCommandes(
      String iduser,
      String prix,
      String nom,
  ) async {
    
    dateCom = DateFormat.yMMMd().format(now);
    heureCom = DateFormat.Hms().format(now);
    Panierid = generateId();
    CollectionReference users =
        FirebaseFirestore.instance.collection('commandes');
    await users.doc(iduser.toString()).set({
      'idcom': Panierid.toString(),
      'iduser': iduser.toString(),
      'prix': prix.toString(),
      'dateCom': dateCom.toString(),
      'heureCom': heureCom.toString(),
      'nom': nom.toString(),
      'statut': 'Envoye',
      'newstatut': 'none',
    }).then((value) {});
  }
}