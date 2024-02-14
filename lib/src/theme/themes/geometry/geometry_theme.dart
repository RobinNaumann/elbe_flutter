import '../../../../elbe.dart';
import '../../util/inherited_theme.dart';

class GeometryTheme extends StatelessWidget {
  final GeometryThemeData data;
  final Widget child;

  const GeometryTheme({super.key, required this.data, required this.child});

  static GeometryThemeData of(BuildContext context) =>
      Theme.of<GeometryThemeData>(context);

  static GeometryThemeData? maybeOf(BuildContext context) =>
      Theme.maybeOf<GeometryThemeData>(context);

  @override
  Widget build(BuildContext context) =>
      ElbeInheritedTheme<GeometryThemeData>(data: data, child: child);
}
