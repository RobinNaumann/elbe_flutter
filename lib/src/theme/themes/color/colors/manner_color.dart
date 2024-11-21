import 'package:elbe/src/theme/themes/color/color_seed.dart';
import 'package:elbe/src/theme/themes/color/colors/layer_color.dart';
import 'package:elbe/src/theme/themes/color/colors/state_color.dart';

/// each `KindColor` can be in one of these states
/// - `major` is the most visually prominent state
/// - `minor` is a less visually prominent state
/// - `flat` is the least visually prominent state. It has no background
enum ColorManners { major, minor, flat }

class MannerColor extends StateColor {
  final StateColor? major;
  final StateColor? minor;
  final StateColor flat;

  /// major might not be set (if using `plain`). In this case,
  /// this getter will return `flat`
  StateColor get safeMajor => major ?? flat;

  /// minor might not be set (if using `plain`). In this case,
  /// this getter will return `flat`
  StateColor get safeMinor => minor ?? flat;

  MannerColor({required this.major, required this.minor, required this.flat})
      : super.from(major ?? flat);

  MannerColor.from(StateColor c) : this(major: c, minor: c, flat: c);

  StateColor manner(ColorManners manner) =>
      [major ?? flat, minor ?? flat, flat][manner.index];

  StateColor? maybeManner(ColorManners? manner) =>
      manner != null ? this.manner(manner) : null;

  factory MannerColor.generate(ColorSeed s, LayerColor c,
          [LayerColor? style]) =>
      MannerColor(
          major: style != null
              ? StateColor.generate(s, c, s.variant.major(s, c, style))
              : null,
          minor: style != null
              ? StateColor.generate(s, c, s.variant.minor(s, c, style))
              : null,
          flat: StateColor.generate(s, c, s.variant.flat(s, c, style), true));

  @override
  get map => {"major": major?.map, "minor": minor?.map, "flat": flat.map};
}
