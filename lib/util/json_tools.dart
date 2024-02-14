typedef JsonMap<D> = Map<String, D>;
typedef JsonList<D> = List<JsonMap<D>>;

class JsonException implements Exception {
  final String cause;
  JsonException(this.cause);

  @override
  String toString() => cause;
}

class FieldParseJsonException<T> extends JsonException {
  final String field;
  FieldParseJsonException(this.field)
      : super("failed to parse field '$field' as type ${(T).toString()}");
}

extension JsonFunctions<D> on JsonMap<D> {
  T asCast<T>(String key) => _try(
      key,
      () => T == double
          ? ((this[key] as num).toDouble() as T)
          : (this[key] as T));

  /// return
  T? maybeCast<T>(String key) =>
      (!containsKey(key) || this[key] == null) ? null : asCast<T>(key);

  String? asFormData() => entries
      .map((e) =>
          "${Uri.encodeComponent(e.key).replaceAll("%20", "+")}=${Uri.encodeComponent(e.value.toString()).replaceAll("%20", "+")}")
      .join("&");

  T? tryCast<T>(String key) {
    try {
      return asCast<T>(key);
    } catch (e) {
      return null;
    }
  }

  T? maybe<T, I>(String key, T? Function(I map) parser) => _try(
      key,
      () => containsKey(key) && this[key] != null
          ? parser(this[key] as I)
          : null);

  List<T>? maybeCastList<T>(String key) {
    try {
      List<T> result = [];
      if (this[key] == null) return null;
      for (var e in (this[key] as List<dynamic>)) {
        result.add(e as T);
      }
      return result;
    } catch (e) {
      return null;
    }
  }

  /// returns the value associated with that [key]. Returns null if [key] is not defined
  D? get(String key) => containsKey(key) ? this[key] : null;

  /// returns a map that only contains items that conform to [test]
  JsonMap where(bool Function(String k, D v) test) {
    JsonMap m = {};
    forEach((k, v) {
      if (test(k, v)) m.putIfAbsent(k, () => v);
    });
    return m;
  }

  JsonMap<D> set(String key, D value,
      [D Function(D old, D value)? onConflict]) {
    if (containsKey(key)) {
      this[key] = onConflict?.call(this[key] as D, value) ?? value;
    } else {
      putIfAbsent(key, () => value);
    }
    return this;
  }

  T _try<T>(String key, T Function() worker) {
    try {
      return worker();
    } catch (e) {
      throw FieldParseJsonException<T>(key);
    }
  }
}
