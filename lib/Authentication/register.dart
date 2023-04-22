import 'dart:async';

import 'package:barcodesearch/Authentication/theme.dart';
import 'package:barcodesearch/Screens/register/register_manager.dart';
import 'package:barcodesearch/Shared/Widgets/app_buttons.dart';
import 'package:barcodesearch/Shared/Widgets/input_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool passwordVisible = false;
  bool passwordConfrimationVisible = false;
  bool isChecked = false;

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '''Yeni hesap\noluştur''',
                  style: heading2.copyWith(color: textBlack),
                ),
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            Form(
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 1,
                        child: InputField(
                          hintText: 'Adınız',
                          suffixIcon: const SizedBox(),
                          onChanged: (p0) {
                           RegisterManager().name.value = p0;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: InputField(
                          hintText: 'Soyadınız',
                          suffixIcon: const SizedBox(),
                          onChanged: (p0) {
                           RegisterManager().surname.value = p0;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  InputField(
                    hintText: 'E-postanız',
                    suffixIcon: const SizedBox(),
                    onChanged: (p0) {
                      RegisterManager().email.value = p0;
                    },
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  InputField(
                    hintText: 'Şifreniz',
                    obscureText: !passwordVisible,
                    suffixIcon: IconButton(
                      color: textGrey,
                      splashRadius: 1,
                      icon: Icon(passwordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: togglePassword,
                    ),
                    onChanged: (p0) {
                      RegisterManager().password.value = p0;
                    },
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  InputField(
                    hintText: 'Şifre Tekrar',
                    obscureText: !passwordVisible,
                    suffixIcon: IconButton(
                      color: textGrey,
                      splashRadius: 1,
                      icon: Icon(passwordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: togglePassword,
                    ),
                    onChanged: (p0) {
                      RegisterManager().rePassword.value = p0;
                    },
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isChecked = !isChecked;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isChecked ? primaryBlue : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      border: isChecked
                          ? null
                          : Border.all(color: textGrey, width: 1.5),
                    ),
                    width: 20,
                    height: 20,
                    child: isChecked
                        ? const Icon(
                            Icons.check,
                            size: 20,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gizlilik Sözleşmesi & Kullanım Koşullarını',
                      style: regular16pt.copyWith(color: primaryBlue),
                    ),
                    Text(
                      'kabul ediyorum.',
                      style: regular16pt.copyWith(color: textGrey),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 12,
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            const SizedBox(
              height: 18,
            ),
            AppButtons.roundedButton(
                borderRadius: BorderRadius.circular(14),
                backgroundColor: primaryBlue,
                text: 'Kayıt Ol',
                function: () async {
                  await RegisterManager().createUser(
                    RegisterManager().email.value,
                    RegisterManager().password.value,
                    RegisterManager().rePassword.value,
                    RegisterManager().name.value,
                    RegisterManager().surname.value,
                    RegisterManager().credit.value,
                    RegisterManager().createdAt.value,
                   
                    context,
                  );
                }),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Zaten hesabınız var mı? ",
                  style: regular16pt.copyWith(color: textGrey),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Giriş Yapın',
                    style: regular16pt.copyWith(color: primaryBlue),
                  ),
                ),
              ],
            ),
            SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
