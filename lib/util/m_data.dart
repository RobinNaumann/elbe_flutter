import 'json_tools.dart';

abstract class DataModel {
  JsonMap<dynamic> get map;

  const DataModel();

  @override
  String toString() => "$runtimeType$map";

  @override
  int get hashCode => toString().hashCode;

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;
}
