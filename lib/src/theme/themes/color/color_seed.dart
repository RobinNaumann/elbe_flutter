import 'package:elbe/src/theme/themes/color/colors/rich_color.dart';
import 'package:flutter/material.dart';

import 'colors/layer_color.dart';

class ColorDefs {
  static final transparent = Color.fromARGB(0, 0, 0, 0);
  static final white = Color.fromARGB(255, 255, 255, 255);
  static final black = Color.fromARGB(255, 0, 0, 0);
  static final blueAccent = Color.fromARGB(255, 60, 119, 246);
  static final blue = Color.fromARGB(255, 32, 89, 153);
  static final green = Color.fromARGB(255, 35, 144, 78);
  static final yellow = Color.fromARGB(255, 240, 221, 21);
  static final red = Color.fromARGB(255, 243, 67, 67);
}

typedef SeedSelector = LayerColor Function(ColorSeed seed, LayerColor base);
typedef SeedFlatSelector = LayerColor Function(
    ColorSeed seed, LayerColor base, LayerColor? style);
typedef SeedStyleSelector = LayerColor Function(
    ColorSeed seed, LayerColor base, LayerColor style);

class ColorSeed {
  final LayerColor base;
  final LayerColor accent;
  final LayerColor info;
  final LayerColor success;
  final LayerColor warning;
  final LayerColor error;

  final ColorModeSeed mode;
  final ColorSchemeSeed scheme;
  final ColorStyleSeed style;
  final ColorVariantSeed variant;

  /// create a color seed with the given values. For easier creation, use the
  /// `ColorSeed.make` constructor.
  const ColorSeed({
    required this.base,
    required this.accent,
    required this.info,
    required this.success,
    required this.warning,
    required this.error,
    required this.mode,
    required this.scheme,
    required this.style,
    required this.variant,
  });

  ColorSeed.make({
    LayerColor? base,
    LayerColor? accent,
    LayerColor? info,
    LayerColor? success,
    LayerColor? warning,
    LayerColor? error,
    ColorModeSeed? mode,
    ColorSchemeSeed? scheme,
    ColorStyleSeed? style,
    ColorVariantSeed? variant,
  }) : this(
          base: base ?? LayerColor.fromBack(ColorDefs.white),
          accent: accent ?? LayerColor.fromBack(ColorDefs.blueAccent),
          info: info ?? LayerColor.fromBack(ColorDefs.blue),
          success: success ?? LayerColor.fromBack(ColorDefs.green),
          warning: warning ?? LayerColor.fromBack(ColorDefs.yellow),
          error: error ?? LayerColor.fromBack(ColorDefs.red),
          mode: mode ?? ColorModeSeed.make(),
          scheme: scheme ?? ColorSchemeSeed.make(),
          style: style ?? ColorStyleSeed.make(),
          variant: variant ?? ColorVariantSeed.make(),
        );
}

class ColorModeSeed {
  final SeedSelector light;
  final SeedSelector dark;

  const ColorModeSeed({
    required this.light,
    required this.dark,
  });

  ColorModeSeed.make({
    SeedSelector? light,
    SeedSelector? dark,
  }) : this(
          light: light ?? (seed, base) => base,
          dark: dark ?? (seed, base) => base.mirrorBrightness(),
        );
}

class ColorSchemeSeed {
  final SeedSelector primary;
  final SeedSelector secondary;
  final SeedSelector inverse;

  /// create a color scheme seed with the given values.
  /// For easier creation, use the `ColorSchemeSeed.make` constructor.
  const ColorSchemeSeed({
    required this.primary,
    required this.secondary,
    required this.inverse,
  });

  ColorSchemeSeed.make({
    SeedSelector? primary,
    SeedSelector? secondary,
    SeedSelector? inverse,
  }) : this(
          primary: primary ?? (_, base) => base,
          secondary: secondary ??
              ((seed, base) => LayerColor(
                  back: base.back.inter(seed.accent.back, .1).desaturated(.3),
                  front: base.front,
                  border: base.border)),
          inverse: inverse ?? (_, base) => base.mirrorBrightness(),
        );
}

class ColorStyleSeed {
  final SeedStyleSelector accent;
  final SeedStyleSelector info;
  final SeedStyleSelector success;
  final SeedStyleSelector warning;
  final SeedStyleSelector error;

  static SeedStyleSelector _styleSel = (seed, base, style) =>
      (base.luminance == 1)
          ? style
          : style.inter(
              LayerColor.fromBack(
                  base.luminance > 0.5 ? Colors.black : Colors.white,
                  border: Colors.green),
              0.1);

  /// create a color style seed with the given values.
  /// For easier creation, use the `ColorStyleSeed.make` constructor.
  const ColorStyleSeed({
    required this.accent,
    required this.info,
    required this.success,
    required this.warning,
    required this.error,
  });

  ColorStyleSeed.make({
    SeedStyleSelector? accent,
    SeedStyleSelector? info,
    SeedStyleSelector? success,
    SeedStyleSelector? warning,
    SeedStyleSelector? error,
  }) : this(
          accent: accent ?? _styleSel,
          info: info ?? _styleSel,
          success: success ?? _styleSel,
          warning: warning ?? _styleSel,
          error: error ?? _styleSel,
        );
}

class ColorVariantSeed {
  final SeedStyleSelector major;
  final SeedStyleSelector minor;
  final SeedFlatSelector flat;

  /// create a color variant seed with the given values.
  /// For easier creation, use the `ColorVariantSeed.make` constructor.
  const ColorVariantSeed({
    required this.major,
    required this.minor,
    required this.flat,
  });

  ColorVariantSeed.make({
    SeedStyleSelector? major,
    SeedStyleSelector? minor,
    SeedFlatSelector? flat,
  }) : this(
            major: major ?? (_, __, s) => s,
            minor: minor ??
                ((_, b, s) {
                  final back = b.back;
                  final backIn = back.mirrorBrightness();
                  final major = s.back;
                  final minor = s.back.inter(back, 0.8);
                  final minorFront =
                      minor.hasWCAGContrast(major) ? major : null;
                  return new LayerColor(
                      back: s.back.withOpacity(0.25),
                      front: minorFront ?? major.inter(backIn, 0.6),
                      border: minorFront ?? major.inter(backIn, 0.3));
                  //border: minorFront ?? major.inter(backIn, 0.3));
                }),
            flat: flat ??
                ((_, b, s) {
                  final front = s == null
                      ? b.front
                      : b.back.hasWCAGContrast(s.back)
                          ? s.back
                          : s.back.inter(b.front, 0.6);
                  print("making flat theme");
                  return LayerColor(
                      back: b.back,
                      front: front,
                      border: b.border ??
                          b.front.inter(b.back, .9).desaturated(-.5),
                      borderContext:
                          s == null ? b.front.withOpacity(0.3) : b.front);
                }));
}
