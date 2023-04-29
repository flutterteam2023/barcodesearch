// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProductModel {
  String? name;
  String? barcode;
  String? photoURL;
  List<String>? nameArray;
  List<String>? barcodeArray;
  List<String>? otherBarcodes;
  Timestamp? createdAt;
  ProductModel({
    this.name,
    this.barcode,
    this.photoURL,
    this.nameArray,
    this.barcodeArray,
    this.otherBarcodes,
    this.createdAt,
  });

  ProductModel copyWith({
    String? name,
    String? barcode,
    String? photoURL,
    List<String>? nameArray,
    List<String>? barcodeArray,
    List<String>? otherBarcodes,
    Timestamp? createdAt,
  }) {
    return ProductModel(
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      photoURL: photoURL ?? this.photoURL,
      nameArray: nameArray ?? this.nameArray,
      barcodeArray: barcodeArray ?? this.barcodeArray,
      otherBarcodes: otherBarcodes ?? this.otherBarcodes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'barcode': barcode,
      'photoURL': photoURL,
      'nameArray': nameArray,
      'barcodeArray': barcodeArray,
      'otherBarcodes': otherBarcodes,
      'createdAt': createdAt,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] != null ? map['name'] as String : null,
      barcode: map['barcode'] != null ? map['barcode'] as String : null,
      photoURL: map['photoURL'] != null ? map['photoURL'] as String : null,
      nameArray: map['nameArray'] != null
          ? List<String>.from(map['nameArray'] as List<dynamic>)
          : null,
      barcodeArray: map['barcodeArray'] != null
          ? List<String>.from(map['barcodeArray'] as List<dynamic>)
          : null,
      otherBarcodes: map['otherBarcodes'] != null
          ? List<String>.from(map['otherBarcodes'] as List<dynamic>)
          : null,
      createdAt:
          map['createdAt'] != null ? map['createdAt'] as Timestamp : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(name: $name, barcode: $barcode, photoURL: $photoURL, nameArray: $nameArray, barcodeArray: $barcodeArray, otherBarcodes: $otherBarcodes)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.barcode == barcode &&
        other.photoURL == photoURL &&
        listEquals(other.nameArray, nameArray) &&
        listEquals(other.otherBarcodes, otherBarcodes) &&
        listEquals(other.barcodeArray, barcodeArray);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        barcode.hashCode ^
        photoURL.hashCode ^
        nameArray.hashCode ^
        otherBarcodes.hashCode ^
        barcodeArray.hashCode;
  }
}
