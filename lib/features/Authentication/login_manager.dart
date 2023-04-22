// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:barcodesearch/constants/string_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Values/my_user.dart';

class LoginManager extends ValueNotifier<String> {
  factory LoginManager() => _shared;
  LoginManager._sharedInstance() : super("");
  static final LoginManager _shared = LoginManager._sharedInstance();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ValueNotifier<String> email = ValueNotifier<String>("");

  final ValueNotifier<String> password = ValueNotifier<String>("");
  ValueNotifier<String> warningMessage =
      ValueNotifier(StringConstants.goToLink);
  final ValueNotifier<String> forgetPassword = ValueNotifier<String>("");
  final ValueNotifier<bool> validateForgetPassword = ValueNotifier<bool>(false);

  void getMessage({String message = "We will a link to your email address"}) {
    warningMessage = ValueNotifier(message);
    notifyListeners();
  }

  void textFieldValidate(
      ValueNotifier<String> email, ValueNotifier<bool> validate) {
    email.value.isEmpty ? validate.value = true : validate.value = false;
  }

  //E-posta ve şifre ile giriş fonksiyonu

  Future<void> signOut() async {
    await _auth.signOut().then((value) {
      MyUser().setNull();
    });
  }

  Future signIn(String email, String password, BuildContext context) async {
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) async {
        await MyUser().getUserData;
      });
      Flushbar(
        title: StringConstants.successfull,
        message: StringConstants.signIn,
        duration: const Duration(seconds: 2),
      ).show(context);
    } catch (e) {
      Flushbar(
        title: StringConstants.unsuccessful,
        message: e.toString(),
        duration: const Duration(seconds: 2),
      ).show(context);
    }
  }

  //Şifre Resetleme Fonksiyonu

  Future resetPassword(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      getMessage(message: StringConstants.goToLink);
    } on FirebaseAuthException catch (e) {
      if (e.code == StringConstants.unKnown) {
        getMessage(message: StringConstants.emailPasswordEmptyMessage);
      } else if (e.code == StringConstants.invalidEmail) {
        getMessage(message: StringConstants.emailFormatError);
      } else if (e.code == StringConstants.userNotFound) {
        getMessage(message: StringConstants.emailPasswordEmptyMessage);
      } else if (e.code == StringConstants.networkRequestFailed) {
        Flushbar(
          title: StringConstants.internetWarningMessage,
          duration: const Duration(seconds: 2),
        );
      } else {
        getMessage(message: StringConstants.emailFormatError);
      }
    }
  }
}
