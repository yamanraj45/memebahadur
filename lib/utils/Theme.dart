import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.indigo,
  accentColor: Colors.pink,
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  accentColor: Colors.indigo,
  primarySwatch: Colors.pink,
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _prefs;
  bool _darkTheme;
  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadfromPrefs();
  }

  toogleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPref() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadfromPrefs() async {
    await _initPref();
    _darkTheme = _prefs.getBool(key) ?? true;
  }

  _saveToPrefs() async {
    await _initPref();
    _prefs.setBool(key, _darkTheme);
  }
}
