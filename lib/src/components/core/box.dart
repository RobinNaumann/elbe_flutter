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

class Box extends ThemedWidget {
  final Clip? clipBehavior;
  final ColorModes? mode;
  final ColorSchemes scheme;
  final ColorStyles? style;
  final ColorStates? state;

  final Color? color;

  final RemInsets? padding;
  final RemInsets? margin;
  final Border? border;
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

  const Box(
      {super.key,
      this.clipBehavior,
      this.mode,
      this.scheme = ColorSchemes.primary,
      this.style,
      this.state,
      this.color,
      this.padding,
      this.margin,
      this.border,
      this.decoration,
      this.constraints,
      this.width,
      this.height,
      this.rawPadding,
      this.rawMargin,
      this.rawConstraints,
      required this.child});

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
        style = null,
        state = null,
        color = null,
        border = Border.noneRect;

  @override
  Widget make(context, theme) {
    final colorT = ColorTheme.of(context)
        .copyWith(mode: mode, scheme: scheme, style: style, state: state);
    final c = color ?? decoration?.color ?? colorT.activeLayer.back;

    return ColorTheme(
      data: colorT,
      child: Container(
          clipBehavior: clipBehavior ?? Clip.none,
          width: theme.rem(width),
          height: theme.rem(height),
          padding: rawPadding ?? padding?.toPixel(context),
          margin: rawMargin ?? margin?.toPixel(context),
          constraints: rawConstraints ?? constraints?.toPixel(context),
          decoration: theme.geometry.border
              .merged(border)
              .toDeco(colorT.activeLayer.border)
              .merged(decoration)
              .copyWith(color: c),
          child: child),
    );
  }
}
