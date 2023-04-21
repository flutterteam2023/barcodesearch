import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginManager extends ValueNotifier<String> {
  factory LoginManager() => _shared;
  LoginManager._sharedInstance() : super("");
  static final LoginManager _shared = LoginManager._sharedInstance();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ValueNotifier<String> email = ValueNotifier<String>("");

  final ValueNotifier<String> password = ValueNotifier<String>("");
  ValueNotifier<String> warningMessage=ValueNotifier("We will a link to your email address");
   final ValueNotifier<String> forgetPassword = ValueNotifier<String>("");
  final ValueNotifier<bool> validateForgetPassword = ValueNotifier<bool>(false);

  
  
  void getMessage({String message = "We will a link to your email address"}){
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Başarılı'),
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Başarısız'),
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
  
  
  
  //Şifre Resetleme Fonksiyonu

  Future resetPassword(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      getMessage(message: 'E posta adresinize bir link gönderdik lütfen kontrol ediniz!');
    } on FirebaseAuthException catch (e) {
      if (e.code == "unknown") {
        
        getMessage(message: "E mail ve şifre alanları boş bırakılamaz");
        
      } else if (e.code == "invalid-email") {
        getMessage(message: 'Yanlış e posta formatı!');
      } else if (e.code == "user-not-found") {
       getMessage(message: 'E posta veya şifre alanları boş geçirilemez!');
      } else if (e.code == "network-request-failed") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('İnternet bağlantınızı kontrol ediniz bir sorun oluştu!'),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                top: 80), // Yukarıdan çıkması için margin'ı ayarlayın
          ),
        );
      } else {
        getMessage(message: 'Yanlış e posta formatı!');
      }
    }
  }
}
