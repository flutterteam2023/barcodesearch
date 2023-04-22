import 'dart:async';

import 'package:barcodesearch/features/Authentication/Widgets/dialog.dart';
import 'package:barcodesearch/features/Authentication/Widgets/register.dart';
import 'package:barcodesearch/utils/theme.dart';
import 'package:barcodesearch/features/Authentication/login_manager.dart';
import 'package:barcodesearch/Screens/register/register_screen.dart';
import 'package:barcodesearch/Shared/Widgets/app_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Shared/Widgets/input_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  Widget loginButton() {
    return AppButtons.roundedButton(
      borderRadius: BorderRadius.circular(14),
      backgroundColor: primaryBlue,
      text: 'Şifremi Sıfırla',
      function: () async {
        LoginManager().textFieldValidate(LoginManager().forgetPassword,
            LoginManager().validateForgetPassword);
        await LoginManager().resetPassword(
          LoginManager().forgetPassword.value.toString().trim(),
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
                'Şifrenizi\nsıfırlayın',
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
                  onChanged: (p0) {
                    LoginManager().forgetPassword.value = p0;
                  },
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
              GestureDetector(
                onTap: () {
                  showCustomModelBottomSheet(context, RegisterScreen());
                },
                child: Text(
                  'Giriş Yap',
                  style: regular16pt.copyWith(color: primaryBlue),
                ),
              ),
              SizedBox(width: 15),
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
