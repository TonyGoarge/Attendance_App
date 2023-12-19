import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Colors.dart';

ThemeData darkTheme=ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    backwardsCompatibility: false,
    backgroundColor:HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontFamily: 'Bahij-Janna-Regular',
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),

    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20.0,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('333739'),
  ),
  textTheme: TextTheme(

    bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.white
    ),
    headline4: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white
    ),
    // bodyText2: TextStyle(
    //     fontSize: 24.0,
    //     fontWeight: FontWeight.w600,
    //     color: Colors.white
    // ),
    subtitle1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      height: 1.5,
    ),
    subtitle2: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      height: 1.5,
    ),
  ),
  fontFamily: 'Bahij-Janna-Regular',
);


    ThemeData lightTheme=ThemeData(
      primarySwatch:defaultColor,
      scaffoldBackgroundColor:Colors.white,
      appBarTheme: AppBarTheme(
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          fontFamily: 'Bahij-Janna-Regular',

          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      bottomNavigationBarTheme:  BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor:defaultColor,
        elevation: 20.0,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.black
        ),
        headline4: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black
        ),
        // bodyText2: TextStyle(
        //     fontSize: 24.0,
        //     fontWeight: FontWeight.w600,
        //     color: Colors.black
        // ),

        subtitle1: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          height: 1.5
        ),
        subtitle2: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          height: 1.5,
        ),
      ),
      fontFamily: 'Bahij-Janna-Regular',

    );