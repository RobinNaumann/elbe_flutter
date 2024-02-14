import '../../../../elbe.dart';
import '../../util/inherited_theme.dart';

class GeometryThemeData extends ElbeInheritedThemeData {
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

  @override
  List getProps() => [border, remSize];

  @override
  Widget provider(Widget child) => GeometryTheme(data: this, child: child);
}
