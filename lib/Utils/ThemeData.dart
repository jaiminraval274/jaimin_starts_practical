/**
 * Created by Jaimin on 20/03/24.
 */
import 'package:flutter/material.dart';

import 'Colors.dart';

//-------------light theme------------------//
ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: backgroundColor,
  brightness: Brightness.light,
  appBarTheme:
      const AppBarTheme(backgroundColor: backgroundColor, centerTitle: true),
  useMaterial3: true,
);
