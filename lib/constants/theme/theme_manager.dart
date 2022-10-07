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
          0xFFE040FB,
          <int, Color>{
            50: Color(0xFFF3E5F5),
            100: Color(0xFFEA80FC),
            200: Color(0xFFCE93D8),
            300: Color(0xFFBA68C8),
            400: Color(0xFFD500F9),
            500: Color(0xFF9C27B0),
            600: Color(0xFF8E24AA),
            700: Color(0xFFAA00FF),
            800: Color(0xFF6A1B9A),
            900: Color(0xFF4A148C),
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
