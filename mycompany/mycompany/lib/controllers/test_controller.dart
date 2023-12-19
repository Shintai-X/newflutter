import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mycompany/model/departement_model.dart';
import 'package:mycompany/model/employee_model.dart';

class TestController extends GetxController {
  var emplist = <DepartementModel>[];
  String? uid;
  String? name;
  var empuid = <dynamic>[];

  @override
  void onInit() async {}
  void Pfiou() async {
    emplist.clear();
    print("HELLO NIZ");
    QuerySnapshot emps = await FirebaseFirestore.instance
        .collection('departement')
        .orderBy('name')
        .get();
    for (var emp in emps.docs) {
      DepartementModel em = DepartementModel();
      em.name = emp['name'];
      em.uid = emp['uid'];
      em.empuid = emp['empuid'];
      //print(em.empuid.length);
      emplist.add(em);
    }
    print('The employee list has ${emplist.length} items');
    update();
    refresh();
  }
}
