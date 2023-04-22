// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginManager extends ValueNotifier<String> {
  factory LoginManager() => _shared;
  LoginManager._sharedInstance() : super("");
  static final LoginManager _shared = LoginManager._sharedInstance();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ValueNotifier<String> email = ValueNotifier<String>("");

  final ValueNotifier<String> password = ValueNotifier<String>("");
  ValueNotifier<String> warningMessage =
      ValueNotifier("We will a link to your email address");
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

  Future signIn(String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      Flushbar(
        title: 'Başarılı',
        message: 'Giriş Yaptınız',
        duration: const Duration(seconds: 2),
      ).show(context);
    } catch (e) {
      Flushbar(
        title: 'Başarısız',
        message: e.toString(),
        duration: const Duration(seconds: 2),
      ).show(context);
    }
  }

  //Şifre Resetleme Fonksiyonu

  Future resetPassword(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      getMessage(
          message:
              'E posta adresinize bir link gönderdik lütfen kontrol ediniz!');
    } on FirebaseAuthException catch (e) {
      if (e.code == "unknown") {
        getMessage(message: "E mail ve şifre alanları boş bırakılamaz");
      } else if (e.code == "invalid-email") {
        getMessage(message: 'Yanlış e posta formatı!');
      } else if (e.code == "user-not-found") {
        getMessage(message: 'E posta veya şifre alanları boş geçirilemez!');
      } else if (e.code == "network-request-failed") {
        Flushbar(
          title: 'İnternet bağlantınızı kontrol ediniz bir sorun oluştu!',
          duration: const Duration(seconds: 2),
        );
      } else {
        getMessage(message: 'Yanlış e posta formatı!');
      }
    }
  }
}
