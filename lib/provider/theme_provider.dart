import 'package:clases/settings/styles_settings.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData = temaDia();
  //double _dimenFont = 1;

  /*getdimenFont() => this._dimenFont;
  setdimenFont(double value) {
    this._dimenFont = value;
    notifyListeners();
  }*/

  getthemeData() => this._themeData;
  setthemData(ThemeData theme) {
    this._themeData = theme;
    notifyListeners();
  }
}
