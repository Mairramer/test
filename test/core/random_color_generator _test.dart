import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test/core/random_color_generator.dart';

void main() {
  const numColors = 5;

  group('RandomColorGenerator tests', () {
    test('Next color is within brightness range', () {
      final generator = RandomColorGenerator();
      final color = generator.nextColor();
      expect(
        generator.isColorWithinBrightnessRange(color, 0.0, 1.0),
        true,
      );
    });

    test('Text color is black or white', () {
      final generator = RandomColorGenerator();
      final color = generator.nextColor();
      final textColor = generator.getTextColor(color);
      expect(
        textColor == Colors.black || textColor == Colors.white,
        true,
      );
    });

    test('Generated gradient has correct number of colors', () {
      final generator = RandomColorGenerator();
      final colors = generator.generateGradientColors(numColors: numColors);
      expect(colors.length, numColors);
    });

    test('Generated gradient colors are within brightness range', () {
      final generator = RandomColorGenerator();
      final colors = generator.generateGradientColors(numColors: 5);
      for (final color in colors) {
        expect(
          generator.isColorWithinBrightnessRange(color, 0.0, 1.0),
          true,
        );
      }
    });
  });
}
