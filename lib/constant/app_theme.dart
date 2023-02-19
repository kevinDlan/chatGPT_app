import 'package:flutter/material.dart';

final ThemeData lighTheme = ThemeData(
  colorScheme: ThemeData.light().colorScheme.copyWith(
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Colors.deepOrange,
      onSecondary: Colors.white),
);
final ThemeData darkTheme = ThemeData(
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: Colors.blueGrey,
        onPrimary: Colors.white,
        secondary: Colors.blueGrey,
        onSecondary: Colors.white,
      ),
);
