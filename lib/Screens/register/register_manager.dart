import 'dart:ffi';

import 'package:another_flushbar/flushbar.dart';
import 'package:barcodesearch/Authentication/user_model.dart';
import 'package:barcodesearch/Models/product_model.dart';
import 'package:barcodesearch/Screens/home_screen.dart';
import 'package:barcodesearch/Screens/login/login_screen.dart';
import 'package:barcodesearch/Shared/Constants/firebase_constants.dart';
import 'package:barcodesearch/Shared/Constants/string_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login/login_manager.dart';

class RegisterManager extends ValueNotifier<String> {
  factory RegisterManager() => _shared;
  RegisterManager._sharedInstance() : super("");
  static final RegisterManager _shared = RegisterManager._sharedInstance();
  ValueNotifier<String> name = ValueNotifier<String>("");
  ValueNotifier<String> surname = ValueNotifier<String>("");
  ValueNotifier<String> email = ValueNotifier<String>("");
  ValueNotifier<String> password = ValueNotifier<String>("");
  ValueNotifier<String> rePassword = ValueNotifier<String>("");
  ValueNotifier<int> credit = ValueNotifier<int>(12);
  ValueNotifier<DateTime> createdAt = ValueNotifier<DateTime>(DateTime.now());



  ValueNotifier<bool> createUserControl = ValueNotifier<bool>(false);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//Yeni Kullanıcı Oluşturma
  Future<User?> createUser(
    String _email,
    String _password,
    String _rePassword,
    String _name,
    String _surname,
    int _credit,
    DateTime _createdAt,
    BuildContext context,
  ) async {
    UserModel userModels = UserModel(
        email: _email,
        createdAt: _createdAt,
        name: _name,
        surname: _surname,
        credit: _credit);
    createUserControl.value = true;

    if (userModels.email.isNotEmpty &&
        _password.isNotEmpty &&
        _rePassword.isNotEmpty &&
        userModels.name.isNotEmpty &&
        userModels.surname.isNotEmpty) {
      if (_password == _rePassword) {
        try {
          var user = await _auth.createUserWithEmailAndPassword(
              email: userModels.email, password: _password);

          await _firestore.collection(FirebaseConstants.usersCollection).doc(user.user?.uid).set({
            "name": userModels.name,
            "surname": userModels.surname,
            "email": userModels.email,
            "credit": userModels.credit,
            "createdAt": userModels.createdAt
          });

          Flushbar(
          title: StringConstants.successfull,
          message:
              StringConstants.registerSuccessful,
          duration: const Duration(seconds: 2),
        ).show(context);
        Navigator.push(context,
        MaterialPageRoute(builder: (context)=>HomeScreen())
        );
           
          createUserControl.value = false;
         
          email.value = "";
          password.value = "";
          rePassword.value = "";
          LoginManager().email.value = "";
          LoginManager().password.value = "";
          LoginManager().forgetPassword.value = "";

          return user.user;
        } on FirebaseAuthException catch (e) {
          if (e.code.toString() == StringConstants.invalidEmail) {
            Flushbar(
          title: StringConstants.unsuccessful,
          message:
              StringConstants.emailIsInvalid,
          duration: const Duration(seconds: 2),
        ).show(context);
          } else if (e.code.toString() == StringConstants.weakPassword) {
            Flushbar(
              title: StringConstants.unsuccessful,
              message: StringConstants.passwordIsWeak,
              duration: const Duration(seconds: 2),
            ).show(context);
          } else if (e.code.toString() == StringConstants.emailAlreadyInUse) {
            Flushbar(
              title: StringConstants.unsuccessful,
              message: StringConstants.usingEmail,
              duration: const Duration(seconds: 2),
            ).show(context);
          } else {
            Flushbar(
              title: StringConstants.unsuccessful,
              message: StringConstants.emptyError,
              duration: const Duration(seconds: 2),
            ).show(context);
          }
        }
      } else {
        Flushbar(
          title: StringConstants.unsuccessful,
          message:
              StringConstants.repetitivePasswordError,
          duration: const Duration(seconds: 2),
        ).show(context);
      }
    } else {
      Flushbar(
          title: StringConstants.unsuccessful,
          message:
              StringConstants.spaceGapError,
          duration: const Duration(seconds: 2),
        ).show(context);
      createUserControl.value = false;
    }
  }
}
