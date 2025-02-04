
import 'package:bot_toast/bot_toast.dart';

class BottomSheetsAndDialogs {}

class HelperFunctions {
  static Future<void> displayToastMessage(String message) async {
    BotToast.showText(text: message);
  }

  bool checkUrl(String url) {
    if (url.startsWith('http')) {
      return true;
    }
    return false;
  }
}
