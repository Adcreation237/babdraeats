import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddPanier {
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

  void addPanier(
    String idpro,
    String idresto,
    String iduser,
    String image,
    String nom,
    String prix,
    String qte,
  ) async {
    Panierid = generateId();
    CollectionReference users = FirebaseFirestore.instance.collection('panier');
    await users.doc(Panierid.toString()).set({
      'idpanier': Panierid.toString(),
      'idpro': idpro.toString(),
      'idresto': idresto.toString(),
      'iduser': iduser.toString(),
      'image': image.toString(),
      'nom': nom.toString(),
      'prix': prix.toString(),
      'qte': qte.toString(),
      'commande': 'non',
    }).then((value) {});
  }
}
