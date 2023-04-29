import 'package:barcodesearch/features/Searching/Models/product_model.dart';
import 'package:barcodesearch/features/Searching/string.dart';
import 'package:barcodesearch/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final productsList = productsString.split('\n').toList();
  print(productsString.length);
  for (final element in productsList) {
    final list = element.split(' : ');
    final barcode = list[0];
    final name = list[1];

    List<String> barcodeArray = [];
    List<String> nameArray = [];

    //Z, ZE, ZEY, ZEYC, ZEYCE,

    for (var i = 0; i < (name.length); i++) {
      final arrayitem = name.substring(0, i + 1);
      if (!nameArray.contains(arrayitem) && arrayitem != '') {
        nameArray.add(arrayitem);
      }
    }

    ///kelimeleri de parçalamak için
    for (final word in name.split(' ')) {
      for (var i = 0; i < (word.length); i++) {
        final arrayitem = word.substring(0, i + 1);
        if (!nameArray.contains(arrayitem) && arrayitem != '') {
          nameArray.add(arrayitem);
        }
      }
    }

    for (var i = 0; i < (barcode.length); i++) {
      final arrayitem = barcode.substring(0, i + 1);
      if (!barcodeArray.contains(arrayitem) && arrayitem != '') {
        barcodeArray.add(arrayitem);
      }
    }
    //reverse array create
    //Z, ZE, ZEY, ZEYC, ZEYCE, EYCE, YCE, CE, E
    for (var i = 0; i < (name.length); i++) {
      final arrayitem = name.substring(i, name.length);
      if (!nameArray.contains(arrayitem) && arrayitem != '') {
        nameArray.add(arrayitem);
      }
    }

    ///kelimeleri de parçalamak için
    for (final word in name.split(' ')) {
      for (var i = 0; i < (word.length); i++) {
        final arrayitem = word.substring(i, word.length);
        if (!nameArray.contains(arrayitem) && arrayitem != '') {
          nameArray.add(arrayitem);
        }
      }
    }

    for (var i = 0; i < (barcode.length); i++) {
      final arrayitem = barcode.substring(i, barcode.length);
      if (!barcodeArray.contains(arrayitem) && arrayitem != '') {
        barcodeArray.add(arrayitem);
      }
    }
    //türkçe karakter ayrıştırması
    for (var element in nameArray) {
      if (element.contains('U') ||
          element.contains('O') ||
          element.contains('I') ||
          element.contains('C') ||
          element.contains('S')) {
        final newElement = element
            .replaceAll('U', 'Ü')
            .replaceAll('O', 'Ö')
            .replaceAll('S', 'Ş')
            .replaceAll('I', 'İ')
            .replaceAll('C', 'Ç');

        if (!nameArray.contains(newElement) && newElement != '') {
          nameArray.add(newElement);
        }
      }
    }

    //küçük harfe çevirme
    for (final element in nameArray) {
      if (!nameArray.contains(element.toLowerCase()) &&
          element.toLowerCase() != '') {
        nameArray.add(element.toLowerCase());
      }
    }

    //küçük türkçe karakter ayrıştırması
    for (final element in nameArray) {
      if (element.contains('u') ||
          element.contains('o') ||
          element.contains('i') ||
          element.contains('c') ||
          element.contains('s')) {
        final newElement = element
            .replaceAll('u', 'ü')
            .replaceAll('o', 'ö')
            .replaceAll('s', 'ş')
            .replaceAll('ı', 'i')
            .replaceAll('c', 'ç');

        if (!nameArray.contains(newElement) && newElement != '') {
          nameArray.add(newElement);
        }
      }
    }

    print(nameArray);
    print(barcodeArray);

    final product = ProductModel(
      name: name,
      barcode: barcode,
      photoURL: null,
      nameArray: nameArray,
      barcodeArray: barcodeArray,
    );

    print(product);
    /* await FirebaseFirestore.instance.collection('products').doc().set(
          product.toMap(),
        ); */
  }
  /*  
           await FirebaseFirestore.instance.collection("products").doc().set(
                  product.toMap(),
                );
          final product = ProductModel(
            name: "adasdas123",
            barcode: "123123",
            photoURL: null,
          );
          ProductList().add(product);
          await FirebaseFirestore.instance.collection("products").doc().set(
                product.toMap(),
              ); */
}
