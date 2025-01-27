import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    secondaryContainer: Colors.grey,
    primary: MaterialColor(0xFF000000, blackColor),
    surface: MaterialColor(0xFFFFFFFF, whiteColor),
    surfaceContainerHighest: MaterialColor(0xFFFFFFFF, whiteColor),
    onSurface: Colors.black,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: MaterialColor(0xFF000000, blackColor),
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: MaterialColor(0xFF000000, blackColor),
    ),
  ),
  primarySwatch: MaterialColor(0xFF000000, blackColor),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);