
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class BottomSheetsAndDialogs {}

class HelperFunctions {
  static Future<void> displayToastMessage(String title, String message, BuildContext context) async {
    // BotToast.showText(text: message,contentColor: kSecondaryColor,);
         var snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.fixed,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: title,
                    message:
                      message,

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.help,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
  }

  bool checkUrl(String url) {
    if (url.startsWith('http')) {
      return true;
    }
    return false;
  }
}
