import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mycompany/controllers/agence_controller.dart';
import 'package:mycompany/controllers/departement_controller.dart';
import 'package:mycompany/controllers/employee_controller.dart';
import 'package:mycompany/controllers/test_controller.dart';
import 'package:mycompany/model/departement_model.dart';
import 'package:mycompany/screens/dep_emp_screen.dart';
import 'package:mycompany/screens/dept_user_screen.dart';
import 'package:mycompany/screens/employee_gestion.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycompany/screens/employee_update.dart';
import 'package:mycompany/screens/home_screen.dart';
import 'package:uuid/uuid.dart';

class DepartementScreen extends StatelessWidget {
  final int? inde;
  final String? auid;
  DepartementScreen(this.inde, this.auid);

  final nameEC = TextEditingController();
  DepartementController controller3 = Get.put(DepartementController());
  EmployeeController controller4 = Get.put(EmployeeController());
  TestController controller5 = Get.put(TestController());
  AgenceController controller6 = Get.put(AgenceController());

  @override
  Widget build(BuildContext context) {
    double width_var = MediaQuery.of(context).size.width;
    double height_var = MediaQuery.of(context).size.height;
    return GetBuilder(
        init: DepartementController(),
        builder: (controller2) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.to(HomeScreen());
                },
              ),
              title: Text("Departement"),
              automaticallyImplyLeading: false,
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        )),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ignore: prefer_const_constructors
                          Row(
                            children: [
                              Text(
                                "Ajouter",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.end,
                              ),
                              Spacer(),
                              InkWell(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          child: Container(
                                            width: double.infinity,
                                            height: height_var * 0.37,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            child: Column(
                                              children: [
                                                Text('AJOUTER UN DEPARTEMENT',
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20)),
                                                SizedBox(
                                                  height: height_var * 0.05,
                                                ),
                                                Text(
                                                    'Saisissez le nom du departement'),
                                                SizedBox(
                                                  height: height_var * 0.02,
                                                ),
                                                TextFormField(
                                                  controller: nameEC,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    prefixIcon:
                                                        Icon(Icons.person),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color: Colors.blue,
                                                            width: 1)),
                                                    hintText: "Nom",
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height_var * 0.05,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: width_var * 0.15,
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        AddD();
                                                        Get.back();
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                          primary: Colors.blue,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      width_var *
                                                                          0.01,
                                                                  vertical:
                                                                      height_var *
                                                                          0.001),
                                                          textStyle: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      child: Text("Ajouter "),
                                                    ),
                                                    SizedBox(
                                                      width: width_var * 0.1,
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton.styleFrom(
                                                          primary: Colors.grey,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      width_var *
                                                                          0.01,
                                                                  vertical:
                                                                      height_var *
                                                                          0.001),
                                                          textStyle: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      child: Text("Annuler"),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.builder(
                                key: UniqueKey(),
                                itemCount: controller3.emplist.length,
                                itemBuilder: (BuildContext context, index) {
                                  final item = controller3.emplist[index];
                                  return Row(
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: height_var * 0.1,
                                            width: width_var * 0.9,
                                            child: Dismissible(
                                              key: Key(""),
                                              background: Container(
                                                color: Colors.red,
                                              ),
                                              onDismissed: (direction) {
                                                final docEmp = FirebaseFirestore
                                                    .instance
                                                    .collection('departement')
                                                    .doc(controller3
                                                        .emplist[index].uid)
                                                    .delete();
                                                controller3.emplist
                                                    .removeAt(index);
                                                controller3.refresh();
                                              },
                                              child: Card(
                                                child: InkWell(
                                                  onTap: () {
                                                    print('hna ${auid}');
                                                    final docUser =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'agence')
                                                            .doc(auid);

                                                    docUser.update({
                                                      'dept': FieldValue
                                                          .arrayUnion([
                                                        controller3
                                                            .emplist[index].uid
                                                      ]),
                                                    });
                                                    controller6
                                                        .aglist[index].dept
                                                        .add('haha');

                                                    controller3.emplist
                                                        .removeAt(index);
                                                    // controller5.Pfiou();
                                                    // Get.to(TwoDeptEmpScreen(
                                                    //     controller3
                                                    //         .emplist[index].uid,
                                                    //     index));
                                                    controller3.refresh();
                                                    controller6.update();
                                                    controller6.refresh();
                                                    print("test");
                                                  },
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 80,
                                                        width: width_var * 0.01,
                                                        child: Container(
                                                          width:
                                                              width_var * 0.20,
                                                          height:
                                                              height_var * 0.9,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                          ),
                                                        ),
                                                      ),
                                                      Stack(
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  '${controller3.emplist[index].name}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blue,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              SizedBox(
                                                                height:
                                                                    height_var *
                                                                        0.03,
                                                              ),
                                                              Text('employés',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                  )),
                                                              SizedBox(
                                                                width:
                                                                    width_var *
                                                                        0.3,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: width_var * 0.45,
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            Get.to(DeptEmpScreen(
                                                                controller3
                                                                    .emplist[
                                                                        index]
                                                                    .uid));
                                                          },
                                                          icon:
                                                              Icon(Icons.add)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> AddD() async {
    var emplist = <String>[];
    var uuid = Uuid();
    DepartementModel em = DepartementModel();
    em.uid = uuid.v4();
    em.name = nameEC.text;
    em.empuid = emplist;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection("departement")
        .doc(em.uid)
        .set(em.toMap());
    controller3.emplist.add(em);
    //controller3.update();
    controller3.refresh();
    //controller4.update();
    controller4.refresh();
    nameEC.text = '';
  }
}
