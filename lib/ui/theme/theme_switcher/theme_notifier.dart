

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  final String key = "theme";
  late SharedPreferences _pref;
  var brightness = SchedulerBinding.instance!.window.platformBrightness;
  // var isSystemDark = brightness == Brightness.dark;
  late bool _darkTheme = _getDeviceTheme();
  bool get darkTheme =>_darkTheme;


  bool _getDeviceTheme(){
    var isSystemDark = brightness == Brightness.dark;
    return isSystemDark;
  }

  toggleTheme(){
    _darkTheme = !_darkTheme;
    notifyListeners();
  }
}