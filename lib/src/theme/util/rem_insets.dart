import 'package:flutter/widgets.dart' as w;

import '../../../elbe.dart';

class Border {
  static const Border none = Border(pixelWidth: 0, color: Colors.transparent);
  static const Border noneRect = Border(
      pixelWidth: 0,
      color: Colors.transparent,
      borderRadius: BorderRadius.zero);

  final double? pixelWidth;
  final BorderStyle? style;
  final double? strokeAlign;
  final Color? color;
  final BorderRadius? borderRadius;

  const Border(
      {this.pixelWidth,
      this.style,
      this.strokeAlign,
      this.color,
      this.borderRadius});

  const Border.preset(
      {this.pixelWidth = 1,
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

class RemInsets {
  static const RemInsets zero = RemInsets.all(0);

  final double left;
  final double top;
  final double right;
  final double bottom;

  const RemInsets(
      {this.left = 0, this.top = 0, this.right = 0, this.bottom = 0});

  const RemInsets.all(double value)
      : left = value,
        right = value,
        top = value,
        bottom = value;
  const RemInsets.fromLTRB(this.left, this.top, this.right, this.bottom);
  const RemInsets.symmetric({double horizontal = 0, double vertical = 0})
      : left = horizontal,
        right = horizontal,
        top = vertical,
        bottom = vertical;

  EdgeInsets toPixel(BuildContext context) {
    final rem = GeometryTheme.of(context).rem;
    return EdgeInsets.fromLTRB(rem(left), rem(top), rem(right), rem(bottom));
  }
}
