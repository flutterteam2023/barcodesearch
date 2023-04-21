import 'package:barcodesearch/Screens/login/login_manager.dart';
import 'package:barcodesearch/Screens/register/register_screen.dart';
import 'package:barcodesearch/Shared/Routes/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:go_router/go_router.dart';

import '../../Shared/Constants/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
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
              padding: const EdgeInsets.symmetric(horizontal: 125),
              child: Text(
                "Welcome Back!",
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
              padding: const EdgeInsets.symmetric(horizontal: 64),
              child: Text(
                "Please Log into your existing account",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "Raleway Regular",
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ValueListenableBuilder(valueListenable: LoginManager(), 
                  builder: (context, _, __) {
                    return CustomTextField(
                    hintText: "Your Email",
                    textInputType: TextInputType.emailAddress,
                    obscureText: false,
                    onChanged: (p0) {
                     LoginManager().email.value = p0;
                    },
                  );
                  },
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  ValueListenableBuilder(valueListenable: LoginManager(),
                  builder: (context, _, __) {
                    return CustomTextField(
                    hintText: "Your Password",
                    textInputType: TextInputType.visiblePassword,
                    obscureText: true,
                    onChanged: (p0) {
                     LoginManager().password.value = p0;
                    },
                  );
                    
                  },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Bounceable(
                    onTap: () {
                      LoginManager()
                          .signIn(LoginManager().email.value,LoginManager().password.value, context);
                    },
                    child: Container(
                      height: 58,
                      width: 365,
                      decoration: BoxDecoration(
                          color: Color(0xff2BC990),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "Log in",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Raleway"),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            _forgetPassword(context);
                          },
                          child: Text("I forgot my password")),
                      TextButton(onPressed: () {
                        
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>RegisterScreen()));
                        LoginManager().email.value="";
                        LoginManager().password.value="";
                        LoginManager().forgetPassword.value="";
                        

                      }, child: Text("Register")),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _forgetPassword(BuildContext context) {
  return showModalBottomSheet<void>(
    backgroundColor: Color(0xff0A0171),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16))),
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          height: 300,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "I forgot my password",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: "Raleway"),
                  ),
                  ValueListenableBuilder(
                    valueListenable: LoginManager(),
                    builder: (context, _, __) {
                      return Text(
                        LoginManager().warningMessage.value,
                        style: TextStyle(
                            color: Colors.white, fontFamily: "Raleway Regular"),
                      );
                    },
                  ),
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ValueListenableBuilder(
                        valueListenable: LoginManager(),
                        builder: (context, _, __) {
                          return CustomTextField(
                            obscureText: false,
                            textInputType: TextInputType.emailAddress,
                            onChanged: (p0) {
                              LoginManager().forgetPassword.value = p0;
                            },
                            hintText: "E-mail",
                          );
                        },
                      )),
                  Bounceable(
                    onTap: () {
                      LoginManager().textFieldValidate(
                          LoginManager().forgetPassword,
                          LoginManager().validateForgetPassword);
                      LoginManager().resetPassword(
                          LoginManager().forgetPassword.value.toString().trim(),
                          context);
                    },
                    child: Container(
                      height: 58,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Color(0xff2BC990),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "Reset Password",
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
            ),
          ),
        ),
      );
    },
  );
}
