import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool _isDarkMode = false;
  Color _backgroundColor = Colors.white;
  Color _textColor = Colors.black;
  String _fontFamily = 'Roboto';

  bool get isDarkMode => _isDarkMode;
  Color get backgroundColor => _backgroundColor;
  Color get textColor => _textColor;
  String get fontFamily => _fontFamily;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void updateUI(Color backgroundColor, Color textColor, String fontFamily) {
    _backgroundColor = backgroundColor;
    _textColor = textColor;
    _fontFamily = fontFamily;
    notifyListeners();
  }
}
