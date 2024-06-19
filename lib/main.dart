import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fritofacil/domain/controller/controluser.dart';
import 'package:fritofacil/view/app.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (GetPlatform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCJpheybYLSug6vJC5BleOns-IkO9-Gc0Q",
        appId: "1:77606591973:android:a1a19d7aa4ce3e89b2630c",
        messagingSenderId: "77606591973",
        projectId: "fritofacilproject",
        storageBucket: "fritofacilproject.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  Get.put(ControlUserAuth());
  runApp(const MyApp());
}
