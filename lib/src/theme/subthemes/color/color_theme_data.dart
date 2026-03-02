import 'package:elbe/elbe.dart';
import 'package:flutter/material.dart' as m;

export 'colors/contrast_color.dart';
export 'colors/kind_color.dart';
export 'colors/layer_color.dart';
export 'colors/manner_color.dart';
export 'colors/mode_color.dart';
export 'colors/rich_color.dart';
export 'colors/scheme_color.dart';
export 'colors/state_color.dart';

class ColorDefs {
  static const transparent = Color.fromARGB(0, 0, 0, 0);
  static const white = Color.fromARGB(255, 255, 255, 255);
  static const black = Color.fromARGB(255, 0, 0, 0);
  static const blueAccent = Color.fromARGB(255, 60, 119, 246);
  static const blue = Color.fromARGB(255, 32, 89, 153);
  static const green = Color.fromARGB(255, 35, 144, 78);
  static const yellow = Color.fromARGB(255, 240, 221, 21);
  static const red = Color.fromARGB(255, 243, 67, 67);
  static const magenta = Color.fromARGB(255, 255, 0, 255);
}

typedef SeedSelector = LayerColor Function(
    List<String> path, ColorThemeSeed seed, LayerColor base, LayerColor? style);

typedef SeedModifier = ColorThemeSeed Function(
    List<String> path, ColorThemeSeed seed, LayerColor base);

class ColorThemeSelection extends JsonModel {
  final ColorContrasts contrast;
  final ColorModes mode;
  final ColorSchemes scheme;
  final ColorKinds kind;
  final ColorManners manner;
  final ColorStates state;

  const ColorThemeSelection(
      {this.contrast = ColorContrasts.normal,
      this.mode = ColorModes.light,
      this.scheme = ColorSchemes.primary,
      this.kind = ColorKinds.accent,
      this.manner = ColorManners.plain,
      this.state = ColorStates.neutral});

  ColorThemeSelection copyWith(
          {ColorContrasts? contrast,
          ColorModes? mode,
          ColorSchemes? scheme,
          ColorKinds? kind,
          ColorManners? manner,
          ColorStates? state}) =>
      ColorThemeSelection(
          contrast: contrast ?? this.contrast,
          mode: mode ?? this.mode,
          scheme: scheme ?? this.scheme,
          kind: kind ?? this.kind,
          manner: manner ?? this.manner,
          state: state ?? this.state);

  LayerColor apply(ContrastColor color) => color
      .contrast(contrast)
      .mode(mode)
      .scheme(scheme)
      .kind(kind)
      .manner(manner)
      .state(state);

  @override
  get map => {
        "contrast": contrast.name,
        "mode": mode.name,
        "scheme": scheme.name,
        "kind": kind.name,
        "manner": manner.name
      };
}

class ColorThemeSelectors extends JsonModel {
  final ContrastColorSeed contrast;
  final ModeColorSeed mode;
  final SchemeColorSeed scheme;
  final KindColorSeed kind;
  final MannerColorSeed manner;

  ColorThemeSelectors({
    ContrastColorSeed? contrast,
    ModeColorSeed? mode,
    SchemeColorSeed? scheme,
    KindColorSeed? kind,
    MannerColorSeed? manner,
  })  : this.contrast = contrast ?? ContrastColorSeed(),
        this.mode = mode ?? ModeColorSeed(),
        this.scheme = scheme ?? SchemeColorSeed(),
        this.kind = kind ?? KindColorSeed(),
        this.manner = manner ?? MannerColorSeed();

  @override
  get map => {
        "contrast": contrast.toString(),
        "mode": mode.toString(),
        "scheme": scheme.toString(),
        "kind": kind.toString(),
        "manner": manner.toString()
      };
}

class ColorThemeValues extends JsonModel {
  final LayerColor base;
  final LayerColor accent;
  final LayerColor info;
  final LayerColor success;
  final LayerColor warning;
  final LayerColor error;

  const ColorThemeValues({
    this.base = const LayerColor(back: ColorDefs.white, front: ColorDefs.black),
    this.accent =
        const LayerColor(back: ColorDefs.blue, front: ColorDefs.white),
    this.info =
        const LayerColor(back: ColorDefs.blueAccent, front: ColorDefs.white),
    this.success =
        const LayerColor(back: ColorDefs.green, front: ColorDefs.white),
    this.warning =
        const LayerColor(back: ColorDefs.yellow, front: ColorDefs.black),
    this.error = const LayerColor(back: ColorDefs.red, front: ColorDefs.white),
  });

  ColorThemeValues copyWith({
    LayerColor? base,
    LayerColor? accent,
    LayerColor? info,
    LayerColor? success,
    LayerColor? warning,
    LayerColor? error,
  }) {
    return ColorThemeValues(
        base: base ?? this.base,
        accent: accent ?? this.accent,
        info: info ?? this.info,
        success: success ?? this.success,
        warning: warning ?? this.warning,
        error: error ?? this.error);
  }

  @override
  get map => {
        "base": base.map,
        "accent": accent.map,
        "info": info.map,
        "success": success.map,
        "warning": warning.map,
        "error": error.map
      };
}

class ColorThemeSeed extends JsonModel {
  final ColorThemeSelectors selectors;
  final ColorThemeValues values;

  ColorThemeSeed(this.selectors, this.values);

  ColorThemeSeed copyWith({
    ColorThemeSelectors? selectors,
    ColorThemeValues? values,
  }) {
    return ColorThemeSeed(selectors ?? this.selectors, values ?? this.values);
  }

  @override
  get map => {"selectors": selectors.map, "values": values.map};
}

class ColorThemeData extends JsonModel {
  // config
  final ColorThemeValues values;
  final ColorThemeSelection selection;
  late final LayerColor selected;
  late final ColorThemeSelectors _selectors;
  late final ContrastColor hierarchy;

  ColorThemeData.preset({
    this.values = const ColorThemeValues(),
    this.selection = const ColorThemeSelection(),
    ColorThemeSelectors? selectors,
    ContrastColor? hierarchy,
  }) {
    this._selectors = selectors ?? ColorThemeSelectors();
    this.hierarchy = hierarchy ??
        ContrastColor.generate(
            [], ColorThemeSeed(this._selectors, this.values));
    this.selected = resolve();
  }

  /// shorthand for selection.constrast.isHighVis
  bool get isHighVis => selection.contrast.isHighVis;

  /// shorthand for selection.mode.isDark
  bool get isDark => selection.mode.isDark;

  /// get the currently selected color
  LayerColor resolve(
      {ColorContrasts? contrast,
      ColorModes? mode,
      ColorSchemes? scheme,
      ColorKinds? kind,
      ColorManners? manner,
      ColorStates? state}) {
    try {
      return selection
          .copyWith(
              contrast: contrast,
              mode: mode,
              scheme: scheme,
              kind: kind,
              manner: manner,
              state: state)
          .apply(hierarchy);
    } catch (e) {
      debugPrint("Error parsing color: $e");
      return LayerColor.fromBack(ColorDefs.magenta);
    }
  }

  ColorThemeData withSelection(
    ColorThemeSelection selection,
  ) =>
      ColorThemeData.preset(
        values: this.values,
        selection: selection,
        selectors: this._selectors,
        hierarchy: this.hierarchy,
      );

  /*ColorThemeData withValues(
    ColorThemeValues values,
  ) =>
      ColorThemeData.preset(
        values: values,
        selection: this.selection,
        selectors: this._selectors,
      );*/

  m.ColorScheme asMaterialTheme() {
    final schemes = this
        .hierarchy
        .contrast(this.selection.contrast)
        .mode(this.selection.mode);

    return m.ColorScheme(
        brightness: this.isDark ? m.Brightness.dark : m.Brightness.light,
        primary: schemes.primary.accent.plain.back,
        onPrimary: schemes.primary.accent.plain.front,
        secondary: schemes.secondary.accent.plain.back,
        onSecondary: schemes.secondary.accent.plain.front,
        surface: schemes.primary.accent.plain.back,
        onSurface: schemes.primary.accent.plain.front,
        error: schemes.primary.error.major.back,
        onError: schemes.primary.error.major.front);
  }

  @override
  get map => {
        "values": values.map,
        "selection": selection.map,
        "selectors": hierarchy.map,
      };
}
