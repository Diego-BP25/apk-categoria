import 'package:flutter/material.dart';

class AppbarTheme {
  
  static final theme1 = ThemeData.light().copyWith(
        primaryColor: Colors.amber,
        appBarTheme: const AppBarTheme(
          color: Colors.lightBlue,
          elevation: 0,
          titleTextStyle: TextStyle(),
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(bodyMedium: TextStyle(
          fontSize: 45,
          color: Color.fromARGB(255,254, 255, 253)))
       
      );

  static final theme2 = ThemeData.dark().copyWith(
        primaryColor: Colors.amber,
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          elevation: 0,
          titleTextStyle: TextStyle(),
          foregroundColor: Colors.black,
        ),
        textTheme: const TextTheme(bodyMedium: TextStyle(
          fontSize: 45,
          color: Color.fromARGB(255, 0, 0, 0)))
       
      );
}