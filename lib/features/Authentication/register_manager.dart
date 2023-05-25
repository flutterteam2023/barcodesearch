import 'package:another_flushbar/flushbar.dart';
import 'package:barcodesearch/constants/authentication_constant.dart';
import 'package:barcodesearch/constants/collections_constants.dart';
import 'package:barcodesearch/constants/firebase_constants.dart';
import 'package:barcodesearch/features/Authentication/Models/user_model.dart';
import 'package:barcodesearch/features/Authentication/Values/my_user.dart';
import 'package:barcodesearch/features/Authentication/login_manager.dart';
import 'package:barcodesearch/routing/route_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterManager extends ValueNotifier<String> {
  factory RegisterManager() => _shared;
  RegisterManager._sharedInstance() : super('');
  static final RegisterManager _shared = RegisterManager._sharedInstance();
  ValueNotifier<String> name = ValueNotifier<String>('');
  ValueNotifier<String> surname = ValueNotifier<String>('');
  ValueNotifier<String> email = ValueNotifier<String>('');
  ValueNotifier<String> password = ValueNotifier<String>('');
  ValueNotifier<String> rePassword = ValueNotifier<String>('');
  ValueNotifier<int> credit = ValueNotifier<int>(12);
  ValueNotifier<DateTime> createdAt = ValueNotifier<DateTime>(DateTime.now());
  ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);
  ValueNotifier<bool> createUserControl = ValueNotifier<bool>(false);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  void checked() {
    isChecked.value = !isChecked.value;
    notifyListeners();
  }

//Yeni Kullanıcı Oluşturma
  Future<User?> createUser(
    String email,
    String password,
    String rePassword,
    String name,
    String surname,
    int credit,
    DateTime createdAt,
    BuildContext context,
  ) async {
    final userModels = UserModel(
      email: email,
      createdAt: createdAt,
      name: name,
      surname: surname,
      credit: credit,
    );
    createUserControl.value = true;

    if (userModels.email.isNotEmpty &&
        password.isNotEmpty &&
        rePassword.isNotEmpty &&
        userModels.name.isNotEmpty &&
        userModels.surname.isNotEmpty &&
        isChecked.value == true) {
      if (password == rePassword) {
        try {
          final user = await _auth.createUserWithEmailAndPassword(
            email: userModels.email,
            password: password,
          );

          await FireCollection.collection(FirebaseConstants.usersCollection).doc(user.user?.uid).set({
            'name': userModels.name,
            'surname': userModels.surname,
            'email': userModels.email,
            'credit': userModels.credit,
            'createdAt': userModels.createdAt
          }).then((value) async {
            await MyUser().getUserData;
          });

          await Flushbar(
            title: StringConstants.successfull,
            message: StringConstants.registerSuccessful,
            duration: const Duration(seconds: 2),
          ).show(context);

          context.pushReplacementNamed(APP_PAGE.home.toName);

          createUserControl.value = false;

          email = '';
          password = '';
          rePassword = '';
          LoginManager().email.value = '';
          LoginManager().password.value = '';
          LoginManager().forgetPassword.value = '';

          return user.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == StringConstants.invalidEmail) {
            await Flushbar(
              title: StringConstants.unsuccessful,
              message: StringConstants.emailIsInvalid,
              duration: const Duration(seconds: 2),
            ).show(context);
          } else if (e.code == StringConstants.weakPassword) {
            await Flushbar(
              title: StringConstants.unsuccessful,
              message: StringConstants.passwordIsWeak,
              duration: const Duration(seconds: 2),
            ).show(context);
          } else if (e.code == StringConstants.emailAlreadyInUse) {
            await Flushbar(
              title: StringConstants.unsuccessful,
              message: StringConstants.usingEmail,
              duration: const Duration(seconds: 2),
            ).show(context);
          } else {
            await Flushbar(
              title: StringConstants.unsuccessful,
              message: StringConstants.emptyError,
              duration: const Duration(seconds: 2),
            ).show(context);
          }
        }
      } else {
        await Flushbar(
          title: StringConstants.unsuccessful,
          message: StringConstants.repetitivePasswordError,
          duration: const Duration(seconds: 2),
        ).show(context);
      }
    } else if (userModels.email.isNotEmpty &&
        password.isNotEmpty &&
        rePassword.isNotEmpty &&
        userModels.name.isNotEmpty &&
        userModels.surname.isNotEmpty &&
        isChecked.value == false) {
      await Flushbar(
        title: StringConstants.unsuccessful,
        message: StringConstants.protocolError,
        duration: const Duration(seconds: 2),
      ).show(context);
    } else {
      await Flushbar(
        title: StringConstants.unsuccessful,
        message: StringConstants.spaceGapError,
        duration: const Duration(seconds: 2),
      ).show(context);
      createUserControl.value = false;
    }
    return null;
  }
}
