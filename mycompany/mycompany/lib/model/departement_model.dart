import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:mycompany/model/employee_model.dart';

class DepartementModel {
  String? uid;
  String? name;
  late List<dynamic> empuid;

  DepartementModel({this.name, empuid});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'empuid': empuid,
    };
  }

  factory DepartementModel.fromMap(map) {
    return DepartementModel(
      empuid: map['empuid'],
    );
  }
}
