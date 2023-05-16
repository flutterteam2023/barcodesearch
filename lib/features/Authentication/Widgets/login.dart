import 'dart:async';

import 'package:barcodesearch/common_widgets/app_buttons.dart';
import 'package:barcodesearch/common_widgets/input_field.dart';
import 'package:barcodesearch/common_widgets/dialog.dart';
import 'package:barcodesearch/features/Authentication/Widgets/register.dart';
import 'package:barcodesearch/features/Authentication/Widgets/reset.dart';
import 'package:barcodesearch/utils/theme.dart';
import 'package:barcodesearch/features/Authentication/login_manager.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  Widget loginButton() {
    return AppButtons.roundedButton(
      borderRadius: BorderRadius.circular(14),
      backgroundColor: Colors.indigo,
      text: 'Giriş Yap',
      function: () async {
        await LoginManager().signIn(
          LoginManager().email.value,
          LoginManager().password.value,
          context,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hesabınıza\ngiriş yapın',
                style: heading2.copyWith(color: textBlack),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 48,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                InputField(
                  hintText: 'E-postanız',
                  suffixIcon: const SizedBox(),
                  onChanged: (value) {
                    LoginManager().email.value = value;
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
                InputField(
                  hintText: 'Şifreniz',
                  onChanged: (value) {
                    LoginManager().password.value = value;
                  },
                  obscureText: !passwordVisible,
                  suffixIcon: IconButton(
                    color: textGrey,
                    splashRadius: 1,
                    icon: Icon(
                      passwordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    ),
                    onPressed: togglePassword,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          GestureDetector(
            onTap: () {
              showCustomModelBottomSheet(context, ResetPasswordScreen());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Şifremi Unuttum',
                  textAlign: TextAlign.right,
                  style: regular16pt.copyWith(color: primaryBlue),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          loginButton(),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hesabınız yok mu? ',
                style: regular16pt.copyWith(color: textGrey),
              ),
              GestureDetector(
                onTap: () {
                  showCustomModelBottomSheet(context, RegisterScreen());
                },
                child: Text(
                  'Kayıt Olun',
                  style: regular16pt.copyWith(color: primaryBlue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
