import 'package:flutter/foundation.dart';

enum MyThemesKeys {
  GREY,
  GREEN,
  BLUE,
  DARK
}

class DynamicTheme with ChangeNotifier {
  MyThemesKeys _currentTheme = MyThemesKeys.DARK;

  MyThemesKeys get currentTheme => _currentTheme;

  void changeCurrentTheme(MyThemesKeys themeKey) {
    _currentTheme = themeKey;
    notifyListeners();
  }
}
