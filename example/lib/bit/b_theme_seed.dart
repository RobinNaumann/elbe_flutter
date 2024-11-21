import 'package:elbe/elbe.dart';

class SeedData {
  final Color accent;
  final ColorModes mode;
  final double borderRadius;
  final double borderWidth;
  final String? font;

  SeedData(
      {required this.accent,
      required this.mode,
      required this.borderRadius,
      required this.borderWidth,
      required this.font});
}

const accentColors = [
  Color(0xFF3c77f6),
  Color(0xFF04395e),
  Color(0xFF38a3a5),
  Color(0xFF70a288),
  Color(0xFFd5896f),
  Color(0xFFf77f00),
  Color(0xFFd62828)
];

const headerFonts = [
  "Calistoga",
  //"Delius",
  "Space Grotesk",
  "Astloch",
  "Atkinson Hyperlegible"
];

class ThemeSeedBit extends MapMsgBitControl<SeedData> {
  static const builder = MapMsgBitBuilder<SeedData, ThemeSeedBit>.make;

  ThemeSeedBit()
      : super.worker((_) async => SeedData(
              accent: accentColors.first,
              mode: ColorModes.light,
              borderRadius: 10.0,
              borderWidth: 2.0,
              font: headerFonts.first,
            ));

  void set(
          {Color? primary,
          ColorModes? mode,
          double? borderRadius,
          double? borderWidth,
          Opt<String> font}) =>
      act((d) => SeedData(
          accent: primary ?? d.accent,
          mode: mode ?? d.mode,
          borderRadius: borderRadius ?? d.borderRadius,
          borderWidth: borderWidth ?? d.borderWidth,
          font: optEval(font, d.font)));

  void toggle() => state.whenData(
      (d) => set(mode: d.mode.isDark ? ColorModes.light : ColorModes.dark));
}
