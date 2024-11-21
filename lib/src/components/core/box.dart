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
class Box extends ThemedWidget {
  final Clip? clipBehavior;
  final ColorModes? mode;
  final ColorSchemes? scheme;
  final ColorKinds? kind;
  final ColorManners? manner;
  final ColorStates? state;

  final Color? color;

  final RemInsets? padding;
  final RemInsets? margin;
  final Border border;
  final BoxDecoration? decoration;
  final RemConstraints? constraints;
  final double? height;
  final double? width;

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
      this.padding,
      this.margin,
      this.border = Border.noneRect,
      this.decoration,
      this.constraints,
      this.width,
      this.height,
      this.rawPadding,
      this.rawMargin,
      this.rawConstraints,
      required this.child});

  /// a plain box with no color scheme, kind, manner, state, or custom color
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
        border = Border.noneRect;

  @override
  Widget make(context, theme) {
    final colorT = ColorTheme.of(context).copyWith(
        mode: mode, scheme: scheme, kind: kind, manner: manner, state: state);
    final c = color ?? decoration?.color ?? colorT.activeLayer.back;

    final _pad = rawPadding ?? padding?.toPixel(context);

    return ColorTheme(
      data: colorT,
      child: Container(
          clipBehavior: clipBehavior ?? Clip.none,
          width: theme.rem(width),
          height: theme.rem(height),
          margin: rawMargin ?? margin?.toPixel(context),
          constraints: rawConstraints ?? constraints?.toPixel(context),
          decoration: theme.geometry.border
              .merged(border)
              .toDeco(colorT.activeLayer.border)
              .merged(decoration)
              .copyWith(color: c),
          child: ClipRRect(
              clipBehavior: clipBehavior != null ? Clip.none : Clip.antiAlias,
              borderRadius: _subtractBorder(
                  border.borderRadius ?? theme.geometry.border.borderRadius,
                  border.pixelWidth ?? 0),
              child: Padding(padding: _pad ?? EdgeInsets.zero, child: child))),
    );
  }
}

BorderRadius _subtractBorder(BorderRadius? a, double borderWidth) {
  if (a == null) return BorderRadius.zero;
  return BorderRadius.only(
    topLeft: a.topLeft - Radius.circular(borderWidth),
    topRight: a.topRight - Radius.circular(borderWidth),
    bottomLeft: a.bottomLeft - Radius.circular(borderWidth),
    bottomRight: a.bottomRight - Radius.circular(borderWidth),
  );
}
