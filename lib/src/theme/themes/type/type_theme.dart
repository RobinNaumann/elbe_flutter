import '../../../../elbe.dart';
import '../../util/inherited_theme.dart';

class TypeTheme extends StatelessWidget {
  final TypeThemeData data;
  final Widget child;

  const TypeTheme({super.key, required this.data, required this.child});

  static TypeThemeData of(BuildContext context) =>
      Theme.of<TypeThemeData>(context);

  static TypeThemeData? maybeOf(BuildContext context) =>
      Theme.maybeOf<TypeThemeData>(context);

  @override
  Widget build(BuildContext context) =>
      ElbeInheritedTheme<TypeThemeData>(data: data, child: child);
}
