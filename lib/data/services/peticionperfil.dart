import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:fritofacil/domain/controller/controluser.dart';
import 'package:get/get.dart';

class Peticiones {
  static final ControlUserAuth controlUserAuth = Get.find();
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;
}
