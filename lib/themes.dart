import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTheme{
  static bool _light = true;

  static bool getLight(){
    return _light;
  }

  static void setLight(bool toggle){
    _light = toggle;
  }

  static ThemeData getLightTheme(){
    return _lightTheme;
  }

  static ThemeData getDarkTheme(){
    return _darkTheme;
  }

  static ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Color(0xFFE0CB8F))),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedIconTheme: IconThemeData(color: Color(0xFFE0CB8F)),
        selectedIconTheme: IconThemeData(color: Colors.white),
        unselectedItemColor: Color(0xFFE0CB8F),
        unselectedLabelStyle: TextStyle(color: Colors.white)
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFFE0CB8F),
      disabledColor: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colors.black)),
    ),
  );

  static ThemeData _lightTheme = ThemeData(
    accentColor: Colors.grey,
    brightness: Brightness.light,
    primaryColor: Color(0xFFE0CB8F),//Color
    appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFE0CB8F),
        selectedItemColor: Colors.white,
        unselectedIconTheme: IconThemeData(color: Colors.black),
        selectedIconTheme: IconThemeData(color: Colors.white),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: TextStyle(color: Colors.black)
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFFE0CB8F),
      disabledColor: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colors.black)),
    ),
  );
}
