import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test/common/constants/constants.dart';

///define a class to generate random colors
class RandomColorGenerator {
  final Random _random;
  final int _alpha;
  final int _minRed;
  final int _maxRed;
  final int _minGreen;
  final int _maxGreen;
  final int _minBlue;
  final int _maxBlue;
  final double _minBrightness;
  final double _maxBrightness;

  ///constructor
  RandomColorGenerator({
    int alpha = Constants.alpha,
    int minRed = Constants.minRed,
    int maxRed = Constants.maxRed,
    int minGreen = Constants.minGreen,
    int maxGreen = Constants.maxGreen,
    int minBlue = Constants.minBlue,
    int maxBlue = Constants.maxBlue,
    double minBrightness = 0.0,
    double maxBrightness = 1.0,
    Random? random,
  })  : _random = random ?? Random(),
        _alpha = alpha,
        _minRed = minRed,
        _maxRed = maxRed,
        _minGreen = minGreen,
        _maxGreen = maxGreen,
        _minBlue = minBlue,
        _maxBlue = maxBlue,
        _minBrightness = minBrightness,
        _maxBrightness = maxBrightness;

  ///generate a random color
  ///Big O: O(n)
  Color nextColor() {
    Color color;
    do {
      final r = _minRed + _random.nextInt(_maxRed - _minRed + 1);
      final g = _minGreen + _random.nextInt(_maxGreen - _minGreen + 1);
      final b = _minBlue + _random.nextInt(_maxBlue - _minBlue + 1);
      color = Color.fromARGB(_alpha, r, g, b);
    } while (!isColorWithinBrightnessRange(
      color,
      _minBrightness,
      _maxBrightness,
    ));

    return color;
  }

  ///check if the color is within the brightness range
  ///Big O: O(1)
  bool isColorWithinBrightnessRange(
    Color color,
    double minBrightness,
    double maxBrightness,
  ) {
    final hslColor = HSLColor.fromColor(color);
    final luminance = hslColor.lightness;

    return luminance >= minBrightness && luminance <= maxBrightness;
  }

  ///get the text color based on the background color
  ///Big O: O(n)
  Color getTextColor(Color backgroundColor, [List<Color>? colors]) {
    const luminanceThreshold = 0.5;
    final hslColor = HSLColor.fromColor(backgroundColor);
    final luminance = hslColor.lightness;
    if (colors != null) {
      for (final int i = 0; i < colors.length;) {
        final hslColor = HSLColor.fromColor(colors[i]);
        final luminance = hslColor.lightness;

        return luminance > luminanceThreshold ? Colors.black : Colors.white;
      }
    }

    return luminance > luminanceThreshold ? Colors.black : Colors.white;
  }

  ///generate a list of gradient colors
  ///Big O: O(n)
  List<Color> generateGradientColors({
    int numColors = Constants.numColors,
    RandomColorGenerator? colorGenerator,
  }) {
    colorGenerator ??= RandomColorGenerator();

    final List<Color> gradientColors = [];
    final Set<int> uniqueColors = {};

    while (gradientColors.length < numColors) {
      final Color color = colorGenerator.nextColor();
      // Convert Color to its RGB integer representation
      final int colorValue = color.value;

      if (!uniqueColors.contains(colorValue)) {
        gradientColors.add(color);
        uniqueColors.add(colorValue);
      }
    }

    return gradientColors;
  }

  ///generate a random alignment for the gradient
  ///Big O: O(1)
  Alignment generateRandomAlignment() {
    final List<Alignment> alignments = [
      Alignment.topLeft,
      Alignment.topCenter,
      Alignment.topRight,
      Alignment.centerLeft,
      Alignment.center,
      Alignment.centerRight,
      Alignment.bottomLeft,
      Alignment.bottomCenter,
      Alignment.bottomRight,
    ];

    return alignments[_random.nextInt(alignments.length)];
  }
}
