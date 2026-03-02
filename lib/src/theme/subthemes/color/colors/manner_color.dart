import 'package:elbe/src/theme/subthemes/color/color_theme_data.dart';

class MannerColorSeed {
  late final SeedSelector major;
  late final SeedSelector minor;
  late final SeedSelector flat;

  MannerColorSeed({
    SeedSelector? major,
    SeedSelector? minor,
    SeedSelector? flat,
  }) {
    this.major = major ?? ((_, seed, base, style) => _makeMajor(base, style));
    this.minor = minor ??
        ((path, seed, base, style) => path.contains("highvis")
            ? _makeMajor(base, style)
            : _makeMinor(base, style));
    this.flat =
        flat ?? ((path, seed, base, style) => _makeFlat(base, style, path));
  }

  static LayerColor _makeMajor(LayerColor base, LayerColor? style) {
    if (style == null) return base;
    return LayerColor(back: style.back, front: style.front, border: style.back);
  }

  static LayerColor _makeMinor(LayerColor base, LayerColor? style) {
    if (style == null) return base;
    final b = base.back;

    final backIn = b.mirrorBrightness();
    final major = style.back;
    final minor = style.back.inter(b, 0.8);
    final minorFront = minor.hasWCAGContrast(major) ? major : null;
    return LayerColor(
      back: minor,
      front: minorFront ?? major.inter(backIn, 0.6),
      border: minorFront ?? major.inter(backIn, 0.3),
    );
  }

  static LayerColor _makeFlat(
      LayerColor base, LayerColor? style, List<String> path) {
    final highVis = path.contains("highvis");

    final front = style == null
        ? base.front
        : base.back.hasWCAGContrast(style.back)
            ? style.back
            : style.back.inter(base.front, 0.6);

    final isDark = base.back.luminance < 0.3;

    final border = !highVis && style == null
        ? base.front.inter(base.back, isDark ? 0.75 : 0.9)
        : front;

    return LayerColor(back: base.back, front: front, border: border);
  }
}

/// each `KindColor` can be in one of these states
/// - `major` is the most visually prominent state
/// - `minor` is a less visually prominent state
/// - `flat` is the least visually prominent state. It has no background
enum ColorManners { major, minor, flat, plain }

class MannerColor extends StateColor {
  final StateColor major;
  final StateColor minor;
  final StateColor flat;
  final StateColor plain;

  MannerColor(
      {required this.major,
      required this.minor,
      required this.flat,
      required this.plain})
      : super.from(flat);

  MannerColor.from(MannerColor c)
      : this(major: c.major, minor: c.minor, flat: c.flat, plain: c.plain);

  factory MannerColor.generate(List<String> path, ColorThemeSeed seed,
          LayerColor base, LayerColor style) =>
      MannerColor(
        major: StateColor.generate([...path, "major"], base,
            seed.selectors.manner.major(path, seed, base, style)),
        minor: StateColor.generate([...path, "minor"], base,
            seed.selectors.manner.minor(path, seed, base, style)),
        flat: StateColor.generate([...path, "flat"], base,
            seed.selectors.manner.flat(path, seed, base, style), true),
        plain: StateColor.generate([...path, "plain"], base, base, true),
      );

  StateColor manner(ColorManners manner) =>
      [major, minor, flat, plain][manner.index];

  @override
  get map => {
        "major": major.map,
        "minor": minor.map,
        "flat": flat.map,
        "plain": plain.map
      };
}
