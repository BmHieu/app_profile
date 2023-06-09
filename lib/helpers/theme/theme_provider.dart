import 'package:dailycanhan/data/local/storage.dart';
import 'package:dailycanhan/helpers/responsive.dart';
import 'package:dailycanhan/helpers/theme/theme_light.dart';
import 'package:flutter/material.dart';

import 'themes.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode? themeMode;

  ThemeProvider() {
    if (themeMode == null) {
      themeMode = storage.getThemeMode();
    }
  }

  Themes getTheme(BuildContext context) {
    if (Responsive.isMobile(context)) {
      print('This is mobile');
    } else {
      print('This is not mobile');
    }
    return Responsive.isMobile(context) ? lightThemeForMobile : lightThemeForTablet;
  }

  Brightness getBrightness(BuildContext context) {
    switch (themeMode) {
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.light:
        return Brightness.light;
      default: // system
        return MediaQuery.of(context).platformBrightness;
    }
  }

  setThemeMode(ThemeMode themeMode) {
    this.themeMode = themeMode;
    storage.setThemeMode(themeMode);
    notifyListeners();
  }
}

class ThemeEnum {
  final String? name, title, description;
  final themeMode, index;

  const ThemeEnum._internal(this.name, this.title, this.themeMode, this.index, {this.description});

  @override
  toString() => name!;

  static const Light = ThemeEnum._internal('Light', 'Light Theme', ThemeMode.light, 0);
  static const Dark = ThemeEnum._internal('Dark', 'Dark Theme', ThemeMode.dark, 1);
  static const System = ThemeEnum._internal('Auto', 'Adapt to System Setting', ThemeMode.system, 2,
      description: '''Adapt automatically to the device’s system setting between dark and light themes.''');

  static getTitleList() => [Light.title, Dark.title, System.title];

  static getDescriptionList() => [Light.description, Dark.description, System.description];

  static getTheme(int index) {
    if (index == Light.index) {
      return Light;
    } else if (index == Dark.index) {
      return Dark;
    } else {
      return System;
    }
  }

  static getThemeByThemeMode(String? themeMode) {
    if (themeMode == Light.themeMode.toString()) {
      return Light;
    } else if (themeMode == Dark.themeMode.toString()) {
      return Dark;
    } else {
      return System;
    }
  }
}
