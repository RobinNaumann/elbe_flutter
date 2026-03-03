import 'package:flutter/widgets.dart' as w;

import '../../../elbe.dart';

/// use *WBorder* to use the default Flutter Border widget
class Border {
  final double? width;
  final BorderStyle? style;
  final double? strokeAlign;
  final Color? color;

  /// This is the elbe border. Use `WBorder` for the Flutter border. You can
  /// also use the `toDeco` method to convert this border to a `BoxDecoration`.
  ///
  /// Use this to define a border for widgets like `Box` or `Card`.
  const Border({this.width, this.style, this.color, this.strokeAlign});

  const Border._(
      {required this.width,
      required this.style,
      required this.color,
      required this.strokeAlign});

  // returns a border with the current values.
  // It will try to retrieve the information from the context
  w.Border resolved(ElbeThemeData t) {
    final resolvedWidth = width ?? t.geometry.rem(t.geometry.borderWidth);
    return w.Border.all(
        color: resolvedWidth > 0
            ? color ?? t.color.selected.border ?? Colors.transparent
            : Colors.transparent,
        width: resolvedWidth,
        style: style ?? t.geometry.borderStyle,
        strokeAlign: strokeAlign ?? t.geometry.borderAlign);
  }

  Border copyWith(
          {double? width,
          BorderStyle? style,
          double? strokeAlign,
          Color? color}) =>
      Border(
          width: width ?? this.width,
          style: style ?? this.style,
          strokeAlign: strokeAlign ?? this.strokeAlign,
          color: color ?? this.color);
}

/// Insets in rem units. Works analogously to `EdgeInsets` but in rem units.
class RemInsets {
  /// add no space
  static const RemInsets zero = RemInsets.all(0);

  final double left;
  final double top;
  final double right;
  final double bottom;

  /// define each side of the insets separately
  const RemInsets(
      {this.left = 0, this.top = 0, this.right = 0, this.bottom = 0});

  /// apply the same value to all sides. Define this through [value]
  const RemInsets.all(double value)
      : left = value,
        right = value,
        top = value,
        bottom = value;

  /// apply different values to each side. Define this through [left], [top],
  /// [right], and [bottom]
  const RemInsets.fromLTRB(this.left, this.top, this.right, this.bottom);

  /// apply the same value to the vertical and horizontal sides. Define this
  /// through [horizontal] and [vertical]
  const RemInsets.symmetric({double horizontal = 0, double vertical = 0})
      : left = horizontal,
        right = horizontal,
        top = vertical,
        bottom = vertical;

  /// when using widgets from other libraries, you might need to convert the
  /// rem units to pixels. Use this method to do so.
  EdgeInsets toPixel(BuildContext context) {
    final rem = context.theme.geometry.rem;
    return EdgeInsets.fromLTRB(rem(left), rem(top), rem(right), rem(bottom));
  }
}
