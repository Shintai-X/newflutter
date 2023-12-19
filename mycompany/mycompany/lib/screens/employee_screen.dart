import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mycompany/controllers/employee_controller.dart';
import 'package:mycompany/screens/employee_gestion.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycompany/screens/employee_update.dart';
import 'package:mycompany/screens/home_screen.dart';

class EmployeeScreen extends StatelessWidget {
  EmployeeScreen({Key? key}) : super(key: key);

  EmployeeController controller2 = Get.put(EmployeeController());
  @override
  Widget build(BuildContext context) {
    double width_var = MediaQuery.of(context).size.width;
    double height_var = MediaQuery.of(context).size.height;
    return GetBuilder(
        init: EmployeeController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.to(HomeScreen());
                },
              ),
              title: Text("Employé"),
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
                                  Get.to(EmpRegistreScreen());
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.builder(
                                key: UniqueKey(),
                                itemCount: controller2.emplist.length,
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
                                                    .doc(controller2
                                                        .emplist[index].uid)
                                                    .delete();
                                                controller2.emplist
                                                    .removeAt(index);
                                                controller2.refresh();
                                              },
                                              child: Card(
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.to(EmpUpdateScreen(
                                                        index: index));
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
                                                              image: controller2
                                                                          .emplist[
                                                                              index]
                                                                          .img ==
                                                                      null
                                                                  ? AssetImage(
                                                                      "assets/noir.jpg")
                                                                  : FileImage(File(controller2
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
                                                            "${controller2.emplist[index].firstname} ${controller2.emplist[index].lastname} \n ${controller2.emplist[index].poste}",
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
