import '../color_theme_data.dart';

class SchemeColorSeed {
  late final SeedSelector primary;
  late final SeedSelector secondary;
  late final SeedSelector inverse;

  SchemeColorSeed(
      {SeedSelector? primary, SeedSelector? secondary, SeedSelector? inverse}) {
    this.primary = primary ?? ((path, seed, base, _) => base);
    this.secondary = secondary ??
        ((path, seed, base, _) => (path.contains("highvis"))
            ? base
            : LayerColor(
                back: base.back
                    .inter(
                      seed.values.accent.back,
                      base.back.luminance < 0.3 ? 0.2 : 0.1,
                    )
                    .desaturated(0.5),
                front: base.front,
                border: base.border));
    this.inverse =
        inverse ?? ((path, seed, base, _) => base.mirrorBrightness());
  }
}

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

  factory SchemeColor.generate(
          List<String> path, ColorThemeSeed seed, LayerColor base) =>
      SchemeColor(
        primary: KindColor.generate(
            [...path, "primary"],
            seed,
            seed.selectors.scheme
                .primary([...path, "primary"], seed, base, null)),
        secondary: KindColor.generate(
            [...path, "secondary"],
            seed,
            seed.selectors.scheme
                .secondary([...path, "secondary"], seed, base, null)),
        inverse: KindColor.generate(
            [...path, "inverse"],
            seed,
            seed.selectors.scheme
                .inverse([...path, "inverse"], seed, base, null)),
      );

  @override
  get map => {
        "primary": primary.map,
        "secondary": secondary.map,
        "inverse": inverse.map
      };
}

/*
REFERENCE TS CODE:

 primary: KindColor.generate(
          [...path, "primary"],
          seed,
          m.primary({ path, seed, base })
        ),
        secondary: KindColor.generate(
          [...path, "secondary"],
          seed,
          m.secondary({ path, seed, base })
        ),
        inverse: KindColor.generate(
          [...path, "inverse"],
          seed,
          m.inverse({ path, seed, base })
        ),
 */
