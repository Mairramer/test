import 'package:flutter/painting.dart';

/// This class contains the typography styles used in the app
mixin AppTypography {
  /// Font family
  static const fontFamily = 'Montserrat';

  /// Typography styles
  static const typographyParagraphMedium = TextStyle(
    fontSize: 16,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  /// Typography styles
  static const typographyHeader3 = TextStyle(
    fontSize: 24,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
}
