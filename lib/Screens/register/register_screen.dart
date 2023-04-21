import 'package:barcodesearch/Screens/login/login_manager.dart';
import 'package:barcodesearch/Screens/register/register_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../../Shared/Constants/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0A0171),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 115, right: 115, top: 92),
              child: Container(
                height: 158,
                width: 177,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/login.png"),
                        fit: BoxFit.fill)),
              ),
            ),
            SizedBox(
              height: 51,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 160),
              child: Text(
                "Register",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 27,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: RegisterManager(),
                    builder: (context, _, __) {
                      return CustomTextField(
                        hintText: "Your Email",
                        textInputType: TextInputType.emailAddress,
                        obscureText: false,
                        onChanged: (p0) {
                          RegisterManager().email.value = p0;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  ValueListenableBuilder(
                    valueListenable: RegisterManager(),
                    builder: (context, _, __) {
                      return CustomTextField(
                        hintText: "Your Password",
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                        onChanged: (p0) {
                          RegisterManager().password.value = p0;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  ValueListenableBuilder(
                    valueListenable: RegisterManager(),
                    builder: (context, _, __) {
                      return CustomTextField(
                        hintText: "Password Repeat",
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                        onChanged: (p0) {
                          RegisterManager().rePassword.value = p0;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Bounceable(
                    onTap: () {
                      RegisterManager().createUser(
                        RegisterManager().email.value,
                        RegisterManager().password.value,
                        RegisterManager().rePassword.value,
                        context,
                      );
                    },
                    child: Container(
                      height: 58,
                      width: 365,
                      decoration: BoxDecoration(
                          color: Color(0xff2BC990),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Raleway"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
