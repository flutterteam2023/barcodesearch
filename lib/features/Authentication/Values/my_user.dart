import 'package:barcodesearch/constants/collections_constants.dart';
import 'package:barcodesearch/features/Authentication/Models/user_model.dart';
import 'package:barcodesearch/constants/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyUser extends ValueNotifier<UserModel?> {
  factory MyUser() => _shared;
  MyUser._sharedInstance() : super(null);
  static final MyUser _shared = MyUser._sharedInstance();
  

  Future<void> get getUserData async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FireCollection.collection(FirebaseConstants.usersCollection)
          .doc(user.uid)
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) => UserModel.fromMap(snapshot.data()!),
            toFirestore: (model, _) => model.toMap(),
          )
          .get()
          .then((x) {
        value = x.data();
        value!.uid = user.uid;
      });
    }
  }

  bool isNull() {
    final myUser = value;
    return myUser == null;
  }

  String? getName() {
    final myUser = value;
    return myUser?.name;
  }
  String? getCredit(){
    final myUser = value;
    return myUser?.credit.toString();

  }

  void setNull() {
    value = null;
  }
}
