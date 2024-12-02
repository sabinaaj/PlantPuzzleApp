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

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: MaterialColor(0xFFFFFFFF, whiteColor),
    secondary: Colors.lightBlue,
    tertiary: Colors.lightBlue,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: MaterialColor(0xFFFFFFFF, whiteColor),
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: MaterialColor(0xFFFFFFFF, whiteColor),
    ),
  ),
  primarySwatch: MaterialColor(0xFFFFFFFF, whiteColor),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
