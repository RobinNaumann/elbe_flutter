import 'package:flutter/widgets.dart' as w;

import '../../../elbe.dart';

/// use *WText* to use the default Flutter Text widget
class Border {
  static const Border none =
      Border(pixelWidth: 0, color: Colors.transparent, borderRadius: null);
  static const Border noneRect = Border(
      pixelWidth: 0,
      color: Colors.transparent,
      borderRadius: BorderRadius.zero);

  final double? pixelWidth;
  final BorderStyle? style;
  final double? strokeAlign;
  final Color? color;
  final BorderRadius? borderRadius;

  /// This is the elbe border. Use `WBorder` for the Flutter border. You can
  /// also use the `toDeco` method to convert this border to a `BoxDecoration`.
  ///
  /// Use this to define a border for widgets like `Box` or `Card`.
  const Border(
      {this.pixelWidth = 2,
      this.style = w.BorderStyle.solid,
      this.borderRadius = const BorderRadius.all(Radius.circular(10)),
      this.color,
      this.strokeAlign});

  /// create a border with a preset style
  const Border.preset(
      {this.pixelWidth = 2,
      this.style = BorderStyle.solid,
      this.borderRadius = const BorderRadius.all(Radius.circular(10)),
      this.color,
      this.strokeAlign});

  Border copyWith(
          {double? pixelWidth,
          BorderStyle? style,
          double? strokeAlign,
          Color? color,
          BorderRadius? borderRadius}) =>
      Border(
          pixelWidth: pixelWidth ?? this.pixelWidth,
          style: style ?? this.style,
          strokeAlign: strokeAlign ?? this.strokeAlign,
          color: color ?? this.color,
          borderRadius: borderRadius ?? this.borderRadius);

  Border merged(Border? other) => other == null
      ? this
      : Border(
          pixelWidth: other.pixelWidth ?? pixelWidth,
          style: other.style ?? style,
          strokeAlign: other.strokeAlign ?? strokeAlign,
          color: other.color ?? color,
          borderRadius: other.borderRadius ?? borderRadius);

  /// convert this border to a `BoxDecoration`. Use this to apply the border to
  /// a Flutter `Container` widget.
  BoxDecoration toDeco([Color? color]) => BoxDecoration(
      borderRadius: borderRadius,
      border: pixelWidth == 0
          ? null
          : w.Border.all(
              color: color ?? this.color ?? Colors.transparent,
              width: pixelWidth ?? 0,
              style: style ?? BorderStyle.solid,
              strokeAlign: strokeAlign ?? BorderSide.strokeAlignInside));
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
    final rem = GeometryTheme.of(context).rem;
    return EdgeInsets.fromLTRB(rem(left), rem(top), rem(right), rem(bottom));
  }
}
