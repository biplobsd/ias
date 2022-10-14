class AppString {
  static const String appName = 'Image Animated Splitter';
  static const String poweredByTitle = 'Powered by biplobsd.github.io';
  static const String copied = "Copied";
  static const String devInfoUrl =
      'https://play.google.com/store/apps/dev?id=7013622463085625240';
  static const String devGithubUrlBiplob = 'https://github.com/biplobsd';
  static const String githubIssueUrl = 'https://github.com/biplobsd/speedout-privacy/issues';
  static const String appForwordUrl = 'https://biplobsd.github.io';
  static const String shortName = 'ias';
  
  static const SupportedPlatformsUrl sPU = SupportedPlatformsUrl(
    android: 'https://play.google.com/store/apps/details?id=com.speedout.ias',
    web: 'https://ias.web.app',
    windows: 'https://www.microsoft.com/store/productId/9PMSK3V7SJLC',
  );
}

class SupportedPlatformsUrl {
  final String android;
  final String windows;
  final String web;
  const SupportedPlatformsUrl({
    required this.android,
    required this.windows,
    required this.web,
  });
}
