import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';

enum ToastMode {
  success,
  delete,
  error,
  warning,
  info,
}

class Helper {
  static Future<void> launchLink({
    required String url,
    required BuildContext context,
  }) async {
    final Uri sUri = Uri.parse(url);
    if (!await launchUrl(
      sUri,
      mode: LaunchMode.externalApplication,
    )) {
      // ignore: use_build_context_synchronously
      customToast(context, 'Could not launch $sUri', ToastMode.error);
    }
  }
  
  static String collapsId({required String id, int show = 2}) {
    if (id.isEmpty) {
      return '';
    } else if (id.length < 2) {
      return id;
    }
    return '${id.substring(0, show)}..${id.substring(id.length - show)}';
  }

  static void copyToClipboard(BuildContext context, String value) {
    Clipboard.setData(ClipboardData(text: value));
    String sliced;
    if (value.length > 50) {
      sliced = '${value.substring(0, 50)}...';
    } else {
      sliced = value;
    }
    customToast(
      context,
      'Copied $sliced',
      ToastMode.info,
    );
  }

  static String trimString(String data, int endcut) {
    if (data.length < endcut) {
      endcut = data.length;
    }
    if (!endcut.isNegative) {
      return data.substring(0, endcut);
    } else {
      return data;
    }
  }

  static void customToast(
      BuildContext context, String msg, ToastMode toastMode) {
    Text description = Text(
      msg,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
    Color background;
    var themeOf = Theme.of(context);

    switch (toastMode) {
      case ToastMode.info:
        background = themeOf.primaryColor;
        break;
      case ToastMode.delete:
        background = themeOf.colorScheme.error;
        break;
      case ToastMode.error:
        background = themeOf.colorScheme.error;
        break;
      case ToastMode.success:
        background = Colors.blueAccent;
        break;
      case ToastMode.warning:
        background = themeOf.colorScheme.error;
        break;
      default:
        background = themeOf.cardColor;
    }
    showSimpleNotification(
      description,
      foreground: themeOf.textTheme.headlineLarge!.color,
      background: background,
      position: NotificationPosition.bottom,
    );
  }

  static String replaceNoPrintable(String value, {String replaceWith = ' '}) {
    var charCodes = <int>[];

    for (final codeUnit in value.codeUnits) {
      if (isPrintable(codeUnit)) {
        charCodes.add(codeUnit);
      } else {
        if (replaceWith.isNotEmpty) {
          charCodes.add(replaceWith.codeUnits[0]);
        }
      }
    }

    return String.fromCharCodes(charCodes);
  }

  static bool isPrintable(int codeUnit) {
    var printable = true;

    if (codeUnit < 33) printable = false;
    if (codeUnit >= 127) printable = false;

    return printable;
  }
}
