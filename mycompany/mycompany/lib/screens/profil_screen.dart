import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mycompany/controllers/user_controller.dart';
import 'package:mycompany/model/user_model.dart';
import 'package:image_picker/image_picker.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class ProfilScreen extends StatelessWidget {
  ProfilScreen({Key? key}) : super(key: key);
  File? pickedFile;
  ImagePicker imagePicker = ImagePicker();
  final _formkey = GlobalKey<FormState>();
  var ispwdhidden = true.obs;
  final firstnameEC = TextEditingController();
  final lastnameEC = TextEditingController();
  final numberEC = TextEditingController();
  final mailEC = TextEditingController();
  final adresseEC = TextEditingController();
  final dateEC = TextEditingController();
  UserController controller = Get.put(UserController());
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    double width_var = MediaQuery.of(context).size.width;
    double height_var = MediaQuery.of(context).size.height;
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text("Profil"),
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
                          "Modifer votre profil",
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
                                  image: (controller.img != null &&
                                          controller.img!.isNotEmpty)
                                      ? FileImage(File(controller.img!))
                                          as ImageProvider
                                      : AssetImage("assets/noir.jpg"),
                                ),
                              ),
                            ),
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
                                validator: (value) {
                                  RegExp regex = new RegExp(r'[A-Za-z]');
                                  if (value == null || value.isEmpty) {
                                    return ("Veuillez saisir un Nom");
                                  }
                                  if (!regex.hasMatch(value)) {
                                    return ("Veuillez saisir un Nom  valide");
                                  }
                                },
                                controller: TextEditingController(
                                  text: controller.lname,
                                ),
                                onChanged: (text) {
                                  controller.lname = text;
                                  print("it's my name ${lastnameEC.text}");
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
                                validator: (value) {
                                  RegExp regex = new RegExp(r'[A-Za-z]');
                                  if (value == null || value.isEmpty) {
                                    return ("Veuillez saisir un Prenom");
                                  }
                                  if (!regex.hasMatch(value)) {
                                    return ("Veuillez saisir un Prenom valide");
                                  }
                                },
                                controller: TextEditingController(
                                  text: controller.name,
                                ),
                                onChanged: (text) {
                                  controller.name = text;
                                  print("it's my name ${firstnameEC.text}");
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(Icons.person),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 1)),
                                  hintText: controller.name ?? "Prenom",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height_var * 0.01,
                        ),
                        TextFormField(
                            // ... (Your existing code)
                            ),
                        SizedBox(
                          height: height_var * 0.01,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ("Veuillez saisir votre email!");
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Veuillez saisir un email valide!");
                            }
                            return null;
                          },
                          controller: TextEditingController(
                            text: controller.email,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1)),
                          ),
                        ),
                        SizedBox(
                          height: height_var * 0.01,
                        ),
                        TextFormField(
                          validator: (value) {
                            RegExp regex = new RegExp(r'^[0-9]{10}$');
                            if (value == null || value.isEmpty) {
                              return ("Veuillez saisir un numero de telephone");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Veuillez saisir un numero de telephone valide(10 didgts)");
                            }
                          },
                          controller: TextEditingController(
                            text: controller.number,
                          ),
                          onChanged: (text) {
                            controller.number = text;
                            print("it's my name ${numberEC.text}");
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1)),
                          ),
                        ),
                        SizedBox(
                          height: height_var * 0.01,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ("Veuillez saisir une adresse");
                            }
                          },
                          controller: TextEditingController(
                            text: controller.Adresse,
                          ),
                          onChanged: (text) {
                            controller.Adresse = text;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.home),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1)),
                            hintText: "Adresse*",
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
                            UpdateUser();
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
      },
    );
  }

  void UpdateUser() {
    if (_formkey.currentState!.validate()) {
      final docUser =
          FirebaseFirestore.instance.collection('users').doc(controller.uid);
      print('this is the user uid:${controller.uid}');
      print("this is the user name ${firstnameEC}");

      docUser.update({
        'firstname': controller.lname,
        'lastname': controller.name,
        'number': controller.number,
        'adresse': controller.Adresse,
        'date': controller.date,
        'img': controller.img,
      });
      Get.to(HomeScreen());
      controller.dispose();
    }
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

  void takePhoto(ImageSource source) async {
    final pickedImage =
        await imagePicker.pickImage(source: source, imageQuality: 100);

    pickedFile = File(pickedImage!.path);
    controller.img = pickedFile!.path;
    print("this is the path ${controller.img}");
    //print("this is the image path ${pickedFile}");
  }
}
