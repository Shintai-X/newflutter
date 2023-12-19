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

class AgenceData extends StatelessWidget {
  final int? index2;
  AgenceData(this.index2, {super.key});
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
        init: AgenceController(),
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

                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.builder(
                                key: UniqueKey(),
                                itemCount: controller6
                                    .aglist[index2 as int].dept.length,
                                itemBuilder: (BuildContext context, index) {
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
                                              onDismissed: (direction) {},
                                              child: Card(
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          FutureBuilder(
                                                            future: controller6
                                                                .GetDept(controller6
                                                                    .aglist[index2
                                                                        as int]
                                                                    .dept[index]),
                                                            builder: (BuildContext
                                                                    context,
                                                                AsyncSnapshot<
                                                                        dynamic>
                                                                    snapshot) {
                                                              List<Widget>
                                                                  children;
                                                              if (snapshot
                                                                  .hasData) {
                                                                children =
                                                                    <Widget>[
                                                                  Text(
                                                                    " ${snapshot.data}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                ];
                                                              } else if (snapshot
                                                                  .hasError) {
                                                                children =
                                                                    <Widget>[
                                                                  Text(
                                                                    " erreur ",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .blue,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          10,
                                                                    ),
                                                                  ),
                                                                ];
                                                              } else {
                                                                children =
                                                                    const <
                                                                        Widget>[
                                                                  SizedBox(
                                                                    width: 60,
                                                                    height: 60,
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                16),
                                                                    child: Text(
                                                                        'Awaiting result...'),
                                                                  ),
                                                                ];
                                                              }
                                                              return Text(
                                                                  '${snapshot.data}');
                                                            },
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
