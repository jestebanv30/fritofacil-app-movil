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


// Future<void> uploadProduct() async {
    //   if (formKey.currentState!.validate() && sampleImage != null) {
    //     final productName = nameController.text.trim();
    //     final productPrice = int.parse(priceController.text);
    //     final productOff = int.tryParse(offController.text) ?? 0;
    //     final productAbout = aboutController.text.trim();
    //     final productCategory = categoryController.text.trim();

    //     final productImages = [sampleImage!.path];
    //     final newProduct = Product(
    //       name: productName,
    //       price: productPrice,
    //       off: productOff,
    //       about: productAbout,
    //       isAvailable: true,
    //       images: productImages,
    //       isFavorite: false,
    //       rating: 0,
    //       category: productCategory,
    //     );

    //     // Guardar producto en Firestore
    //     try {
    //       await FirebaseFirestore.instance.collection('products').add({
    //         'name': newProduct.name,
    //         'price': newProduct.price,
    //         'off': newProduct.off,
    //         'about': newProduct.about,
    //         'isAvailable': newProduct.isAvailable,
    //         'images': newProduct.images,
    //         'isFavorite': newProduct.isFavorite,
    //         'rating': newProduct.rating,
    //         'category': newProduct.category,
    //       });
    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         content: Text('Producto subido exitosamente'),
    //       ));
    //     } catch (error) {
    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         content: Text('Error al cargar el producto: $error'),
    //       ));
    //     }
    //   }
    // }

// FUNCIONAL DEL PROYECTO DE HECTOOORRR
// // ignore_for_file: library_private_types_in_public_api, camel_case_types, use_build_context_synchronously, avoid_print, prefer_const_constructors, library_prefixes

// import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fritofacil/src/feed/screen/static.dart' as Static;

// class addProduct extends StatefulWidget {
//   const addProduct({super.key});

//   @override
//   _addProductState createState() => _addProductState();
// }

// class _addProductState extends State<addProduct> {
//   int? amount;
//   String note = "Algunos gastos";
//   String type = "Ingreso";
//   String? category;
//   DateTime selectedDate = DateTime.now();
//   String? newCategory;

//   List<String> months = [
//     "Enero",
//     "Febrero",
//     "Marzo",
//     "Abril",
//     "Mayo",
//     "Junio",
//     "Julio",
//     "Agosto",
//     "Septiembre",
//     "Octubre",
//     "Noviembre",
//     "Diciembre"
//   ];

//   // Función para cargar las categorías existentes desde Firestore
//   Future<List<String>> _loadCategories() async {
//     final snapshot =
//         await FirebaseFirestore.instance.collection('categories').get();
//     return snapshot.docs.map((doc) => doc['name'] as String).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text('Añadir Transacción'),
//       ),
//       backgroundColor: Color(0xffe2e7ef),
//       body: ListView(
//         padding: EdgeInsets.all(12.0),
//         children: [
//           SizedBox(height: 20.0),
//           Text(
//             "Añadir Transacción",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 32.0,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           SizedBox(height: 20.0),
//           Row(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Static.PrimaryColor,
//                   borderRadius: BorderRadius.circular(16.0),
//                 ),
//                 padding: EdgeInsets.all(12.0),
//                 child: Icon(
//                   Icons.attach_money,
//                   size: 24.0,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(width: 12.0),
//               Expanded(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: "0",
//                     border: InputBorder.none,
//                   ),
//                   style: TextStyle(fontSize: 24.0),
//                   onChanged: (val) {
//                     try {
//                       amount = int.parse(val);
//                     } catch (e) {
//                       // Si la conversión falla, asignamos null a amount
//                       amount = null;
//                     }
//                   },
//                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                   keyboardType: TextInputType.number,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20.0),
//           Row(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Static.PrimaryColor,
//                   borderRadius: BorderRadius.circular(16.0),
//                 ),
//                 padding: EdgeInsets.all(12.0),
//                 child: Icon(
//                   Icons.description,
//                   size: 24.0,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(width: 12.0),
//               Expanded(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: "Nota sobre la transacción",
//                     border: InputBorder.none,
//                   ),
//                   style: TextStyle(fontSize: 24.0),
//                   onChanged: (val) {
//                     note = val;
//                   },
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20.0),
//           Row(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Static.PrimaryColor,
//                   borderRadius: BorderRadius.circular(16.0),
//                 ),
//                 padding: EdgeInsets.all(12.0),
//                 child: Icon(
//                   Icons.category,
//                   size: 24.0,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(width: 12.0),
//               Expanded(
//                 child: FutureBuilder<List<String>>(
//                   future: _loadCategories(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return CircularProgressIndicator();
//                     }
//                     if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     }
//                     final categoryNames = snapshot.data ?? [];

//                     return DropdownButton<String>(
//                       value: category,
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           category = newValue!;
//                         });
//                       },
//                       items: categoryNames
//                           .map<DropdownMenuItem<String>>((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(width: 12.0),
//               Expanded(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: "Nueva categoría (opcional)",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(16.0),
//                     ),
//                   ),
//                   onChanged: (val) {
//                     setState(() {
//                       // Actualizamos newCategory con el valor del TextField
//                       newCategory = val.isEmpty ? null : val;
//                     });
//                   },
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20.0),
//           Row(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Static.PrimaryColor,
//                   borderRadius: BorderRadius.circular(16.0),
//                 ),
//                 padding: EdgeInsets.all(12.0),
//                 child: Icon(
//                   Icons.moving_sharp,
//                   size: 24.0,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(width: 12.0),
//               ChoiceChip(
//                 label: Text(
//                   "Ingreso",
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     color: type == "Ingreso" ? Colors.white : Colors.black,
//                   ),
//                 ),
//                 selectedColor: Static.PrimaryColor,
//                 selected: type == "Ingreso",
//                 onSelected: (val) {
//                   if (val) {
//                     setState(() {
//                       type = "Ingreso";
//                     });
//                   }
//                 },
//               ),
//               SizedBox(width: 12.0),
//               ChoiceChip(
//                 label: Text(
//                   "Gasto",
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     color: type == "Gasto" ? Colors.white : Colors.black,
//                   ),
//                 ),
//                 selectedColor: Static.PrimaryColor,
//                 selected: type == "Gasto",
//                 onSelected: (val) {
//                   if (val) {
//                     setState(() {
//                       type = "Gasto";
//                     });
//                   }
//                 },
//               ),
//             ],
//           ),
//           SizedBox(height: 20.0),
//           SizedBox(
//             height: 50.0,
//             child: TextButton(
//               onPressed: () {
//                 _selectDate(context);
//               },
//               style: ButtonStyle(
//                 padding: MaterialStateProperty.all(EdgeInsets.zero),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Static.PrimaryColor,
//                       borderRadius: BorderRadius.circular(16.0),
//                     ),
//                     padding: EdgeInsets.all(12.0),
//                     child: Icon(
//                       Icons.date_range,
//                       size: 24.0,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(width: 12.0),
//                   Text(
//                     "${selectedDate.day} ${months[selectedDate.month - 1]}",
//                     style: TextStyle(fontSize: 20.0),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 20.0),
//           SizedBox(
//             height: 50.0,
//             child: ElevatedButton(
//               onPressed: () {
//                 _saveTransactionData();
//               },
//               child: Text(
//                 "Agregar",
//                 style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Función para guardar los datos de la transacción en Firestore
//   Future<void> _saveTransactionData() async {
//     try {
//       if (amount != null) {
//         // Guardar la nueva categoría en Firestore si se proporciona
//         if (newCategory != null) {
//           await FirebaseFirestore.instance.collection('categories').add({
//             'name': newCategory,
//           });
//           // Asignar newCategory a category para la transacción
//           category = newCategory;
//         }

//         // Guardar la transacción en Firestore
//         await FirebaseFirestore.instance.collection('transactions').add({
//           'amount': amount,
//           'note': note,
//           'type': type,
//           'category': category, // Usar el nombre de la categoría aquí
//           'date': selectedDate,
//         });

//         print('Datos de transacción guardados correctamente en Firestore');
//         Navigator.of(context).pop();
//       } else {
//         print('Por favor complete todos los campos');
//       }
//     } catch (e) {
//       // ignore: avoid_print
//       print('Error al guardar datos de transacción en Firestore: $e');
//     }
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2020, 12),
//       lastDate: DateTime(2100, 01),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }
// }

//  VIDEOOOOOO  DE YOUTUBE
//// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, avoid_unnecessary_containers, library_private_types_in_public_api, use_key_in_widget_constructors, file_names

// import 'dart:ffi';
// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ProductUpload extends StatefulWidget {
//   //const ProductUpload({super.key});
//   @override
//   //State<ProductUpload> createState() => _ProductUploadState();
//   _ProductUploadState createState() => _ProductUploadState();
// }

// class _ProductUploadState extends State<ProductUpload> {
//   late File sampleImage; //imagen
//   String _myValue; //descripcion
//   String url; //url de la imagen
//   final formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Cargar imagen"),
//         centerTitle: true,
//       ),
//       body: Center(
//         child:
//             sampleImage == null ? Text("Seleciona una imagen") : enableUpload(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: getImage,
//         tooltip: "Añadir imagen",
//         child: Icon(Icons.add_a_photo),
//       ),
//     );
//   }

//   Future getImage() async {
//     var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       sampleImage = tempImage as File;
//     });
//   }

//   Widget enableUpload() {
//     return SingleChildScrollView(
//       child: Container(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: formKey,
//             child: Column(
//               children: <Widget>[
//                 Image.file(
//                   sampleImage,
//                   height: 300.0,
//                   width: 600.0,
//                 ),
//                 SizedBox(
//                   height: 15.0,
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: "Descipción"),
//                   validator: (value) {
//                     return value.isEmpty ? "La descripción es requerida" : null;
//                   },
//                   onSaved: (value) {
//                     return _myValue = value;
//                   },
//                 ),
//                 SizedBox(
//                   height: 15.0,
//                 ),
//                 RaisedButton(
//                   elevation: 10.0,
//                   child: Text("Agrega un nuevo post"),
//                   textColor: Colors.white,
//                   color: Colors.black,
//                   onPressed: uploadStatusImage(),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void uploadStatusImage() async {
//     if (validateAndSave()) {
//       // Subir imagen a firebase storage
//       final StorageReference postImageRef =
//           FirebaseStorage.instance.ref().child("Post image");
//       var timeKey = DateTime.now();
//       final StorageUploadTask uploadTask =
//           postImageRef.child(timeKey.toString() + ".jpg").putFile(sampleImage);
//       var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
//       url = imageUrl.toString();
//       print("Image url: " + url);

//       // Guardar el post a Firebase database
//       saveToDatabase(url);
//     }
//   }

//   void saveToDatabase(String url) {
//     /Future<void> uploadProduct() async {
  //   if (formKey.currentState!.validate() && sampleImage != null) {
  //     final productName = nameController.text.trim();
  //     final productPrice = int.parse(priceController.text);
  //     final productOff = int.tryParse(offController.text) ?? 0;
  //     final productAbout = aboutController.text.trim();
  //     final productCategory = categoryController.text.trim();

  //     final productImages = [sampleImage!.path];
  //     final newProduct = Product(
  //       name: productName,
  //       price: productPrice,
  //       off: productOff,
  //       about: productAbout,
  //       isAvailable: true,
  //       images: productImages,
  //       isFavorite: false,
  //       rating: 0,
  //       category: productCategory,
  //     );

  //     // Guardar producto en Firestore
  //     try {
  //       await FirebaseFirestore.instance.collection('products').add({
  //         'name': newProduct.name,
  //         'price': newProduct.price,
  //         'off': newProduct.off,
  //         'about': newProduct.about,
  //         'isAvailable': newProduct.isAvailable,
  //         'images': newProduct.images,
  //         'isFavorite': newProduct.isFavorite,
  //         'rating': newProduct.rating,
  //         'category': newProduct.category,
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text('Producto subido exitosamente'),
  //       ));
  //     } catch (error) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text('Error al cargar el producto: $error'),
  //       ));
  //     }
  //   }
  // }
//   }

//   bool validateAndSave() {
//     final form = formKey.currentState;
//     if (form.validate()) {
//       form.save();
//       return true;
//     } else {
//       return false;
//     }
//   }
// }