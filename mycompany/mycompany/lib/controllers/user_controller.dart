import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mycompany/model/user_model.dart';

class UserController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String? name;
  String? lname;
  String? number;
  String? email;
  String? uid;
  String? date;
  String? Adresse;
  String? img;

  @override
  void onInit() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      print("haaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      print(this.loggedInUser.firstname);
      print(this.loggedInUser.lastname);
      print(this.loggedInUser.email);
      print(this.loggedInUser.number);
      print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB");
      name = this.loggedInUser.firstname!;
      lname = this.loggedInUser.lastname!;
      number = this.loggedInUser.number!;
      email = this.loggedInUser.email!;
      uid = this.loggedInUser.uid;
      date = this.loggedInUser.date;
      Adresse = this.loggedInUser.adresse;
      img = this.loggedInUser.img;
      update();
    });
    super.onInit();
    ever(name as RxString, (value) {
      onInit();
    });
  }

  @override
  void dispose() {
    Get.delete<UserController>();
    super.dispose();
  }
}
