import 'package:flutter/widgets.dart' as w;

import '../../../elbe.dart';

extension _MergedBoxDecoration on BoxDecoration {
  BoxDecoration merged(BoxDecoration? other) => other == null
      ? this
      : BoxDecoration(
          color: other.color ?? color,
          image: other.image ?? image,
          border: other.border ?? border,
          borderRadius: other.borderRadius ?? borderRadius,
          boxShadow: other.boxShadow ?? boxShadow,
          gradient: other.gradient ?? gradient,
          backgroundBlendMode: other.backgroundBlendMode ?? backgroundBlendMode,
          shape: other.shape);
}

/// A Box is the basic container with elbe.
/// It can have a color scheme, kind, manner, state, or a custom color.
/// It can have padding, margin, border, decoration, constraints, width, and height.
/// It can have a child.
class Box extends StatelessWidget {
  final Clip? clipBehavior;
  final ColorModes? mode;
  final ColorSchemes? scheme;
  final ColorKinds? kind;
  final ColorManners? manner;
  final ColorStates? state;

  final Color? color;
  final double? radius;
  final BorderRadius? borderRadius;

  final RemInsets? padding;
  final RemInsets? margin;
  final Border border;
  final BoxDecoration? decoration;
  final RemConstraints? constraints;
  final double? height;
  final double? width;
  final int? flex;

  // raw elements
  final EdgeInsets? rawPadding;
  final EdgeInsets? rawMargin;
  final BoxConstraints? rawConstraints;

  /// you can force a background color for this container that overrides
  /// the background color defined in the [mode]
  final Widget child;

  /// create a box with all the options. Boxes are the basic building blocks
  /// of elbe.
  ///
  /// The style parameters will be merged with the current color scheme. This
  /// is also applied to child widgets.
  const Box(
      {super.key,
      this.clipBehavior,
      this.mode,
      this.scheme,
      this.kind,
      this.manner,
      this.state,
      this.color,
      this.radius,
      this.borderRadius,
      this.padding,
      this.margin,
      this.border = const Border(width: 0),
      this.decoration,
      this.constraints,
      this.width,
      this.height,
      this.rawPadding,
      this.rawMargin,
      this.rawConstraints,
      this.flex,
      required this.child});

  /*/// a plain box with no color scheme, kind, manner, state, or custom color
  /// use this as part of a more complex widget
  const Box.plain(
      {super.key,
      this.mode,
      this.clipBehavior,
      this.padding,
      this.margin,
      this.decoration,
      this.constraints,
      this.width,
      this.height,
      this.rawPadding,
      this.rawMargin,
      this.rawConstraints,
      required this.child})
      : scheme = ColorSchemes.primary,
        kind = null,
        manner = null,
        state = null,
        color = null,
        border = Border.noneRect;*/

  @override
  Widget build(BuildContext context) {
    final updatedTheme = context.theme.withColorSelection(
        mode: mode, scheme: scheme, kind: kind, manner: manner, state: state);

    final c = color ?? decoration?.color ?? updatedTheme.color.selected.back;

    final _pad = rawPadding ?? padding?.toPixel(context);

    final w.Border border = this.border.resolved(updatedTheme);

    final radius = this.borderRadius ??
        (this.radius != null
            ? BorderRadius.circular(context.rem(this.radius ?? 0))
            : null);

    final resRadius = radius ??
        decoration?.borderRadius ??
        BorderRadius.circular(context.rem(updatedTheme.geometry.borderRadius));

    return _MaybeFlex(
      flex: flex ?? 0,
      child: Theme(
        data: updatedTheme,
        child: Container(
            clipBehavior: Clip.none,
            width: context.theme.geometry.maybeRem(width),
            height: context.theme.geometry.maybeRem(height),
            margin: rawMargin ?? margin?.toPixel(context),
            constraints: rawConstraints ?? constraints?.toPixel(context),
            decoration:
                BoxDecoration(color: c, border: border, borderRadius: resRadius)
                    .merged(decoration),
            child: ClipRRect(
                clipBehavior: clipBehavior ?? Clip.antiAlias,
                borderRadius: _subtractBorder(resRadius, _maxBorder(border)),
                child: Padding(
                    padding: _minusBorder(_pad ?? EdgeInsets.zero, border),
                    child: child))),
      ),
    );
  }
}

EdgeInsets _minusBorder(EdgeInsets e, w.Border b) {
  return EdgeInsets.only(
    left: Math.max(0, e.left - b.left.width),
    top: Math.max(0, e.top - b.top.width),
    right: Math.max(0, e.right - b.right.width),
    bottom: Math.max(0, e.bottom - b.bottom.width),
  );
}

double _maxBorder(w.Border border) {
  if (border.isUniform) return border.bottom.width;
  return [
    border.bottom.width,
    border.top.width,
    border.left.width,
    border.right.width
  ].max;
}

BorderRadius _subtractBorder(BorderRadiusGeometry? a, double borderWidth) {
  if (a == null || a is! BorderRadius) return BorderRadius.zero;
  final w = borderWidth + .5;
  return BorderRadius.only(
    topLeft: a.topLeft - Radius.circular(w),
    topRight: a.topRight - Radius.circular(w),
    bottomLeft: a.bottomLeft - Radius.circular(w),
    bottomRight: a.bottomRight - Radius.circular(w),
  );
}

class _MaybeFlex extends StatelessWidget {
  final int flex;
  final Widget child;
  const _MaybeFlex({required this.child, required this.flex});

  @override
  Widget build(BuildContext context) {
    // check if the parent is a Row or Column, and if so,
    // return a Flexible with the child, otherwise return the child directly
    final parentType = context.findAncestorWidgetOfExactType<Row>() != null
        ? Row
        : context.findAncestorWidgetOfExactType<Column>() != null
            ? Column
            : null;

    return (parentType != null && flex > 0)
        ? Expanded(flex: flex, child: child)
        : child;
  }
}
