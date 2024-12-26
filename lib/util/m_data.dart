import 'json_tools.dart';

/// A class that represents a JSON object. It can be converted to a map.
/// It is used to represent data models that are serialized to JSON.
/// This also makes it easier to compare objects.
///
/// It is convention to also provide a `fromMap(JsonMap map)` factory method.
abstract class JsonModel {
  JsonMap<dynamic> get map;

  const JsonModel();

  @override
  String toString() => "$runtimeType$map";

  @override
  int get hashCode => toString().hashCode;

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;
}
