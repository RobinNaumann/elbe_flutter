import 'dart:ui';
import '../../../../elbe.dart';

enum TypeVariants { regular, bold, italic, boldItalic }

class TypeStyle {
  final String? package;
  final String? fontFamily;

  final TypeVariants variant;
  final rem? fontSize;
  final rem? iconSize;
  final TextDecoration? decoration;

  final List<FontFeature>? fontFeatures;

  const TypeStyle(
      {this.variant = TypeVariants.regular,
      this.fontSize,
      rem? iconSize,
      this.fontFeatures,
      this.decoration,
      this.fontFamily,
      this.package})
      : iconSize = iconSize ?? ((fontSize ?? 1) * 1.6);

  TypeStyle merge(TypeStyle? style) => TypeStyle(
      variant: style?.variant ?? variant,
      fontSize: style?.fontSize ?? fontSize,
      fontFamily: style?.fontFamily ?? fontFamily,
      package: style?.package ?? package,
      iconSize: style?.iconSize ?? iconSize,
      decoration: style?.decoration ?? decoration,
      fontFeatures: style?.fontFeatures ?? fontFeatures);

  TypeStyle get bold => merge(const TypeStyle(variant: TypeVariants.bold));
  TypeStyle get regular =>
      merge(const TypeStyle(variant: TypeVariants.regular));
  TypeStyle get italic => merge(const TypeStyle(variant: TypeVariants.italic));

  TypeStyle copyWith(
          {TypeVariants? variant,
          double? fontSize,
          double? iconSize,
          TextDecoration? decoration,
          List<FontFeature>? fontFeatures,
          String? fontFamily,
          String? package}) =>
      TypeStyle(
          variant: variant ?? this.variant,
          fontSize: fontSize ?? this.fontSize,
          iconSize: iconSize ?? this.iconSize,
          decoration: decoration ?? this.decoration,
          fontFeatures: fontFeatures ?? this.fontFeatures,
          fontFamily: fontFamily ?? this.fontFamily,
          package: fontFamily != null ? (package) : this.package);

  TextStyle toTextStyle(BuildContext context, [Color? color]) => TextStyle(
      color: color,
      fontSize: context.rem(fontSize ?? 1),
      fontFamily: fontFamily,
      package: package,
      fontStyle:
          (variant == TypeVariants.italic || variant == TypeVariants.boldItalic)
              ? FontStyle.italic
              : FontStyle.normal,
      fontWeight:
          (variant == TypeVariants.bold || variant == TypeVariants.boldItalic)
              ? FontWeight.bold
              : FontWeight.normal,
      fontFeatures: fontFeatures,
      decoration: decoration);
}
