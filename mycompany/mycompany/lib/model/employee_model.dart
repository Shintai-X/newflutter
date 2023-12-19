import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';

class EmployeeModel {
  String? uid;
  String? firstname;
  String? lastname;
  String? email;
  String? img;
  String? poste;
  String? number;

  EmployeeModel(
      {this.firstname,
      this.lastname,
      this.email,
      this.img,
      this.poste,
      this.uid,
      this.number});

  //receiving data from server
  factory EmployeeModel.fromMap(map) {
    return EmployeeModel(
      uid: map['uid'],
      email: map['email'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      number: map['number'],
      poste: map['poste'],
      img: map['img'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'number': number,
      'img': img,
      'poste': poste,
    };
  }
}
