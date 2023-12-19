import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mycompany/model/agence_model.dart';
import 'package:mycompany/model/departement_model.dart';

class AgenceController extends GetxController {
  List aglist = <AgenceModel>[];
  String? uid;
  String? adresse;
  String? date;
  String? description;
  String? domaine;
  String? email;
  String img = '';
  String? nom;
  String? size;
  String? numero;
  var dept = <dynamic>[];
  AgenceModel agc = AgenceModel();

  @override
  void onInit() async {
    print("ahahaha");
    try {
      QuerySnapshot emps = await FirebaseFirestore.instance
          .collection('agence')
          .orderBy('nom')
          .get();
      for (var emp in emps.docs) {
        AgenceModel em = AgenceModel();
        em.nom = emp['nom'];
        em.uid = emp['uid'];
        em.adresse = emp['adresse'];
        em.date = emp['date'];
        em.description = emp['description'];
        em.img = emp['img'];
        em.domaine = emp['domaine'];
        em.numero = emp['numero'];
        em.email = emp['email'];
        em.size = emp['size'];
        em.dept = emp['dept'];
        aglist.add(em);
      }
      print('here : ${aglist.length}');
      update();
      refresh();
    } catch (e) {
      Get.snackbar('error', '${e.toString()}');
      print('error ${e.toString()}');
    }
  }

  Future<String?> GetDept(String Euidd) async {
    var emp2 = await FirebaseFirestore.instance
        .collection('departement')
        .doc(Euidd)
        .get();
    agc.nom = emp2['firstname'];

    String? expre = '${agc.nom} ';
    print('hahaha${expre}');
    return expre;
  }
}
