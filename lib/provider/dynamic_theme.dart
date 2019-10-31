import 'package:flutter/foundation.dart';

enum MyThemesKeys {
  GREY,
  GREEN,
  BLUE,
  DARK_GREY,
}

class DynamicTheme with ChangeNotifier {
  MyThemesKeys _currentTheme = MyThemesKeys.DARK_GREY;

  MyThemesKeys get currentTheme => _currentTheme;

  void changeCurrentTheme(MyThemesKeys themeKey) {
    _currentTheme = themeKey;
    notifyListeners();
  }
}
