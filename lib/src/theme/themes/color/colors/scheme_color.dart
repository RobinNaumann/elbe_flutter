import 'package:elbe/src/theme/themes/color/colors/kind_color.dart';

import '../color_seed.dart';
import 'layer_color.dart';

/// within a `ModeColor`, containers should be colored with one of these
/// - `primary` is the plain background
/// - `secondary` is the accent background
/// - `inverse` is the background that contrasts with the primary
enum ColorSchemes { primary, secondary, inverse }

class SchemeColor extends KindColor {
  final KindColor primary;
  final KindColor secondary;
  final KindColor inverse;

  SchemeColor(
      {required this.primary, required this.secondary, required this.inverse})
      : super.from(primary);

  SchemeColor.from(SchemeColor c)
      : this(primary: c.primary, secondary: c.secondary, inverse: c.inverse);

  KindColor scheme(ColorSchemes scheme) =>
      [primary, secondary, inverse][scheme.index];

  KindColor? maybeScheme(ColorSchemes? scheme) =>
      scheme != null ? this.scheme(scheme) : null;

  factory SchemeColor.generate(ColorSeed s, LayerColor c) => SchemeColor(
      primary: KindColor.generate(s, s.scheme.primary(s, c)),
      secondary: KindColor.generate(s, s.scheme.secondary(s, c)),
      inverse: KindColor.generate(s, s.scheme.inverse(s, c)));

  @override
  get map => {
        "primary": primary.map,
        "secondary": secondary.map,
        "inverse": inverse.map
      };
}
