
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String email;
  DateTime createdAt;
  String name;
  String surname;
  int credit;
  String? uid;
  UserModel({
    required this.email,
    required this.createdAt,
    required this.name,
    required this.surname,
    required this.credit,
    this.uid,
  });

  UserModel copyWith({
    String? email,
    DateTime? createdAt,
    String? name,
    String? surname,
    int? credit,
  }) {
    return UserModel(
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      credit: credit ?? this.credit, uid: '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'name': name,
      'surname': surname,
      'credit': credit,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      name: map['name'] as String,
      surname: map['surname'] as String,
      credit: map['credit'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(email: $email, createdAt: $createdAt, name: $name, surname: $surname, credit: $credit)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.createdAt == createdAt &&
        other.name == name &&
        other.surname == surname &&
        other.credit == credit;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        createdAt.hashCode ^
        name.hashCode ^
        surname.hashCode ^
        credit.hashCode;
  }
}
