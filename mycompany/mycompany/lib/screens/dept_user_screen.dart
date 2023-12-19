import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mycompany/controllers/departement_controller.dart';
import 'package:mycompany/controllers/deptemp_controller.dart';
import 'package:mycompany/controllers/employee_controller.dart';
import 'package:mycompany/screens/employee_gestion.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycompany/screens/employee_update.dart';
import 'package:mycompany/screens/home_screen.dart';

class DeptEmpScreen extends StatelessWidget {
  // DeptEmpScreen({Key? key}) : super(key: key);
  final String? depuid;
  DeptEmpScreen(this.depuid);
  EmployeeController controller4 = Get.put(EmployeeController());
  DepartementController controller5 = Get.put(DepartementController());
  @override
  Widget build(BuildContext context) {
    double width_var = MediaQuery.of(context).size.width;
    double height_var = MediaQuery.of(context).size.height;
    return GetBuilder<EmployeeController>(
        init: EmployeeController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              // leading: IconButton(
              //   icon: Icon(Icons.arrow_back),
              //   onPressed: () {
              //     Get.to(HomeScreen());
              //     controller5.refresh();
              //     controller4.refresh();
              //   },
              // ),
              title: Text("Employé "),
              automaticallyImplyLeading: true,
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

                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: ListView.builder(
                                key: UniqueKey(),
                                itemCount: controller4.emplist.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Row(
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: height_var * 0.15,
                                            width: width_var * 0.9,
                                            child: Dismissible(
                                              key: Key(""),
                                              background: Container(
                                                color: Colors.red,
                                              ),
                                              onDismissed: (direction) {
                                                final docEmp = FirebaseFirestore
                                                    .instance
                                                    .collection('employees')
                                                    .doc(controller4
                                                        .emplist[index].uid)
                                                    .delete();
                                                controller4.emplist
                                                    .removeAt(index);
                                                controller4.refresh();
                                                controller5.refresh();
                                              },
                                              child: Card(
                                                child: InkWell(
                                                  onTap: () {
                                                    final docUser =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'departement')
                                                            .doc(depuid);
                                                    print(docUser);

                                                    docUser.update({
                                                      'empuid': FieldValue
                                                          .arrayUnion([
                                                        '${controller4.emplist[index].uid}'
                                                      ]),
                                                    });
                                                    controller5
                                                        .emplist[index].empuid
                                                        .add(controller4
                                                            .emplist[index]
                                                            .uid);
                                                    controller4.emplist
                                                        .removeAt(index);
                                                    controller4.update();
                                                    controller5.update();
                                                    controller5.refresh();
                                                    Get.back();
                                                  },
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 80,
                                                        width: width_var * 0.20,
                                                        child: Container(
                                                          width:
                                                              width_var * 0.34,
                                                          height:
                                                              height_var * 0.18,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: controller4
                                                                          .emplist[
                                                                              index]
                                                                          .img ==
                                                                      null
                                                                  ? AssetImage(
                                                                      "assets/noir.jpg")
                                                                  : FileImage(File(controller4
                                                                      .emplist[
                                                                          index]
                                                                      .img!)) as ImageProvider,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "${controller4.emplist[index].firstname} ${controller4.emplist[index].lastname} \n ${controller4.emplist[index].poste}",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
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
}
