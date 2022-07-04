import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preloadwebapptemplate/constants/string.dart';
import 'package:motion_toast/motion_toast.dart';

class Helper {
  static void copyToClipboard(BuildContext context, String value) {
    Clipboard.setData(ClipboardData(text: value));
    String sliced;
    if (value.length > 50) {
      sliced = '${value.substring(0, 50)}...';
    } else {
      sliced = value;
    }
    MotionToast.info(
      title: const Text(
        AppString.copied,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      description: Text(sliced),
    ).show(context);
  }
}
