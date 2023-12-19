// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mycompany/controllers/employee_controller.dart';
import 'package:mycompany/controllers/user_controller.dart';
import 'package:mycompany/model/employee_model.dart';
import 'package:mycompany/model/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycompany/screens/employee_screen.dart';
import 'package:uuid/uuid.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class EmpUpdateScreen extends StatelessWidget {
  final int index;
  EmpUpdateScreen({required this.index});

  File? pickedFile;
  ImagePicker imagePicker = ImagePicker();
  final _formkey = GlobalKey<FormState>();
  var ispwdhidden = true.obs;
  final firstnameEC = TextEditingController();
  final lastnameEC = TextEditingController();
  final numberEC = TextEditingController();
  final mailEC = TextEditingController();
  final PosteEC = TextEditingController();
  EmployeeController controller2 = Get.put(EmployeeController());

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    double width_var = MediaQuery.of(context).size.width;
    double height_var = MediaQuery.of(context).size.height;
    return GetBuilder<EmployeeController>(
        init: EmployeeController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text("Employee"),
                automaticallyImplyLeading: true,
              ),
              body: Container(
                child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Modifier un employee",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue),
                          ),
                          SizedBox(
                            height: height_var * 0.01,
                          ),
                          Stack(
                            children: <Widget>[
                              SizedBox(
                                height: height_var * 0.03,
                              ),
                              Container(
                                width: width_var * 0.34,
                                height: height_var * 0.18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(File(
                                          controller2.emplist[index].img!))),
                                ),
                              ),
                              //Text("This is the path ${controller.img}"),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  child: Icon(
                                    Icons.camera,
                                    color: Colors.blue,
                                  ),
                                  onTap: () {
                                    print("camera clicked");
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            bottomSheet(context));
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height_var * 0.03,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width_var * 0.46,
                                child: TextFormField(
                                  controller: TextEditingController(
                                    text:
                                        "${controller2.emplist[index].lastname}",
                                  ),
                                  onChanged: (text) {
                                    controller2.emplist[index].lastname = text;
                                  },
                                  validator: (value) {
                                    RegExp regex = new RegExp(r'[A-Za-z]');
                                    if (value!.isEmpty) {
                                      return ("Veuillez saisir un Nom");
                                    }
                                    if (!regex.hasMatch(value)) {
                                      return ("Veuillez saisir un Nom  valide");
                                    }
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width_var * 0.46,
                                child: TextFormField(
                                  controller: TextEditingController(
                                    text:
                                        "${controller2.emplist[index].firstname}",
                                  ),
                                  onChanged: (text) {
                                    controller2.emplist[index].firstname = text;
                                  },
                                  validator: (value) {
                                    RegExp regex = new RegExp(r'[A-Za-z]');
                                    if (value!.isEmpty) {
                                      return ("Veuillez saisir un Prenom");
                                    }
                                    if (!regex.hasMatch(value)) {
                                      return ("Veuillez saisir un Prenom valide");
                                    }
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1)),
                                    hintText: "Prenom*",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height_var * 0.01,
                          ),
                          SizedBox(
                            height: height_var * 0.01,
                          ),
                          TextFormField(
                            controller: TextEditingController(
                              text: "${controller2.emplist[index].email}",
                            ),
                            onChanged: (text) {
                              controller2.emplist[index].email = text;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Veuillez saisir votre email!");
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Veuillez saisir un email valide!");
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              hintText: "Email*",
                            ),
                          ),
                          SizedBox(
                            height: height_var * 0.01,
                          ),
                          TextFormField(
                            controller: TextEditingController(
                              text: "${controller2.emplist[index].number}",
                            ),
                            onChanged: (text) {
                              controller2.emplist[index].number = text;
                            },
                            validator: (value) {
                              RegExp regex = new RegExp(r'^[0-9]{10}$');
                              if (value!.isEmpty) {
                                return ("Veuillez saisir un numero de telephone");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("Veuillez saisir un numero de telephone valide(10 didgts)");
                              }
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              hintText: "Numéro de telephone*",
                            ),
                          ),
                          SizedBox(
                            height: height_var * 0.01,
                          ),
                          TextFormField(
                            controller: TextEditingController(
                              text: "${controller2.emplist[index].poste}",
                            ),
                            onChanged: (text) {
                              controller2.emplist[index].poste = text;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Veuillez saisir un poste");
                              }
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.home),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              hintText: "Poste*",
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                          ),
                          SizedBox(
                            height: height_var * 0.07,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              UpdateEmp();
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.lightBlue,
                                padding: EdgeInsets.symmetric(
                                    horizontal: width_var * 0.32,
                                    vertical: height_var * 0.01),
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            child: Text("Enregistrer"),
                          ),
                          SizedBox(
                            height: height_var * 0.01,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              print('index: ${index}');
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey,
                                padding: EdgeInsets.symmetric(
                                    horizontal: width_var * 0.32,
                                    vertical: height_var * 0.01),
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            child: Text("Supprimer"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget bottomSheet(BuildContext context) {
    double width_var = MediaQuery.of(context).size.width;
    double height_var = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.2,
      margin: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      child: Column(
        children: [
          Text(
            'Veuillez choisir une photo de profil',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: height_var * 0.07,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (() {
                  takePhoto2(ImageSource.gallery);
                }),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      size: 40,
                    ),
                    Text(
                      "Gallerie",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: width_var * 0.25,
              ),
              InkWell(
                onTap: () {
                  takePhoto2(ImageSource.camera);
                },
                child: Column(
                  children: [
                    Icon(Icons.camera, size: 40),
                    Text(
                      "Camera",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void UpdateEmp() {
    var uidd = controller2.emplist[index].uid;
    if (_formkey.currentState!.validate()) {
      final docUser =
          FirebaseFirestore.instance.collection('employees').doc(uidd);

      docUser.update({
        'firstname': controller2.emplist[index].firstname,
        'lastname': controller2.emplist[index].lastname,
        'number': controller2.emplist[index].number,
        'poste': controller2.emplist[index].poste,
        'img': controller2.emplist[index].img,
      });
      Get.to(EmployeeScreen());
    }
  }

  void takePhoto2(ImageSource source) async {
    //EmployeeModel em = EmployeeModel();
    final pickedImage =
        await imagePicker.pickImage(source: source, imageQuality: 100);

    pickedFile = File(pickedImage!.path);
    controller2.img = pickedFile!.path;
  }
}
