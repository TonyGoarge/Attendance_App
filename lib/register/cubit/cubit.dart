import 'package:new_attendance/models/login_model.dart';
import 'package:new_attendance/register/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';






class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit():super(RegisterInitialState());

  static RegisterCubit get(context)=>BlocProvider.of(context);

  void userRegister
      ({
    required String name,
    required String email,
    required String phone,
    required String password,


  })
  {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,)
        .then((value)
    {
      print(value.user?.email);
      print(value.user?.uid);
      userCreate(
        name: name,
        email: email,
        phone:phone,

        uId: value.user!.uid,

      );


    }
    ).catchError((error)
    {
      emit(RegisterErrorState(error.toString()));
print(error.toString());
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,

  })

  {
    Users model=Users(
      name:name,
      email:email,
      phone:phone,
      uId:uId,

    );

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)                          //عشان هشتغل علي uId
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CreateUserErrorState(error.toString()));

    });
  }


  IconData suffix= Icons.visibility_outlined;
  bool isPassword=false;
  void ChangePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix=isPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordvisibilityState());
  }

}

