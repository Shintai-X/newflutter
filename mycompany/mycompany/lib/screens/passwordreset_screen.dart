import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mycompany/screens/login_screen.dart';

class ResetPwdScreen extends StatelessWidget {
  ResetPwdScreen({Key? key}) : super(key: key);

  @override
  final mailEC = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    double height_var = MediaQuery.of(context).size.height;
    double width_var = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Réinitialiser le mot de passe'),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height_var * 0.20,
            ),
            Text(
              "Recevez un lien dans votre boite mail pour réinitialiser le mot de passe",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: height_var * 0.05,
            ),
            Form(
              key: _formkey,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Veuillez saisir votre email!");
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return ("Veuillez saisir un email valide!");
                  }
                  return null;
                },
                controller: mailEC,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 1)),
                  hintText: "Adresse e-mail*",
                ),
              ),
            ),
            SizedBox(
              height: height_var * 0.05,
            ),
            ElevatedButton(
              child: Text("Réinitialiser le mot de passe"),
              onPressed: () {
                ResetPwd();
                Get.to(LoginScreen());
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                  padding: EdgeInsets.symmetric(
                      horizontal: width_var * 0.15,
                      vertical: height_var * 0.01),
                  textStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Future ResetPwd() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: mailEC.text.trim());

      Fluttertoast.showToast(msg: "email envoyée!");
    } on FirebaseAuthException catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.message!);
    }
  }
}
