// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:fritofacil/domain/controller/controluser.dart';
import 'package:fritofacil/view/widget/input.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailControl = TextEditingController();
  final TextEditingController passwordControl = TextEditingController();
  final TextEditingController nameControl = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    ControlUserAuth cua = Get.find();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Únete a FritoFacil hoy",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Registrarse con",
                    style: TextStyle(
                        fontSize: 15,
                        color: const Color.fromRGBO(56, 142, 60, 1)),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  RoundedTextField(
                    labeltext: "Email",
                    controller: emailControl,
                  ),
                  RoundedTextField(
                    labeltext: "Password",
                    controller: passwordControl,
                    isPassword: true,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          )),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          cua
                              .createUser(
                                  emailControl.text, passwordControl.text)
                              .then((value) {
                            print('Then block executed');
                            if (cua.userValido == null) {
                              print('Registration failed');
                              Get.snackbar(
                                'Error de registro',
                                cua.mensajesUser,
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.red[700],
                                colorText: Colors.white,
                                borderRadius: 10,
                                margin: const EdgeInsets.all(10),
                                duration: const Duration(seconds: 3),
                                isDismissible: true,
                                dismissDirection: DismissDirection.vertical,
                                forwardAnimationCurve: Curves.easeOutBack,
                                reverseAnimationCurve: Curves.easeInBack,
                              );
                            } else {
                              print('Registration and login successful');
                              if (cua.role == 'administrador') {
                                Get.offAllNamed('/admin');
                              } else {
                                Get.offAllNamed('/homeScreen');
                              }
                            }
                          }).catchError((e) {
                            print('Registration error: $e');
                            Get.snackbar(
                              'Error de registro',
                              'Ocurrió un error durante el registro. Inténtalo de nuevo.',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red[700],
                              colorText: Colors.white,
                              borderRadius: 10,
                              margin: const EdgeInsets.all(10),
                              duration: const Duration(seconds: 3),
                              isDismissible: true,
                              dismissDirection: DismissDirection.vertical,
                              forwardAnimationCurve: Curves.easeOutBack,
                              reverseAnimationCurve: Curves.easeInBack,
                            );
                          });
                        },
                        color: Colors.greenAccent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "Registrarse",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?"),
                  Text(
                    " Login",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(56, 142, 60, 1)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
