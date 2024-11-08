import 'dart:ui';

import '../../../../elbe.dart';

enum TypeVariants {
  light._(FontWeight.w200, FontStyle.normal),
  regular._(FontWeight.normal, FontStyle.normal),
  bold._(FontWeight.bold, FontStyle.normal),
  black._(FontWeight.w900, FontStyle.normal),
  lightItalic._(FontWeight.w200, FontStyle.italic),
  italic._(FontWeight.normal, FontStyle.italic),
  boldItalic._(FontWeight.bold, FontStyle.italic),
  blackItalic._(FontWeight.w900, FontStyle.italic);

  const TypeVariants._(this.fontWeight, this.fontStyle);

  final FontStyle fontStyle;
  final FontWeight fontWeight;
}

class TypeStyle {
  final String? package;
  final String? fontFamily;

  final TypeVariants variant;
  final rem fontSize;
  final double iconFactor;

  rem get iconSize => fontSize * iconFactor;

  final TextDecoration? decoration;

  final List<FontFeature>? fontFeatures;

  const TypeStyle(
      {this.variant = TypeVariants.regular,
      this.fontSize = 1,
      double? iconFactor,
      this.fontFeatures,
      this.decoration,
      this.fontFamily,
      this.package})
      : iconFactor = iconFactor ?? 1.4;

  TypeStyle merge(TypeStyle? style) => TypeStyle(
      variant: style?.variant ?? variant,
      fontSize: style?.fontSize ?? fontSize,
      fontFamily: style?.fontFamily ?? fontFamily,
      package: style?.package ?? package,
      iconFactor: style?.iconFactor ?? iconFactor,
      decoration: style?.decoration ?? decoration,
      fontFeatures: style?.fontFeatures ?? fontFeatures);

  TypeStyle get bold => merge(const TypeStyle(variant: TypeVariants.bold));
  TypeStyle get regular =>
      merge(const TypeStyle(variant: TypeVariants.regular));
  TypeStyle get italic => merge(const TypeStyle(variant: TypeVariants.italic));

  TypeStyle copyWith(
          {TypeVariants? variant,
          double? fontSize,
          double? iconFactor,
          TextDecoration? decoration,
          List<FontFeature>? fontFeatures,
          String? fontFamily,
          String? package}) =>
      TypeStyle(
          variant: variant ?? this.variant,
          fontSize: fontSize ?? this.fontSize,
          iconFactor: iconFactor ?? this.iconFactor,
          decoration: decoration ?? this.decoration,
          fontFeatures: fontFeatures ?? this.fontFeatures,
          fontFamily: fontFamily ?? this.fontFamily,
          package: fontFamily != null ? (package) : this.package);

  TextStyle toTextStyle(BuildContext context, [Color? color]) => TextStyle(
      color: color,
      fontSize: context.rem(fontSize),
      fontFamily: fontFamily,
      package: package,
      fontStyle: variant.fontStyle,
      fontWeight: variant.fontWeight,
      fontFeatures: fontFeatures,
      decoration: decoration);
}
