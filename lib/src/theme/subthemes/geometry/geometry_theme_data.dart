import '../../../../elbe.dart';

class GeometryThemeData extends JsonModel {
  final Border border;
  final double remSize;
  final bool buttonBorder;

  double rem(double dim) => dim * remSize;
  double? maybeRem(double? dim) => dim != null ? rem(dim) : null;

  const GeometryThemeData(
      {required this.remSize,
      required this.border,
      required this.buttonBorder});

  GeometryThemeData.preset(
      {this.remSize = 16,
      this.border = const Border.preset(),
      this.buttonBorder = false});

  GeometryThemeData copyWith({
    Border? border,
    double? remSize,
    bool? buttonBorder,
  }) {
    return GeometryThemeData(
        remSize: remSize ?? this.remSize,
        border: border ?? this.border,
        buttonBorder: buttonBorder ?? this.buttonBorder);
  }

  get map => {
        "remSize": remSize,
        "border": border.hashCode,
        "buttonBorder": buttonBorder
      };
}
