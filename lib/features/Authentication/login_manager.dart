// ignore_for_file: use_build_context_synchronously, inference_failure_on_instance_creation, unawaited_futures

import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:barcodesearch/constants/authentication_constant.dart';
import 'package:barcodesearch/features/Authentication/Values/my_user.dart';
import 'package:barcodesearch/routing/route_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginManager extends ValueNotifier<String> {
  factory LoginManager() => _shared;
  LoginManager._sharedInstance() : super('');
  static final LoginManager _shared = LoginManager._sharedInstance();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ValueNotifier<String> email = ValueNotifier<String>('');

  final ValueNotifier<String> password = ValueNotifier<String>('');
  ValueNotifier<String> warningMessage =
      ValueNotifier(StringConstants.goToLink);
  final ValueNotifier<String> forgetPassword = ValueNotifier<String>('');
  final ValueNotifier<bool> validateForgetPassword = ValueNotifier<bool>(false);
  final ValueNotifier<bool> textfieldController = ValueNotifier<bool>(true);

  void getMessage({String message = 'We will a link to your email address'}) {
    warningMessage = ValueNotifier(message);
    notifyListeners();
  }

  void textFieldValidate(
    ValueNotifier<String> email,
    ValueNotifier<bool> validate,
  ) {
    email.value.isEmpty ? validate.value = true : validate.value = false;
  }

  //E-posta ve şifre ile giriş fonksiyonu

  Future<void> signOut() async {
    await _auth.signOut().then((value) {
      MyUser().setNull();
    });
  }

  Future<void> signIn(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await _auth
          .signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .then((value) async {
        await MyUser().getUserData;
        Navigator.of(context).pop();
      });
      Flushbar(
        title: StringConstants.successfull,
        message: StringConstants.signIn,
        duration: const Duration(seconds: 3),
      ).show(context);
      context.pushNamed(
        APP_PAGE.home.toName,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == StringConstants.invalidEmail) {
        Flushbar(
          title: StringConstants.unsuccessful,
          message: StringConstants.emailIsInvalid,
          duration: const Duration(seconds: 3),
        ).show(context);
      } else if (e.code == StringConstants.wrongPassword) {
        Flushbar(
          title: StringConstants.unsuccessful,
          message: StringConstants.passwordIsWrong,
          duration: const Duration(seconds: 3),
        ).show(context);
      } else if (e.code == StringConstants.userNotFound) {
        Flushbar(
          title: StringConstants.unsuccessful,
          message: StringConstants.notFoundUserMessage,
          duration: const Duration(seconds: 3),
        ).show(context);
      } else if (email.isEmpty || password.isEmpty) {
        Flushbar(
          title: StringConstants.unsuccessful,
          message: StringConstants.emailPasswordEmptyMessage,
          duration: const Duration(seconds: 3),
        ).show(context);
      }
    }
  }

  //Şifre Resetleme Fonksiyonu

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());

      Flushbar(
        title: StringConstants.successfull,
        message: StringConstants.goToLink,
        duration: const Duration(seconds: 3),
      ).show(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == StringConstants.unKnown) {
        Flushbar(
          title: StringConstants.unsuccessful,
          message: StringConstants.emailEmptyMessage,
          duration: const Duration(seconds: 3),
        ).show(context);
      } else if (e.code == StringConstants.invalidEmail) {
        Flushbar(
          title: StringConstants.unsuccessful,
          message: StringConstants.emailFormatError,
          duration: const Duration(seconds: 3),
        ).show(context);
      } else if (e.code == StringConstants.userNotFound) {
        Flushbar(
          title: StringConstants.unsuccessful,
          message: StringConstants.notFoundUserMessage,
          duration: const Duration(seconds: 3),
        ).show(context);
      } else if (e.code == StringConstants.networkRequestFailed) {
        Flushbar(
          title: StringConstants.internetWarningMessage,
          duration: const Duration(seconds: 2),
        );
      } else if (e.code == StringConstants.missingEmail) {
        Flushbar(
          title: StringConstants.unsuccessful,
          message: StringConstants.emailIsMissing,
          duration: const Duration(seconds: 3),
        ).show(context);
      } else {
        Flushbar(
          title: StringConstants.unsuccessful,
          message: StringConstants.limitError,
          duration: const Duration(seconds: 3),
        ).show(context);
      }
    }
  }
}
