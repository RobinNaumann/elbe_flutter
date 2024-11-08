import 'dart:io';

import 'package:elbe/util/json_tools.dart';

import 'elbe_error.dart';

typedef L10nMap = Map<String, JsonMap<String>>;

/// shortcut for `ElbeErrors.i`
/// use `ElbeErrors.init(...)` to initialize the ElbeErrors instance.
ElbeErrors get elbeErrors => ElbeErrors.i;

extension ZonedFn<T> on T Function() {
  /// this is a shortcut for `elbeErrs.zoned(() => ...)`
  T zoned(ElbeError Function(dynamic) onError) =>
      elbeErrors.zoned(this, onError: onError);
}

class ElbeErrors {
  /// get the instance of ElbeErrors. Returns null if not initialized.
  /// you can also use the global `elbeErrors` shortcut.
  static ElbeErrors i = ElbeErrors.init(l10n: {});

  /// l10n is a map of locale to error messages. The key is the error code.
  /// For each error, provide a Map of locales and the error messages.
  ///
  /// Note: Provide an entry for `UNKNOWN` to handle unknown errors.
  ///
  /// All error codes are converted into UPPER CASE
  ///
  /// Example:
  /// ```json
  /// {
  ///   "AN_ERR_42": {
  ///     "en_US": "Error message in English",
  ///     "de_DE": "Fehlermeldung auf Deutsch"
  ///   }
  /// }
  final L10nMap l10n;

  /// Initialize the ElbeErrors instance with the l10n map.
  /// This is a singleton class. Use the `i` getter to get the instance.
  /// later, you can call `resolve` to get the localized error message.
  ElbeErrors.init({required L10nMap l10n})
      : l10n = l10n.map((k, v) => MapEntry(k.toUpperCase(), v)) {
    i = this;
  }

  T zoned<T>(T Function() f, {ElbeError Function(dynamic)? onError}) {
    try {
      return f();
    } catch (e) {
      throw (onError ?? ElbeError.unknown).call(e);
    }
  }

  Future<T> zonedAsync<T>(Future<T> Function() f,
      {ElbeError Function(dynamic)? onError}) async {
    try {
      return await f();
    } catch (e) {
      throw (onError ?? ElbeError.unknown).call(e);
    }
  }

  ElbeError resolve(dynamic error) {
    // if error is not an instance of ElbeError, return a string representation
    ElbeError e = (error is ElbeError) ? error : ElbeError.unknown(error);

    final locale = Platform.localeName;
    final locLang = locale.split("_").first;

    final msg = l10n[e.code]?[locale] ?? l10n[e.code]?[locLang] ?? e.message;
    return e.copyWith(message: msg);
  }
}
