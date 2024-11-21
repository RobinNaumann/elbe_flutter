import 'package:elbe/src/theme/themes/color/color_seed.dart';

import 'scheme_color.dart';

/// differentiates between light and dark color modes
enum ColorModes {
  light,
  dark;

  bool get isDark => this == ColorModes.dark;
}

class ModeColor extends SchemeColor {
  final SchemeColor light;
  final SchemeColor dark;

  ModeColor({required this.light, required this.dark}) : super.from(light);

  /*public static generate(seed?: Partial<ColorThemeSeed>): ColorTheme {
    const s: ColorThemeSeed = colorThemePreset(seed);
    return new ColorTheme(s, ModeColor.generate(s));
  }*/

  ModeColor.from(ModeColor c) : this(light: c.light, dark: c.dark);

  factory ModeColor.generate(ColorSeed seed) => ModeColor(
      light: SchemeColor.generate(seed, seed.base),
      dark: SchemeColor.generate(seed, seed.mode.dark(seed, seed.base)));

  SchemeColor mode(ColorModes mode) => [light, dark][mode.index];
  SchemeColor? maybeMode(ColorModes? modes) =>
      modes != null ? this.mode(modes) : null;

  @override
  get map => {"light": light.map, "dark": dark.map};
}
