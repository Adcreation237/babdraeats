import 'package:cloud_firestore/cloud_firestore.dart';

class ManipulateUsers {
  
  void addusers(
    String uid,
    String email,
    String name,
    String mdp,
    String phone,
    String Haddress,
    String Waddress,
    String ville,
  ) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    await users.doc(uid.toString()).set({
      'email': email.toString(),
      'iduser': uid.toString(),
      'name': name.toString(),
      'mdp': mdp.toString(),
      'phone': phone.toString(),
      'Haddress': Haddress.toString(),
      'Waddress': Waddress.toString(),
      'ville': ville.toString(),
    });
  }

   void addRestos(
    String Frais_livraison,
      String categories,
      String desc,
      String idEts,
      String phone,
      String images,
      String localisation,
      String nomEts,
      String repere1,
      String repere2,
      String temps_livraison,
      String type,
  ) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersResto');
    await users.doc(idEts.toString()).set({
      'Frais_livraison': Frais_livraison.toString(),
      'categories': categories.toString(),
      'desc': desc.toString(),
      'idEts': idEts.toString(),
      'phone': phone.toString(),
      'images': images.toString(),
      'localisation': localisation.toString(),
      'nomEts': nomEts.toString(),
      'lat': repere1.toString(),
      'long': repere2.toString(),
      'sponsor': 'false',
      'temps_livraison': temps_livraison.toString(),
      'type': type.toString(),
    }).then((value) {});
  }
}