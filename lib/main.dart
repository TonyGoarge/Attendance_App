import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:new_attendance/Network/bloc_observer.dart';
import 'package:new_attendance/Network/local/cache_helper.dart';
import 'package:new_attendance/Styles/Colors.dart';
import 'package:new_attendance/components/constant.dart';
import 'package:new_attendance/cubit/cubit.dart';
import 'package:new_attendance/cubit/state.dart';
import 'package:new_attendance/login/loginscreen.dart';


import 'package:new_attendance/screen/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:month_year_picker/month_year_picker.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  // DioHelper.init();
  await CachHelper.init();
  // bool? isDark=CachHelper.getData(key:'isDark');
  Widget widget;
  // bool? onBoarding=CachHelper.getData(key:'onBoarding');
  // token=CachHelper.getData(key:'token');
  uId=CachHelper.getData(key:'uId');



  if(uId != null)        //    بقوله طول ما انت معاك uid انت في sociallayout حصل مشكل ارجع لل loginscreen
      {
    widget=Home();

  }
  else
  {
    widget=LoginScreen();
  }


  runApp(MyApp(
    BegainWidget:widget,
  ));
}


class MyApp extends StatelessWidget {
  final Widget BegainWidget;

  const MyApp({required this.BegainWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (context)=>HomeCubit()..getUserData()),
      ],
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,

            home: KeyboardVisibilityProvider(child:  BegainWidget,),
            localizationsDelegates: const
            [
              MonthYearPickerLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}




// class AuthCheck extends StatefulWidget {
//   const AuthCheck({Key? key}) : super(key: key);
//
//   @override
//   State<AuthCheck> createState() => _AuthCheckState();
// }

// class _AuthCheckState extends State<AuthCheck> {
//   bool userAvailable = false;
//   late SharedPreferences sharedPreferences;
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentUser();
//   }
//   void _getCurrentUser()async{
//     sharedPreferences = await SharedPreferences.getInstance();
//     try{
// if(sharedPreferences.getString('employee email')!= null ){
// setState(() {
//   Users user = Users();
//
//   String? userEmail = user.email;
//   userEmail =sharedPreferences.getString('employee email')!;
//       userAvailable = true;
//
// });
// }
//     }catch(e){
//       setState(() {
//
//         userAvailable = false;
//
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  userAvailable ? Home() : LoginScreen();
//   }
// }

