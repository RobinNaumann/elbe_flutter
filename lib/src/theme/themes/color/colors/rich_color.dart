import 'package:elbe/elbe.dart';
import 'package:elbe/src/extensions/maybe_map.dart';
import 'package:elbe/util/json_tools.dart';

const Color grey = Color(0xFF808080);

extension _Fract on double {
  // ignore: unnecessary_this
  double get norm => this.clamp(0.0, 1.0);
}

extension RichColor on Color {
  /// cheap luminance function. Gets the approximate brightness for a color
  /// 0 is black, 1 is white
  double get luminance {
    final c = [this.red, this.green, this.blue].listMap((e) {
      final v = e / 255;
      return v <= 0.03928 ? v / 12.92 : Math.pow((v + 0.055) / 1.055, 2.4);
    });
    return c[0] * 0.2126 + c[1] * 0.7152 + c[2] * 0.0722;
  }

  /// whether the color is bright or dark
  bool get isDark => luminance < 0.5;

  /// return a color with the same hue but different saturation
  /// [factor] = 1 will return the same color, 0 will return grey
  Color desaturated([double factor = 1]) {
    final avg = (red + green + blue) ~/ 3;
    return Color.fromARGB(
        this.alpha,
        (red + (avg - red) * factor).round().clamp(0, 255),
        (green + (avg - green) * factor).round().clamp(0, 255),
        (blue + (avg - blue) * factor).round().clamp(0, 255));
  }

  /// change the alpha (^ opacity) value of a color
  /// use this instead of `withAlpha` is this is a Flutter method
  Color withOpacity(double alpha) =>
      Color.fromARGB((alpha * 255).round().clamp(0, 255), red, green, blue);

  /// interpolate between two colors
  /// [factor] = 1 will return the other color, 0 will return the same color
  Color inter(Color other, double factor) => Color.fromARGB(
      255,
      (red + (other.red - red) * factor).round().clamp(0, 255),
      (green + (other.green - green) * factor).round().clamp(0, 255),
      (blue + (other.blue - blue) * factor).round().clamp(0, 255));

  /// mirror the brightness of a color. keep the hue and saturation
  /// [factor] = 1 will return the inverted color, 0 will return the same color
  Color mirrorBrightness([double factor = 1]) {
    final hsl = HSLColor.fromColor(this);
    final l = hsl.lightness;
    return hsl.withLightness((l + (0.5 - l) * 2 * factor).norm).toColor();
  }

  /// get the contrast ratio between two colors
  double contrastRatio(Color other) {
    final l1 = luminance;
    final l2 = other.luminance;
    return (Math.max(l1, l2) + 0.05) / (Math.min(l1, l2) + 0.05);
  }

  /// check if two colors have a _'good'_ contrast ratio of for legibility
  hasWCAGContrast(Color other) => this.contrastRatio(other) >= 3;

  JsonMap<int> get map => {
        "red": red,
        "green": green,
        "blue": blue,
        "alpha": alpha,
      };
}
