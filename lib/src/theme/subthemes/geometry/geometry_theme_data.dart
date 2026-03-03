import '../../../../elbe.dart';

class GeometryThemeData extends JsonModel {
  final double borderWidth;
  final double borderRadius;
  final BorderStyle borderStyle;
  final double borderAlign;
  final double remSize;

  double rem(double dim) => dim * remSize;
  double? maybeRem(double? dim) => dim != null ? rem(dim) : null;

  const GeometryThemeData(
      {required this.remSize,
      required this.borderWidth,
      required this.borderRadius,
      required this.borderStyle,
      required this.borderAlign});

  GeometryThemeData.preset(
      {this.remSize = 16,
      this.borderWidth = .125,
      this.borderRadius = .5,
      this.borderStyle = BorderStyle.solid,
      this.borderAlign = BorderSide.strokeAlignInside});

  GeometryThemeData copyWith(
      {double? borderWidth,
      double? borderRadius,
      BorderStyle? borderStyle,
      double? remSize,
      bool? buttonBorder,
      double? borderAlign}) {
    return GeometryThemeData(
        remSize: remSize ?? this.remSize,
        borderWidth: borderWidth ?? this.borderWidth,
        borderRadius: borderRadius ?? this.borderRadius,
        borderStyle: borderStyle ?? this.borderStyle,
        borderAlign: borderAlign ?? this.borderAlign);
  }

  get map => {
        "remSize": remSize,
        "borderWidth": borderWidth,
        "borderRadius": borderRadius,
        "borderStyle": borderStyle.toString(),
      };
}
