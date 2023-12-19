import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mycompany/model/employee_model.dart';

class EmployeeController extends GetxController {
  var emplist = <EmployeeModel>[];
  EmployeeModel empX = EmployeeModel();
  String? uid;
  String? firstname;
  String? lastname;
  String? email;
  String img = '';
  String? poste;
  String? number;

  @override
  void onInit() async {
    try {
      QuerySnapshot emps = await FirebaseFirestore.instance
          .collection('employees')
          .orderBy('firstname')
          .get();
      for (var emp in emps.docs) {
        EmployeeModel em = EmployeeModel();
        em.uid = emp['uid'];
        em.firstname = emp['firstname'];
        em.lastname = emp['lastname'];
        em.poste = emp['poste'];
        em.img = emp['img'];
        em.email = emp['email'];
        em.number = emp['number'];
        emplist.add(em);
        update();
        refresh();
      }

      update();
    } catch (e) {
      Get.snackbar('error', '${e.toString()}');
    }
  }

  Future<String?> GetEmp(String Euidd) async {
    var emp2 = await FirebaseFirestore.instance
        .collection('employees')
        .doc(Euidd)
        .get();
    empX.firstname = emp2['firstname'];
    empX.lastname = emp2['lastname'];
    empX.img = emp2['img'];
    update();
    print('hey ${empX.firstname}');
    String? expre = '${empX.firstname} ${empX.lastname}';
    return expre;
  }

  Future<String?> GetXmp(String Euid) async {
    var emp2 = await FirebaseFirestore.instance
        .collection('employees')
        .doc(Euid)
        .get();
    empX.uid = emp2['uid'];
    String? exp = empX.uid;
    update();

    return exp;
  }

  Future<String?> GetImg(String Euid) async {
    var emp2 = await FirebaseFirestore.instance
        .collection('employees')
        .doc(Euid)
        .get();
    update();
    empX.img = emp2['img'];
    return empX.img;
  }

  Future<void> Del(String Euid) async {
    var emp2 = await FirebaseFirestore.instance
        .collection('employees')
        .doc(Euid)
        .delete();

    update();
  }
}
