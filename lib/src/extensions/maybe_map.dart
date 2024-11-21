import 'package:flutter/widgets.dart';

extension MaypeMap<A, B> on Map<A, B> {
  B? maybe(A key) => containsKey(key) ? this[key] : null;
}

extension MaybeList<B> on List<B> {
  /// Works just like .map.
  /// Automatically calls .toList() on the resulting iterable
  List<T> listMap<T>(T Function(B e) toElement) => map(toElement).toList();
  B? maybe(int i) => i >= 0 && i < length ? this[i] : null;
}

extension ExtendableString on String {
  String add(String? s) => s != null ? (this + s) : this;
  String replaceMulti(List<String> patterns, [String replace = ""]) {
    String res = this;
    for (final p in patterns) {
      res = res.replaceAll(p, replace);
    }
    return res;
  }
}

extension Typo on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
}
