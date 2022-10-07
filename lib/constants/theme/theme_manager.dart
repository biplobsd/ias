import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static ThemeData buildTheme(Brightness brightness) {
    var mainColor = {
      'mainLightBgColor': const Color(0xff2B2B2B),
      'bgColorLight': const Color.fromARGB(255, 240, 241, 252),
      'bgColorDark': const Color(0xff3b3b3b),
      'canvsColorDark': const Color(0xff2B2B2B),
    };
    var baseTheme = ThemeData(
        brightness: brightness,
        primarySwatch: const MaterialColor(
          0xFF2196F3,
          <int, Color>{
            50: Color(0xFFE3F2FD),
            100: Color(0xFF82B1FF),
            200: Color(0xFF448AFF),
            300: Color(0xFF64B5F6),
            400: Color(0xFF2979FF),
            500: Color(0xFF2196F3),
            600: Color(0xFF1E88E5),
            700: Color(0xFF2962FF),
            800: Color(0xFF1565C0),
            900: Color(0xFF0D47A1),
          },
        ));
    var mainLightBgColor = mainColor['mainLightBgColor'];
    var bgColor = Brightness.light == brightness
        ? mainColor['bgColorLight']
        : mainColor['bgColorDark'];
    var canvsColor =
        Brightness.light == brightness ? bgColor : mainColor['canvsColorDark'];
    var appBarTheme = Brightness.light == brightness
        ? baseTheme.appBarTheme.copyWith(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            backgroundColor: bgColor,
            toolbarTextStyle: baseTheme.textTheme.bodySmall!.copyWith(
              color: mainLightBgColor,
            ),
            iconTheme: IconThemeData(
              color: mainLightBgColor,
            ),
          )
        : baseTheme.appBarTheme;
    return baseTheme.copyWith(
      appBarTheme: appBarTheme,
      canvasColor: canvsColor,
      cardColor: canvsColor,
      scaffoldBackgroundColor: bgColor,
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
    );
  }
}
