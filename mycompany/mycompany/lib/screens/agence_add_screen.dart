// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mycompany/controllers/agence_controller.dart';
import 'package:mycompany/controllers/user_controller.dart';
import 'package:mycompany/model/agence_model.dart';
import 'package:mycompany/model/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class AgenceAddScreen extends StatelessWidget {
  AgenceAddScreen({Key? key}) : super(key: key);
  File? pickedFile;
  ImagePicker imagePicker = ImagePicker();
  final _formkey = GlobalKey<FormState>();
  //var ispwdhidden = true.obs;
  final nameEC = TextEditingController();
  final sizeEC = TextEditingController();
  final domaineEC = TextEditingController();
  final mailEC = TextEditingController();
  final numberEC = TextEditingController();
  final adresseEc = TextEditingController();
  final descriptionEc = TextEditingController();
  final dateEc = TextEditingController();
  AgenceController controller2 = Get.put(AgenceController());
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    double width_var = MediaQuery.of(context).size.width;
    double height_var = MediaQuery.of(context).size.height;
    return GetBuilder<AgenceController>(
        init: AgenceController(),
        builder: (controller2) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text('Agence'),
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
                            "Ajouter une Agence",
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
                                    image: AssetImage("assets/noir.jpg"),
                                  ),
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
                                  controller: nameEC,
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
                                    hintText: 'Nom',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width_var * 0.46,
                                child: TextFormField(
                                  controller: sizeEC,
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
                                    hintText: "Size",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height_var * 0.01,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width_var * 0.46,
                                child: TextFormField(
                                  controller: domaineEC,
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
                                    hintText: 'Domaine',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width_var * 0.46,
                                child: TextFormField(
                                  controller: dateEc,
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
                                    hintText: "Date",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height_var * 0.01,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width_var * 0.46,
                                child: TextFormField(
                                  controller: mailEC,
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
                                    hintText: 'Adresse e-mail',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width_var * 0.46,
                                child: TextFormField(
                                  controller: numberEC,
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
                                    hintText: "Numero de téléphone",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height_var * 0.01,
                          ),
                          TextFormField(
                            controller: adresseEc,
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
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              hintText: "Adresse",
                            ),
                          ),
                          SizedBox(
                            height: height_var * 0.01,
                          ),
                          TextFormField(
                            controller: descriptionEc,
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
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              hintText: "Description",
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
                              Add();
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.lightBlue,
                                padding: EdgeInsets.symmetric(
                                    horizontal: width_var * 0.30,
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
                              Get.to(HomeScreen());
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey,
                                padding: EdgeInsets.symmetric(
                                    horizontal: width_var * 0.34,
                                    vertical: height_var * 0.01),
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            child: Text("Annuler"),
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
                  takePhoto(ImageSource.gallery);
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
                  takePhoto(ImageSource.camera);
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

  Future<void> Add() async {
    if (_formkey.currentState!.validate()) {
      AgenceModel ag = AgenceModel();
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var uuid = Uuid();
      ag.uid = uuid.v4();
      ag.nom = nameEC.text;
      ag.domaine = domaineEC.text;
      ag.size = mailEC.text;
      ag.adresse = adresseEc.text;
      ag.description = descriptionEc.text;
      ag.numero = numberEC.text;
      ag.img = controller2.img;
      ag.email = mailEC.text;
      ag.date = dateEc.text;
      ag.dept = [''];
      await firebaseFirestore.collection("agence").doc(ag.uid).set(ag.toMap());
      controller2.aglist.add(ag);
      //Get.to(EmployeeScreen());

      controller2.update();
      controller2.refresh();
      Get.to(HomeScreen());
    }
  }

  void takePhoto(ImageSource source) async {
    final pickedImage =
        await imagePicker.pickImage(source: source, imageQuality: 100);

    pickedFile = File(pickedImage!.path);
    controller2.img = pickedFile!.path;
    print("this is the path ${controller2.img}");
    //print("this is the image path ${pickedFile}");
  }
}
