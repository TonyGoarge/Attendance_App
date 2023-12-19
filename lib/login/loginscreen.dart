
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:new_attendance/Network/local/cache_helper.dart';
import 'package:new_attendance/components/component.dart';
import 'package:new_attendance/components/constant.dart';
import 'package:new_attendance/cubit/cubit.dart';
import 'package:new_attendance/login/cubit/cubit.dart';
import 'package:new_attendance/login/cubit/states.dart';
import 'package:new_attendance/screen/home.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Styles/Colors.dart';
import '../register/register_screen.dart';



class LoginScreen extends StatelessWidget {

  double screenHeight = 0;
  double screenWidth = 0;

  final formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final bool isKeyboardVisble =
    KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return  BlocProvider(

      create: (BuildContext context) =>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state)
        {
          if(state is LoginErrorState)
            {
              ShowToast(text: state.error, state: ToastStates.ERROR,);
            }
          if(state is LoginSuccessState)
            {
              CachHelper.saveData(
                key: 'uId', value: state.uId,).then((value)
              {
                uId = state.uId;
                HomeCubit.get(context).getUserData();
                NavigatorandFinish(context, Home(),);
              });
            }
        },
        builder: (context,state){
          return Scaffold(
            resizeToAvoidBottomInset: false, //keyboard erorr

            body: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children:
                  [
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
                    SizedBox(
                      height: screenHeight/20,
                    ),
                    Center(
                      child: Text(
                          'Login',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4!
                              .copyWith
                            (color: Colors.black,)

                      ),
                    ),

                    SizedBox(
                      height: screenHeight/27,
                    ),
                    defaultformfield(
                      controller: emailcontroller,
                      type: TextInputType.emailAddress,
                      label: 'Email Address',
                      onSubmit: (value) {
                        if (formkey.currentState!.validate())
                        {
                          LoginCubit.get(context).userLogin(
                            email: emailcontroller.text,
                            password: passwordcontroller.text,
                          );
                        }
                      },
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Email';
                        }
                        return null;
                      },
                      prefix: Icons.email_outlined,
                    ),
                    SizedBox(
                      height: screenHeight/28,
                    ),
                    defaultformfield(
                      controller: passwordcontroller,
                      type: TextInputType.visiblePassword,
                      suffix:LoginCubit.get(context).suffix,
                      obscureText: LoginCubit.get(context).isPassword,
                      suffixPressed: ()
                      {
                        LoginCubit.get(context).ChangePasswordVisibility();
                      },


                      onSubmit: (value) {
                        if (formkey.currentState!.validate())
                        {
                          LoginCubit.get(context).userLogin(
                              email: emailcontroller.text,
                              password: passwordcontroller.text);
                        }

                      },
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is too short';
                        }
                        return null;
                      },
                      label: 'Password',
                      prefix: Icons.lock_outline,

                    ),
                SizedBox(
                  height: screenHeight/28,
                ),
                    ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context)=>


                            defaultbotton(
                              text: "login",
                              function: ()
                              {
                                if (formkey.currentState!.validate())
                                {
                                  LoginCubit.get(context).userLogin(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text,
                                  );
                                }
                              },

                              width: double.infinity,
                              toUpperCase: true,
                              radius: 10.0,
                            ),


                        fallback: (context)=>Center(child: CircularProgressIndicator(),)),
                    SizedBox(
                      height:screenHeight / 27,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Text(
                            'Don\'t have an account?',
                          ),

                          defaulttextbutton(
                              toUpperCase: false,
                              text: 'Register',
                              onpress: ()
                              {
                                NavigatorTo(
                                  context, RegisterScreen(),);
                              }
                              ),

                        ]
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
