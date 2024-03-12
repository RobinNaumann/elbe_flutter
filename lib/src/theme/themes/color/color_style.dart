import 'dart:ui';

import '../../../../elbe.dart';

const Color grey = Color(0xFF808080);

extension _Fract on double {
  // ignore: unnecessary_this
  double get norm => this.clamp(0.0, 1.0);
}

extension _Clamp on int {
  bool absBetween(int a, int b) => abs() >= a && abs() < b;
}

extension RichColor on Color {
  bool get isBright => brightness >= 0.5;

  /// whether the color is close to being grey
  bool get isMinorColored =>
      (red - green).absBetween(20, 50) ||
      (red - blue).absBetween(20, 50) ||
      (green - blue).absBetween(20, 50);
  double get brightness => computeLuminance();

  Color facM(double fac) {
    final hsl = HSLColor.fromColor(this);
    final l = hsl.lightness;
    return hsl.withLightness((l - (l - 0.5) * 2 * fac).norm).toColor();
  }

  Color interAll(double factor, [Color color = grey]) => Color.fromARGB(
      255,
      (red + (color.red - red) * factor).round().clamp(0, 255),
      (green + (color.green - green) * factor).round().clamp(0, 255),
      (blue + (color.blue - blue) * factor).round().clamp(0, 255));

  Color inter(double factor, [Color color = grey]) {
    var hsl = HSLColor.fromColor(this);
    if (hsl.lightness == 0 || hsl.lightness == 1) hsl = hsl.withSaturation(0);
    final lC = HSLColor.fromColor(color).lightness;
    final l = hsl.lightness;
    final nl = (l + (lC - l) * factor);
    return hsl.withLightness(nl.norm).toColor();
  }

  Color fac(double factor) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness((hsl.lightness * factor).norm).toColor();
  }

  Color get desaturated => HSLColor.fromColor(this).withSaturation(0).toColor();
}

abstract class _JsonColor extends Color {
  Map<String, dynamic> get map;

  _JsonColor.from(Color c) : super(c.value);

  @override
  String toString() => "$runtimeType$map";

  @override
  int get hashCode => toString().hashCode;

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;
}

class LayerColor extends _JsonColor {
  final Color back;
  final Color front;
  final Color border;

  LayerColor.from(LayerColor c)
      : this(back: c.back, front: c.front, border: c.border);

  LayerColor({required this.back, required this.front, required this.border})
      : super.from(back);

  factory LayerColor.fromColor(
          {required Color back, Color? front, Color? border}) =>
      LayerColor(
          back: back,
          front: back.isMinorColored
              ? back.inter(1.4)
              : front ?? (back.isBright ? Colors.black : Colors.white),
          border: border ?? back.inter(0.4));

  @override
  get map => {"back": back, "front": front, "border": border};
}

enum ColorStates { neutral, hovered, pressed, disabled }

class StateColor extends LayerColor {
  final LayerColor neutral;
  final LayerColor hovered;
  final LayerColor pressed;
  final LayerColor disabled;

  StateColor.from(StateColor c)
      : this(
            neutral: c.neutral,
            hovered: c.hovered,
            pressed: c.pressed,
            disabled: c.disabled);

  StateColor(
      {required this.neutral,
      required this.hovered,
      required this.pressed,
      required this.disabled})
      : super.from(neutral);

  factory StateColor.fromColor(
      {required Color neutral,
      Color? hovered,
      Color? pressed,
      Color? disabled}) {
    final LayerColor? nlk = (neutral is LayerColor) ? neutral : null;
    final dis = neutral.fac(2.2).desaturated;
    final disFront = (dis.isBright ? Colors.black : Colors.white).inter(1.1);
    return StateColor(
        neutral: nlk ?? LayerColor.fromColor(back: neutral),
        hovered: (hovered is LayerColor)
            ? hovered
            : LayerColor.fromColor(
                back: hovered ?? neutral.inter(0.2),
                front: nlk?.front.fac(0.9)),
        pressed: (pressed is LayerColor)
            ? pressed
            : LayerColor.fromColor(
                back: pressed ?? neutral.inter(0.4),
                front: nlk?.front.fac(0.7)),
        disabled: (disabled is LayerColor)
            ? disabled
            : (disabled != null)
                ? LayerColor.fromColor(back: disabled)
                : LayerColor.fromColor(
                    back: dis, front: nlk?.front.desaturated ?? disFront));
  }

  LayerColor? maybeState(ColorStates? state) =>
      state != null ? this.state(state) : null;

  LayerColor state(ColorStates state) =>
      [neutral, hovered, pressed, disabled][state.index];

  StateColor copyWith(
          {LayerColor? neutral,
          LayerColor? hovered,
          LayerColor? pressed,
          LayerColor? disabled}) =>
      StateColor(
          neutral: neutral ?? this.neutral,
          hovered: hovered ?? this.hovered,
          pressed: pressed ?? this.pressed,
          disabled: disabled ?? this.disabled);

  @override
  get map => {
        "neutral": neutral,
        "hovered": hovered,
        "pressed": pressed,
        "disabled": disabled
      };
}

enum ColorStyles {
  plain,
  action,
  actionIntegrated,
  minorAccent,
  majorAccent,
  minorAlertError,
  majorAlertError,
  minorAlertWarning,
  majorAlertWarning,
  minorAlertSuccess,
  majorAlertSuccess,
  minorAlertInfo,
  majorAlertInfo
}

class ColorStyle extends StateColor {
  static const colorError = Color(0xFFF34343);
  static const colorWarning = Color.fromARGB(255, 240, 221, 23);
  static const colorSuccess = Color(0xFF29AC5E);
  static const colorInfo = Color(0xFF2463AA);

  final StateColor plain;
  final StateColor action;
  final StateColor actionIntegrated;
  final StateColor minorAccent;
  final StateColor majorAccent;
  final StateColor minorAlertError;
  final StateColor majorAlertError;
  final StateColor minorAlertWarning;
  final StateColor majorAlertWarning;
  final StateColor minorAlertSuccess;
  final StateColor majorAlertSuccess;
  final StateColor minorAlertInfo;
  final StateColor majorAlertInfo;

  ColorStyle.from(ColorStyle c)
      : this(
            plain: c.plain,
            action: c.action,
            actionIntegrated: c.actionIntegrated,
            minorAccent: c.minorAccent,
            majorAccent: c.majorAccent,
            minorAlertError: c.minorAlertError,
            majorAlertError: c.majorAlertError,
            minorAlertWarning: c.minorAlertWarning,
            majorAlertWarning: c.majorAlertWarning,
            minorAlertSuccess: c.minorAlertSuccess,
            majorAlertSuccess: c.majorAlertSuccess,
            minorAlertInfo: c.minorAlertInfo,
            majorAlertInfo: c.majorAlertInfo);

  ColorStyle(
      {required this.plain,
      required this.action,
      required this.actionIntegrated,
      required this.minorAccent,
      required this.majorAccent,
      required this.minorAlertError,
      required this.majorAlertError,
      required this.minorAlertWarning,
      required this.majorAlertWarning,
      required this.minorAlertSuccess,
      required this.majorAlertSuccess,
      required this.minorAlertInfo,
      required this.majorAlertInfo})
      : super.from(plain);

  factory ColorStyle.fromColor(
      {required Color base,
      required Color accent,
      StateColor? plain,
      StateColor? action,
      StateColor? actionIntegrated,
      StateColor? minorAccent,
      StateColor? majorAccent,
      StateColor? minorAlertError,
      StateColor? majorAlertError,
      StateColor? minorAlertWarning,
      StateColor? majorAlertWarning,
      StateColor? minorAlertSuccess,
      StateColor? majorAlertSuccess,
      StateColor? minorAlertInfo,
      StateColor? majorAlertInfo}) {
    const mF = 0.8;

    final transparent = base.withAlpha(0);

    return ColorStyle(
        plain: plain ?? StateColor.fromColor(neutral: base),
        action: action ??
            StateColor.fromColor(
                neutral:
                    LayerColor.fromColor(back: transparent, front: accent)),
        actionIntegrated:
            actionIntegrated ?? StateColor.fromColor(neutral: transparent),
        minorAccent: minorAccent ??
            StateColor.fromColor(neutral: accent.inter(mF, base)),
        majorAccent: majorAccent ??
            StateColor.fromColor(
                neutral: LayerColor(
                    back: accent,
                    front: (accent.isBright ? Colors.black : Colors.white),
                    border: transparent),
                disabled: LayerColor.fromColor(
                    back: base.inter(0.3), front: base.inter(1.3))),
        minorAlertError: minorAlertError ??
            StateColor.fromColor(neutral: colorError.inter(mF, base)),
        majorAlertError:
            majorAlertError ?? StateColor.fromColor(neutral: colorError),
        minorAlertWarning: minorAlertWarning ??
            StateColor.fromColor(neutral: colorWarning.inter(mF, base)),
        majorAlertWarning:
            majorAlertWarning ?? StateColor.fromColor(neutral: colorWarning),
        minorAlertSuccess: minorAlertSuccess ??
            StateColor.fromColor(neutral: colorSuccess.inter(mF, base)),
        majorAlertSuccess:
            majorAlertSuccess ?? StateColor.fromColor(neutral: colorSuccess),
        minorAlertInfo: minorAlertInfo ??
            StateColor.fromColor(neutral: colorInfo.inter(mF, base)),
        majorAlertInfo:
            minorAlertInfo ?? StateColor.fromColor(neutral: colorInfo));
  }

  StateColor? maybeStyle(ColorStyles? s) => s != null ? style(s) : null;

  StateColor style(ColorStyles s) => [
        plain,
        action,
        actionIntegrated,
        minorAccent,
        majorAccent,
        minorAlertError,
        majorAlertError,
        minorAlertWarning,
        majorAlertWarning,
        minorAlertSuccess,
        majorAlertSuccess,
        minorAlertInfo,
        majorAlertInfo
      ][s.index];

  @override
  get map => {
        "plain": plain,
        "action": action,
        "actionIntegrated": actionIntegrated,
        "minorAccent": minorAccent,
        "majorAccent": majorAccent,
        "minorAlertError": minorAlertError,
        "majorAlertError": majorAlertError,
        "minorAlertWarning": minorAlertWarning,
        "majorAlertWarning": majorAlertWarning,
        "majorAlertSuccess": majorAlertSuccess,
        "minorAlertSuccess": minorAlertSuccess,
        "minorAlertInfo": minorAlertInfo,
        "majorAlertInfo": majorAlertInfo
      };
}

class ColorScheme extends ColorStyle {
  final ColorStyle primary;
  final ColorStyle secondary;
  final ColorStyle inverse;

  ColorScheme.from(ColorScheme c)
      : this(primary: c.primary, secondary: c.secondary, inverse: c.inverse);

  ColorScheme(
      {required this.primary, required this.secondary, required this.inverse})
      : super.from(primary);

  factory ColorScheme.fromColor(
          {required Color accent,
          required Color background,
          ColorStyle? primary,
          ColorStyle? secondary,
          ColorStyle? inverse}) =>
      ColorScheme(
          primary:
              primary ?? ColorStyle.fromColor(base: background, accent: accent),
          secondary: secondary ??
              ColorStyle.fromColor(
                  base: background.interAll(0.07, accent),
                  accent: accent.inter(0.1)),
          inverse: inverse ??
              ColorStyle.fromColor(accent: accent, base: background.inter(2)));

  ColorStyle scheme(ColorSchemes s) => [primary, secondary, inverse][s.index];

  @override
  get map => {"primary": primary, "secondary": secondary, "inverse": inverse};
}

enum ColorSchemes {
  primary,
  secondary,
  inverse;

  bool get isPrimary => this == ColorSchemes.primary;
  bool get isSecondary => this == ColorSchemes.secondary;
  bool get isInverse => this == ColorSchemes.inverse;
}

enum ColorModes {
  light,
  dark;

  /// get the currently active mode on the device
  static ColorModes get fromPlatform =>
      PlatformDispatcher.instance.platformBrightness == Brightness.light
          ? ColorModes.light
          : ColorModes.dark;

  bool get isLight => this == ColorModes.light;
  bool get isDark => this == ColorModes.dark;
}

class ColorMode extends ColorScheme {
  final ColorScheme light;
  final ColorScheme dark;

  ColorMode.from(ColorMode c) : this(light: c.light, dark: c.dark);

  ColorMode({required this.light, required this.dark}) : super.from(light);

  factory ColorMode.fromColor({required Color accent}) => ColorMode(
      light: ColorScheme.fromColor(accent: accent, background: Colors.white),
      dark: ColorScheme.fromColor(accent: accent, background: Colors.black));

  ColorScheme mode(ColorModes m) => [light, dark][m.index];

  @override
  get map => {"light": light, "dark": dark};
}
