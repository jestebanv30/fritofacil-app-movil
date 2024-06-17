// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:fritofacil/domain/controller/controluser.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailControl = TextEditingController();
  final TextEditingController passwControl = TextEditingController();

  LoginPage({super.key});

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Iniciar sesión",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Inicia sesión en FritoFacil",
                          style: TextStyle(
                              fontSize: 15,
                              color: const Color.fromRGBO(56, 142, 60, 1)),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        makeInput(label: "Email", controller: emailControl),
                        makeInput(
                            label: "Password",
                            controller: passwControl,
                            obscureText: true),
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
                              print('Login button pressed');
                              cua
                                  .loginUser(
                                      emailControl.text, passwControl.text)
                                  .then((value) {
                                print('Then block executed');
                                if (cua.userValido == null) {
                                  print('Login failed');
                                  Get.snackbar(
                                    'Error de inicio de sesión',
                                    'Correo electrónico o contraseña incorrectos',
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: Colors.amber,
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
                                  print('Login successful');
                                  if (cua.role == 'administrador') {
                                    Get.offAllNamed('/admin');
                                  } else {
                                    Get.offAllNamed('/homeScreen');
                                  }
                                }
                              }).catchError((e) {
                                print('Login error: $e');
                              });
                            },
                            color: Colors.greenAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Iniciar sesión",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account?"),
                        Text(
                          " Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(56, 142, 60, 1)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, controller, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }
}
