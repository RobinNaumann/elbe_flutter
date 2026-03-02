import 'package:elbe/elbe.dart';

class KindColorSeed {
  late final SeedSelector accent;
  late final SeedSelector info;
  late final SeedSelector success;
  late final SeedSelector warning;
  late final SeedSelector error;

  KindColorSeed({
    SeedSelector? accent,
    SeedSelector? info,
    SeedSelector? success,
    SeedSelector? warning,
    SeedSelector? error,
  }) {
    this.accent = accent ??
        ((_, seed, base, __) => _kindSelector(base, seed.values.accent));
    this.info =
        info ?? ((_, seed, base, __) => _kindSelector(base, seed.values.info));
    this.success = success ??
        ((_, seed, base, __) => _kindSelector(base, seed.values.success));
    this.warning = warning ??
        ((_, seed, base, __) => _kindSelector(base, seed.values.warning));
    this.error = error ??
        ((_, seed, base, __) => _kindSelector(base, seed.values.error));
  }

  static LayerColor _kindSelector(LayerColor base, LayerColor? style) {
    if (style == null) return base;
    final bL = base.back.luminance;

    if (bL == 1) return style;
    if (style.back.luminance == 0) return style.mirrorBrightness();
    return style.inter(
        LayerColor.fromBack(bL > 0.5 ? ColorDefs.black : ColorDefs.white), 0.1);
  }
}

/// these are the different main types of colors that can be used in the app
enum ColorKinds {
  accent(Icons.info),
  info(Icons.info),
  success(Icons.alertTriangle),
  warning(Icons.alertTriangle),
  error(Icons.xOctagon);

  const ColorKinds(this.icon);
  final IconData icon;
}

class KindColor extends MannerColor {
  final MannerColor accent;
  final MannerColor info;
  final MannerColor success;
  final MannerColor warning;
  final MannerColor error;

  KindColor(
      {required this.accent,
      required this.info,
      required this.success,
      required this.warning,
      required this.error})
      : super.from(accent);

  KindColor.from(KindColor c)
      : this(
            accent: c.accent,
            info: c.info,
            success: c.success,
            warning: c.warning,
            error: c.error);

  MannerColor kind(ColorKinds kind) =>
      [accent, info, success, warning, error][kind.index];

  factory KindColor.generate(
          List<String> path, ColorThemeSeed seed, LayerColor base) =>
      KindColor(
        accent: MannerColor.generate([...path, "accent"], seed, base,
            seed.selectors.kind.accent([...path, "accent"], seed, base, null)),
        info: MannerColor.generate([...path, "info"], seed, base,
            seed.selectors.kind.info([...path, "info"], seed, base, null)),
        success: MannerColor.generate(
            [...path, "success"],
            seed,
            base,
            seed.selectors.kind
                .success([...path, "success"], seed, base, null)),
        warning: MannerColor.generate(
            [...path, "warning"],
            seed,
            base,
            seed.selectors.kind
                .warning([...path, "warning"], seed, base, null)),
        error: MannerColor.generate([...path, "error"], seed, base,
            seed.selectors.kind.error([...path, "error"], seed, base, null)),
      );

  @override
  get map => {
        "accent": accent.map,
        "info": info.map,
        "success": success.map,
        "warning": warning.map,
        "error": error.map
      };
}
