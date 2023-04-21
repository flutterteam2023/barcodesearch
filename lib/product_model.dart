// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  String? name;
  String? barcode;
  String? photoURL;
  ProductModel({
    this.name,
    this.barcode,
    this.photoURL,
  });

  ProductModel copyWith({
    String? name,
    String? barcode,
    String? photoURL,
  }) {
    return ProductModel(
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'barcode': barcode,
      'photoURL': photoURL,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] != null ? map['name'] as String : null,
      barcode: map['barcode'] != null ? map['barcode'] as String : null,
      photoURL: map['photoURL'] != null ? map['photoURL'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProductModel(name: $name, barcode: $barcode, photoURL: $photoURL)';

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.barcode == barcode &&
        other.photoURL == photoURL;
  }

  @override
  int get hashCode => name.hashCode ^ barcode.hashCode ^ photoURL.hashCode;
}
