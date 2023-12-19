import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:new_attendance/components/constant.dart';
import 'package:new_attendance/login/cubit/states.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/cubit/cubit.dart';
import '../screen/home.dart';


class LoginScreenn extends StatefulWidget {
  const LoginScreenn({Key? key}) : super(key: key);

  @override
  State<LoginScreenn> createState() => _LoginScreennState();
}

class _LoginScreennState extends State<LoginScreenn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xff1670fb);
  late SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisble =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;



        return Scaffold(
          resizeToAvoidBottomInset: false, //keyboard erorr
          body: Column(
            children: [
              /* appbar hide */ isKeyboardVisble
                  ? SizedBox(
                height: screenHeight / 16,
              )
                  : Container(
                height: screenHeight / 2.5,
                width: screenWidth,
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40))),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: screenWidth / 5,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: screenHeight / 25, bottom: screenHeight / 20),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: screenWidth / 18,
                    fontFamily: "CairoBold",
                  ),
                ),
              ),
              //__________________________________________\\
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: screenWidth / 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    fieldTitle("Employee email"),
                    customFiled("Enter your email", emailController, false),
                    fieldTitle("Password"),
                    customFiled("Enter your password", passController, true),
                    GestureDetector(
                      onTap: () async {
                        // to hide keyboard when login
                        FocusScope.of(context).unfocus();

                        String email = emailController.text;
                        String password = passController.text;

                        if (email.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Employee email is still empty!")));
                        } else if (password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Password is still empty!")));
                        } else {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: email,
                              password: password,
                            );

                            // User successfully logged in
                            sharedPreferences = await SharedPreferences.getInstance();
                            sharedPreferences.setString('employee email', email).then((_) => {
                              // pushReplacement the result of the route that is removed
                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) => Home())),
                            });
                          } on FirebaseAuthException catch (e) {
                            String error = "error occurred!";
                            print("/---------------------------------/");
                            print(e.toString());

                            if (e.code == 'user-not-found') {
                              setState(() {
                                error = "Employee email does not exist";
                              });
                            } else if (e.code == 'wrong-password') {
                              setState(() {
                                error = "Password is not correct";
                              });
                            }

                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(error)));
                          }
                        }
                      },

                      child: Container(
                        height: 60,
                        width: screenWidth,
                        margin: EdgeInsets.only(top: screenHeight / 40),
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
                        child: Center(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              fontFamily: "CairoBold",
                              fontSize: screenWidth / 26,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );

  }

  Widget fieldTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth / 26,
          fontFamily: "CairoRegular",
        ),
      ),
    );
  }

  Widget customFiled(
      String hint, TextEditingController controller, bool obsure) {
    return Container(
      width: screenWidth,
      margin: EdgeInsets.only(bottom: screenHeight / 50),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(
                  2,
                  2,
                ))
          ]),
      child: Row(
        children: [
          Container(
            width: screenWidth / 6,
            child: Icon(
              Icons.person,
              color: primary,
              size: screenWidth / 15,
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(right: screenHeight / 12),
            child: TextFormField(
              controller: controller,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: screenHeight / 35),
                border: InputBorder.none,
                hintText: hint,
              ),
              maxLines: 1,
              obscureText: obsure,
            ),
          ))
        ],
      ),
    );
  }
}
