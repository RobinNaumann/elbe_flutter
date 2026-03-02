import 'package:elbe/src/theme/subthemes/color/color_theme_data.dart';

/// differentiates between light and dark color modes
enum ColorModes {
  light,
  dark;

  bool get isDark => this == ColorModes.dark;
}

class ModeColorSeed {
  late final SeedSelector light;
  late final SeedSelector dark;

  ModeColorSeed({SeedSelector? light, SeedSelector? dark}) {
    this.light = light ?? ((path, seed, base, _) => base);
    this.dark = dark ?? ((path, seed, base, _) => base.mirrorBrightness());
  }
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

  factory ModeColor.generate(List<String> path, ColorThemeSeed seed) =>
      ModeColor(
        light: SchemeColor.generate([...path, "light"], seed, seed.values.base),
        dark: SchemeColor.generate(
            [...path, "dark"],
            seed,
            seed.selectors.mode
                .dark([...path, "dark"], seed, seed.values.base, null)),
      );

  SchemeColor mode(ColorModes mode) => [light, dark][mode.index];

  @override
  get map => {"light": light.map, "dark": dark.map};
}
