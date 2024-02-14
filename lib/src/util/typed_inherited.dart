import '../../elbe.dart';

class TypedInherited<T> extends InheritedWidget {
  final T data;
  final int _signature;

  TypedInherited({super.key, required super.child, required this.data})
      : _signature = data.hashCode;

  @override
  bool updateShouldNotify(TypedInherited oldWidget) {
    return _signature != oldWidget._signature;
  }
}
