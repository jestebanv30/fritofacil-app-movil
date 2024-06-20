// ignore_for_file: use_super_parameters, file_names, prefer_const_constructors, use_build_context_synchronously, camel_case_types, library_private_types_in_public_api, avoid_init_to_null

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fritofacil/src/controller/product_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Product {
  final String name;
  final int price;
  final int? off;
  final String about;
  final bool isAvailable;
  final String imageUrl;
  final bool isFavorite;
  final double rating;
  final String category;

  Product({
    required this.name,
    required this.price,
    required this.off,
    required this.about,
    required this.isAvailable,
    required this.imageUrl,
    required this.isFavorite,
    required this.rating,
    required this.category,
  });
}

class ProductUpload extends StatefulWidget {
  const ProductUpload({Key? key}) : super(key: key);

  @override
  State<ProductUpload> createState() => _ProductUploadState();
}

class _ProductUploadState extends State<ProductUpload> {
  late File? sampleImage = null;
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController offController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FRITOFACILL"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Nombre'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa un nombre';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(labelText: 'Precio anterior'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor introduce un precio';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: offController,
                    decoration: InputDecoration(labelText: 'Precio actual'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: aboutController,
                    decoration: InputDecoration(labelText: 'Descripción'),
                    maxLines: 3,
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: categoryController,
                    decoration: InputDecoration(labelText: 'Categoria'),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: getImage,
                    child: Text('Seleccionar imagen'),
                  ),
                  SizedBox(height: 20.0),
                  sampleImage == null
                      ? Text('Niguna imagen seleccionada')
                      : Image.file(sampleImage!),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: uploadProduct,
                    child: Text('Subir producto'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        sampleImage = File(pickedImage.path);
      });
    }
  }

  Future<void> uploadProduct() async {
    if (formKey.currentState!.validate() && sampleImage != null) {
      try {
        final productName = nameController.text.trim();
        final productPrice = int.parse(priceController.text);
        final productOff = int.tryParse(offController.text) ?? 0;
        final productAbout = aboutController.text.trim();
        final productCategory = categoryController.text.trim();

        // Subir imagen a Firebase Storage
        final Reference storageRef = FirebaseStorage.instance
            .ref()
            .child('product_images')
            .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
        final UploadTask uploadTask = storageRef.putFile(sampleImage!);
        final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
        final imageUrl = await snapshot.ref.getDownloadURL();

        final newProduct = Product(
          name: productName,
          price: productPrice,
          off: productOff,
          about: productAbout,
          isAvailable: true,
          imageUrl: imageUrl,
          isFavorite: false,
          rating: 0,
          category: productCategory,
        );

        // Guardar producto en Firestore
        await FirebaseFirestore.instance.collection('products').add({
          'name': newProduct.name,
          'price': newProduct.price,
          'off': newProduct.off,
          'about': newProduct.about,
          'isAvailable': newProduct.isAvailable,
          'imageUrl': newProduct.imageUrl,
          'isFavorite': newProduct.isFavorite,
          'rating': newProduct.rating,
          'category': newProduct.category,
        });

        //Actualizar lista de productos
        Get.find<ProductController>().loadProducts();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Producto subido exitosamente'),
        ));
        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al cargar el producto: $error'),
        ));
      }
    }
  }
}
