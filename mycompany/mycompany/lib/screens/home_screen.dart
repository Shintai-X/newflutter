import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mycompany/controllers/agence_controller.dart';
import 'package:mycompany/model/departement_model.dart';
import 'package:mycompany/model/user_model.dart';
import 'package:mycompany/screens/agence_add_screen.dart';
import 'package:mycompany/screens/agence_data_screen.dart';
import 'package:mycompany/screens/departement_screen.dart';
import 'package:mycompany/screens/employee_screen.dart';
import 'package:mycompany/screens/login_screen.dart';
import 'package:mycompany/screens/profil_screen.dart';

import '../controllers/user_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  UserController controller1 = Get.put(UserController());
  AgenceController controller2 = Get.put(AgenceController());
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var height_var = MediaQuery.of(context).size.height;
    var width_var = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: UserController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.blue,
            appBar: AppBar(
              elevation: 0,
              title: Text("Bonjour ${controller1.name}"),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    _signOut();
                    Get.to(LoginScreen());
                  },
                ),
              ],
            ),
            body: Container(
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
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.to(AgenceAddScreen());
                          },
                          icon: Icon(Icons.add),
                          tooltip: 'Ajouter une agence',
                        ),
                        IconButton(
                          onPressed: () {
                            Get.to(EmployeeScreen());
                          },
                          icon: Icon(Icons.person_add),
                          tooltip: 'Ajouter un employé',
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          key: UniqueKey(),
                          itemCount: controller2.aglist.length,
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
                                        onDismissed: (direction) {
                                          FirebaseFirestore.instance
                                              .collection('agence')
                                              .doc(
                                                  controller2.aglist[index].uid)
                                              .delete();

                                          controller2.aglist.removeAt(index);
                                          controller2.refresh();
                                          controller1.refresh();
                                          controller2.update();
                                        },
                                        child: Card(
                                          child: InkWell(
                                            onTap: () {
                                              Get.to(AgenceData(index));

                                              print("test");
                                            },
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: 80,
                                                  width: width_var * 0.01,
                                                  child: Container(
                                                    width: width_var * 0.20,
                                                    height: height_var * 0.9,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            '${controller2.aglist[index].nom}',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        SizedBox(
                                                          height:
                                                              height_var * 0.03,
                                                        ),
                                                        Text('employés',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                            )),
                                                        SizedBox(
                                                          width:
                                                              width_var * 0.3,
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
                                                      Get.to(DepartementScreen(
                                                          index,
                                                          controller2
                                                              .aglist[index]
                                                              .uid));
                                                    },
                                                    icon: Icon(Icons.add)),
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
            bottomNavigationBar: ClipRRect(
              child: BottomAppBar(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width_var * 0.12,
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.home),
                      label: Text(
                        'Acceuil',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        Get.to(HomeScreen());
                      },
                    ),
                    SizedBox(
                      width: width_var * 0.15,
                      height: height_var * 0.09,
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.person),
                      label: Text(
                        'Profil',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        Get.to(ProfilScreen());
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(LoginScreen());
    controller1.dispose();
  }
}
