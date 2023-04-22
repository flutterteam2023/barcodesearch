import 'package:barcodesearch/Screens/login/login_screen.dart';
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

  ValueNotifier<bool> createUserControl = ValueNotifier<bool>(false);

  final FirebaseAuth _auth = FirebaseAuth.instance;

//Yeni Kullanıcı Oluşturma
  Future<User?> createUser(String _email, String _password, String _rePassword,
      BuildContext context) async {
    createUserControl.value = true;

    if (_email.isNotEmpty && _password.isNotEmpty && _rePassword.isNotEmpty) {
      if (_password == _rePassword) {
        try {
          var user = await _auth.createUserWithEmailAndPassword(
              email: _email, password: _password);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Kayıt Başarılı'),
              duration: Duration(seconds: 2),
              action: SnackBarAction(
                label: 'Eylem', // Eylem düğmesi etiketi
                onPressed: () {
                  // Eylem düğmesine tıklandığında yapılacak işlemler
                  // ...
                },
              ),
            ),
          );

          createUserControl.value = false;
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          email.value = "";
          password.value = "";
          rePassword.value = "";
          LoginManager().email.value = "";
          LoginManager().password.value = "";
          LoginManager().forgetPassword.value = "";

          return user.user;
        } on FirebaseAuthException catch (e) {
          if (e.code.toString() == "invalid-email") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Geçersiz E posta'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Eylem', // Eylem düğmesi etiketi
                  onPressed: () {
                    // Eylem düğmesine tıklandığında yapılacak işlemler
                    // ...
                  },
                ),
              ),
            );
          } else if (e.code.toString() == "weak-password") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Güçsüz Parola'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Eylem', // Eylem düğmesi etiketi
                  onPressed: () {
                    // Eylem düğmesine tıklandığında yapılacak işlemler
                    // ...
                  },
                ),
              ),
            );
          } else if (e.code.toString() == "email-already-in-use") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('E mail kullanılıyor'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Eylem', // Eylem düğmesi etiketi
                  onPressed: () {
                    // Eylem düğmesine tıklandığında yapılacak işlemler
                    // ...
                  },
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Boş Hata'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Eylem', // Eylem düğmesi etiketi
                  onPressed: () {
                    // Eylem düğmesine tıklandığında yapılacak işlemler
                    // ...
                  },
                ),
              ),
            );
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Şifre Tekrar Boş Bırakılamaz Ya Da Şifre Tekrarı İle Uyuşmamaktadır'),
            duration: Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Eylem', // Eylem düğmesi etiketi
              onPressed: () {
                // Eylem düğmesine tıklandığında yapılacak işlemler
                // ...
              },
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hiçbir alan boş bırakılamaz'),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Eylem', // Eylem düğmesi etiketi
            onPressed: () {
              // Eylem düğmesine tıklandığında yapılacak işlemler
              // ...
            },
          ),
        ),
      );
      createUserControl.value = false;
    }
  }
}
