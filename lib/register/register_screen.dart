
import 'package:new_attendance/components/component.dart';
import 'package:new_attendance/login/loginscreen.dart';
import 'package:new_attendance/register/cubit/cubit.dart';
import 'package:new_attendance/register/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Styles/Colors.dart';






class RegisterScreen extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state)
        {
          if(state is CreateUserSuccessState)
          {
            NavigatorandFinish(context, LoginScreen(),);
          }
        },
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(
              backgroundColor:  primary,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [

                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                            'REGISTER',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline4!
                                .copyWith
                              (color: Colors.black,)

                        ),
                        Text(
                            'Register now to communicate with friends',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith //copywith دي بستخدمها عشان اعدل علي
                              (color: Colors.grey,)

                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultformfield(
                          controller: namecontroller,
                          type: TextInputType.name,
                          label: 'User Name',
                          onSubmit: (value)
                          {

                          },
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Name';
                            }
                            return null;
                          },
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                        defaultformfield(
                          controller: emailcontroller,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          onSubmit: (value)
                          {

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
                          height: 20.0,
                        ),

                        defaultformfield(
                          controller: phonecontroller,
                          type: TextInputType.phone,
                          label: 'Phone +012',
                          onSubmit: (value)
                          {


                          },
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Phone';
                            }
                            return null;
                          },
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultformfield(
                          controller: passwordcontroller,
                          type: TextInputType.visiblePassword,
                          suffix:RegisterCubit.get(context).suffix,
                          obscureText: RegisterCubit.get(context).isPassword,
                          suffixPressed: ()
                          {
                            RegisterCubit.get(context).ChangePasswordVisibility();
                          },


                          onSubmit: (value)
                          {


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
                          height: 10.0,
                        ),
                        ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context)=> defaultbotton(
                                  text: "Submit",
                                  function: ()
                                  {
                                    if (formkey.currentState!.validate())
                                    {
                                      RegisterCubit.get(context).userRegister(
                                        name: namecontroller.text,
                                        email: emailcontroller.text,
                                        phone:phonecontroller.text,
                                        password: passwordcontroller.text,
                                      );
                                    }
                                  },

                                  width: double.infinity,
                                  toUpperCase: true,
                                  radius: 5.0,
                                ),


                            fallback: (context)=>Center(child: CircularProgressIndicator(),)),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
