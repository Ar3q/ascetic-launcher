import 'package:intent/intent.dart';

class IntentUtils {
  static void useIntent(String action) {
    try {
      Intent()
        ..setAction(action)
        ..startActivity();
    } catch (e) {
      print(e);
    }
  }

  static void useIntentWithCategory(String action, String category) {
    try {
      Intent()
        ..setAction(action)
        ..addCategory(category)
        ..startActivity();
    } catch (e) {
      print(e);
    }
  }
}
