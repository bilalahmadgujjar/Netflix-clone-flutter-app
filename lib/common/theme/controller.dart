

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data.dart';

class ThemeController extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ThemeController()
  {
    _loadThemePreference();
  }

  // Toggle between light and dark mode
  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    _saveThemePreference();
  }

  // Save theme preference to SharedPreferences
  Future<void> _saveThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
  }

  // Load theme preference from SharedPreferences
  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }



  // void toggleTheme() {
  //   _isDarkMode = !_isDarkMode;
  //   notifyListeners();
  // }

  // Get the current theme's primary color
  Color get primaryColor =>
      _isDarkMode ? AppTheme.darkPrimaryColor : AppTheme.primaryColor;

  // Get the current theme's background color
  Color get backgroundColor =>
      _isDarkMode ? AppTheme.darkBackgroundColor : AppTheme.backgroundColor;

  Color get secondaryColor =>
      _isDarkMode ? AppTheme.darkSecondaryColor : AppTheme.secondaryColor;

  // Get the current theme's text color
  Color get textColor =>
      _isDarkMode ? AppTheme.darkTextColor : AppTheme.textColor;

  Color get disabledColor =>
      _isDarkMode ? AppTheme.darkDisabledColor : AppTheme.disabledColor;

  Color get disabledColor2 =>
      _isDarkMode ? AppTheme.darkDisabledColor2 : AppTheme.disabledColor2;

  Color get blackColor => AppTheme.blackColor;
  Color get whiteColor => AppTheme.whiteColor;
  Color get yellowColor => AppTheme.yellowColor;
  Color get greenColor => AppTheme.greenColor;
  Color get redColor => AppTheme.redColor;
  Color get blueColor => AppTheme.blueColor;
  Color get greyColor => AppTheme.greyColor;
  Color get searchColor => AppTheme.darkSearchColor;

  void setTheme(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    notifyListeners();
  }
}
