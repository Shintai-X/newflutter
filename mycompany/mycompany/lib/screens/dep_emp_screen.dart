import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mycompany/controllers/departement_controller.dart';
import 'package:mycompany/controllers/deptemp_controller.dart';
import 'package:mycompany/controllers/employee_controller.dart';
import 'package:mycompany/controllers/test_controller.dart';
import 'package:mycompany/model/employee_model.dart';
import 'package:mycompany/screens/employee_gestion.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycompany/screens/employee_update.dart';
import 'package:mycompany/screens/home_screen.dart';

class TwoDeptEmpScreen extends StatelessWidget {
  // DeptEmpScreen({Key? key}) : super(key: key);
  final String? depuid;
  final int? index2;
  TwoDeptEmpScreen(this.depuid, this.index2, {super.key});
  EmployeeController controller4 = Get.put(EmployeeController());
  TestController controller9 = Get.put(TestController());
  DepartementController controller8 = Get.put(DepartementController());

  @override
  Widget build(BuildContext context) {
    double width_var = MediaQuery.of(context).size.width;
    double height_var = MediaQuery.of(context).size.height;

    return GetBuilder(
        init: TestController(),
        builder: (controller) {
          print("I GET REBUILD KNOW");
          // controller9.Pfiou();
          return Scaffold(
            appBar: AppBar(
              // leading: IconButton(
              //   icon: Icon(Icons.arrow_back),
              //   onPressed: () {
              //     Get.to(HomeScreen());
              //   },
              // ),
              title: Text(
                  "${controller9.emplist[index2 as int].name} ${controller9.emplist[index2 as int].empuid.length} "),
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
                                itemCount: controller9
                                    .emplist[index2 as int].empuid.length,
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
                                              onDismissed: (direction) async {
                                                await FirebaseFirestore.instance
                                                    .collection('departement')
                                                    .doc(controller8
                                                        .emplist[index2 as int]
                                                        .empuid[index])
                                                    .delete();

                                                // controller9
                                                //     .emplist[index2 as int]
                                                //     .empuid
                                                //     .removeAt(index);

                                                //await doc.delete();
                                                controller9.update();

                                                controller9.refresh();
                                              },
                                              child: Card(
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Row(
                                                    children: [
                                                      FutureBuilder(
                                                        future: controller4
                                                            .GetImg(controller9
                                                                .emplist[index2
                                                                    as int]
                                                                .empuid[index]),
                                                        builder: (BuildContext
                                                                context,
                                                            AsyncSnapshot<
                                                                    dynamic>
                                                                snapshot) {
                                                          List<Widget> children;

                                                          if (snapshot
                                                              .hasData) {
                                                            children = <Widget>[
                                                              SizedBox(
                                                                height: 80,
                                                                width:
                                                                    width_var *
                                                                        0.20,
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      width_var *
                                                                          0.34,
                                                                  height:
                                                                      height_var *
                                                                          0.18,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16.0),
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: FileImage(
                                                                              File(snapshot.data))
                                                                          as ImageProvider,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ];
                                                          } else if (snapshot
                                                              .hasError) {
                                                            children = <Widget>[
                                                              Text(
                                                                " erreur",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 10,
                                                                ),
                                                              ),
                                                            ];
                                                          } else {
                                                            children =
                                                                const <Widget>[
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
                                                          return Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children:
                                                                  children,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          FutureBuilder(
                                                            future: controller4
                                                                .GetEmp(controller9
                                                                    .emplist[index2
                                                                        as int]
                                                                    .empuid[index]),
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
                                                                    " erreur",
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
                                                              return Center(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children:
                                                                      children,
                                                                ),
                                                              );
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
