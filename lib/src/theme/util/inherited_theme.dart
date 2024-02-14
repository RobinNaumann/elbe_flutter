
import '../../../elbe.dart';

abstract class ElbeInheritedThemeData {
  const ElbeInheritedThemeData();

  List<dynamic> getProps();

  Widget provider(Widget child);

  @override
  int get hashCode => getProps().map((e) => e.hashCode).hashCode;

  @override
  bool operator ==(final Object other) =>
      (other is ElbeInheritedThemeData) ? other.hashCode == hashCode : false;
}

class ElbeInheritedTheme<T extends ElbeInheritedThemeData>
    extends InheritedTheme {
  final T data;

  const ElbeInheritedTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant ElbeInheritedTheme<T> oldWidget) =>
      oldWidget.data != data;

  @override
  Widget wrap(context, Widget child) =>
      ElbeInheritedTheme<T>(data: data, child: child);
}
