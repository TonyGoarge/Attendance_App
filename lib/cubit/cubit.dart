



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_attendance/cubit/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/constant.dart';
import '../models/login_model.dart';
import '../screen/calendascreen.dart';
import '../screen/profilescreen.dart';
import '../screen/todayscreen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() :super(HomeIntialState());

  static HomeCubit get(context) => BlocProvider.of(context);
// bool useravailable=false;
late SharedPreferences sharedPreferences;





  int currentindex = 1;

  List<Widget>screens=[
    new CalendarScreen(),
    new TodayScreen(),
    new ProfileScreen(),
  ];
  List<String> titles=
  [
    'Calender',
    'Today',
    'profile',
  ];
  void ChangeBottom(int index) {
    currentindex = index;
    emit(HomeChangeBottomNavState());
  }


  Users? model;



  void getUserData()
  {
    emit(GetUserLoadinglState());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .get()
        .then((value)
    {

      print (value.data());
      // print('uiddddddddddd'+uId!);
      model=Users.fromjson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error.toString()));
    });

  }

  void updateUser({                                                 //كدا بعمل update للمعلومات و بقوله يرجع image=قيمهم القديمة , cover =قيمهم القديمة
    required String name,
    required String phone,
    required String email,

  })
  {

    {
      Users model=Users(
        name:name,
        email: email,
        phone:phone,
        uId: uId,

      );

      FirebaseFirestore.instance
          .collection('Users')
          .doc(uId)
          .update(model.toMap())
          .then((value)
      {

        getUserData();
      })
          .catchError((error)
      {
        emit(UserUpdateSuccessState());
      });
    }
  }


}