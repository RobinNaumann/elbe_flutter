import '../../../../elbe.dart';
import '../../util/inherited_theme.dart';
import 'package:flutter/material.dart' as m;

class ColorThemeData extends ElbeInheritedThemeData {
  final ColorModes mode;
  final ColorSchemes scheme;
  final ColorStyles? style;
  final ColorStates? state;

  final ColorMode data;

  LayerColor resolve(
          {ColorModes? mode,
          ColorSchemes? scheme,
          ColorStyles? style,
          ColorStates? state}) =>
      data
          .mode(mode ?? this.mode)
          .scheme(scheme ?? this.scheme)
          .style(style ?? this.style ?? ColorStyles.plain)
          .state(state ?? this.state ?? ColorStates.neutral);

  ColorScheme get activeMode => data.mode(mode);
  ColorStyle get activeScheme => activeMode.scheme(scheme);
  StateColor get activeStyle =>
      style != null ? activeScheme.style(style!) : activeScheme.plain;
  LayerColor get activeLayer =>
      state != null ? activeStyle.state(state!) : activeStyle.neutral;

  const ColorThemeData(
      {required this.data,
      this.mode = ColorModes.light,
      this.scheme = ColorSchemes.primary,
      this.style,
      this.state});

  ColorThemeData copyWith(
          {ColorMode? data,
          ColorModes? mode,
          ColorSchemes? scheme,
          ColorStyles? style,
          ColorStates? state}) =>
      ColorThemeData(
          data: data ?? this.data,
          mode: mode ?? this.mode,
          scheme: scheme ?? this.scheme,
          style: style ?? this.style,
          state: state ?? this.state);

  factory ColorThemeData.fromColor(
          {required Color accent,
          ColorModes? mode,
          ColorSchemes scheme = ColorSchemes.primary}) =>
      ColorThemeData(
          data: ColorMode.fromColor(accent: accent),
          mode: mode ?? ColorModes.fromPlatform,
          scheme: scheme);

  @override
  getProps() => [data, mode, scheme, style, state];

  @override
  Widget provider(Widget child) => ColorTheme(data: this, child: child);

  m.ColorScheme asMaterial() => m.ColorScheme(
      brightness: mode.isLight ? m.Brightness.light : m.Brightness.dark,
      primary: activeScheme.majorAccent,
      onPrimary: activeScheme.majorAccent.front,
      secondary: activeScheme.minorAccent,
      onSecondary: activeScheme.minorAccent.front,
      surface: activeLayer,
      onSurface: activeLayer.front,
      background: activeLayer,
      onBackground: activeLayer.front,
      error: activeScheme.majorAlertError,
      onError: activeScheme.majorAlertError.front);
}
