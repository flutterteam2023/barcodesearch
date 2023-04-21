// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductModel {
  String? name;
  String? barcode;
  String? photoURL;
  List<String>? nameArray;
  List<String>? barcodeArray;
  ProductModel({
    this.name,
    this.barcode,
    this.photoURL,
    this.nameArray,
    this.barcodeArray,
  });

  ProductModel copyWith({
    String? name,
    String? barcode,
    String? photoURL,
    List<String>? nameArray,
    List<String>? barcodeArray,
  }) {
    return ProductModel(
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      photoURL: photoURL ?? this.photoURL,
      nameArray: nameArray ?? this.nameArray,
      barcodeArray: barcodeArray ?? this.barcodeArray,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'barcode': barcode,
      'photoURL': photoURL,
      'nameArray': nameArray,
      'barcodeArray': barcodeArray,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] != null ? map['name'] as String : null,
      barcode: map['barcode'] != null ? map['barcode'] as String : null,
      photoURL: map['photoURL'] != null ? map['photoURL'] as String : null,
      nameArray: map['nameArray'] != null
          ? List<String>.from((map['nameArray'] as List<String>))
          : null,
      barcodeArray: map['barcodeArray'] != null
          ? List<String>.from((map['barcodeArray'] as List<String>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(name: $name, barcode: $barcode, photoURL: $photoURL, nameArray: $nameArray, barcodeArray: $barcodeArray)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.barcode == barcode &&
        other.photoURL == photoURL &&
        listEquals(other.nameArray, nameArray) &&
        listEquals(other.barcodeArray, barcodeArray);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        barcode.hashCode ^
        photoURL.hashCode ^
        nameArray.hashCode ^
        barcodeArray.hashCode;
  }
}
