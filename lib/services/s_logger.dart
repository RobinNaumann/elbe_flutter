// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:elbe/src/extensions/maybe_map.dart';

import '../elbe.dart';

enum LogLevel {
  verbose(Colors.grey, [90]),
  debug(Colors.purple, [35]),
  note(Colors.blue, [34]),
  warn(Colors.orange, [33]),
  error(Colors.red, [31]);

  const LogLevel(this.color, this.ansiEffects);

  final Color color;
  final List<int> ansiEffects;

  String ansify(String msg) => msg
      .split("\n")
      .map((l) => ansiEffects.map((e) => "\x1B[${e}m").join() + l + "\x1b[0m")
      .join("\n");
}

final log = LoggerService.i;

T serviceInst<T>(T? i) => i ?? (throw BitError.serviceNotInitialized("$T"));

abstract class LoggerService {
  static LoggerService? _i;
  static LoggerService get i => serviceInst(_i);

  /// provide a custom logger service. For basic console logging, use ConsoleLoggerService.
  static void init(LoggerService i) => _i = _i ?? i;

  /// publish a log message
  void log(LogLevel level, Object? referer, String message,
      [dynamic error, StackTrace? stackTrace]);

  /// publish a **verbose** log message
  void v(Object? referer, String msg,
          [dynamic error, StackTrace? stackTrace]) =>
      log(LogLevel.verbose, referer, msg, error, stackTrace);

  /// publish a **debug** log message
  void d(Object? referer, String msg,
          [dynamic error, StackTrace? stackTrace]) =>
      log(LogLevel.debug, referer, msg, error, stackTrace);

  /// publish a **note** log message. In other log frameworks, this is often called **info**
  void n(Object? referer, String msg,
          [dynamic error, StackTrace? stackTrace]) =>
      log(LogLevel.note, referer, msg, error, stackTrace);

  /// publish a **verbose** log message
  void w(Object? referer, String msg,
          [dynamic error, StackTrace? stackTrace]) =>
      log(LogLevel.warn, referer, msg, error, stackTrace);

  /// publish a **verbose** log message
  void e(Object? referer, String msg,
          [dynamic error, StackTrace? stackTrace]) =>
      log(LogLevel.error, referer, msg, error, stackTrace);
}

class ConsoleLoggerService extends LoggerService {
  final LogLevel minLevel;
  final LogLevel traceMinLevel;
  final int maxWidth;

  ConsoleLoggerService(
      {this.minLevel = LogLevel.verbose,
      this.traceMinLevel = LogLevel.error,
      this.maxWidth = 80});

  String _limited(String msg, int sectionLength) {
    String sections = "";
    int currentLength = 0;
    for (String word in msg.split(" ")) {
      if (currentLength + word.length > sectionLength) {
        sections += "\n";
        currentLength = 0;
      }
      sections += word + " ";
      currentLength += word.length + 1;
    }
    return sections;
  }

  String _ansiU(String msg) => "\x1B[4m$msg\x1B[24m";

  String _multiLinePadded(String msg, int pad) =>
      msg.split("\n").join("\n".padRight(pad));

  @override
  void log(level, referer, message, [error, stackTrace]) {
    if (level.index < minLevel.index) return;

    final msg = [
      level.name.toString().toUpperCase().add(":").padRight(10),
      (referer?.runtimeType.toString().add(":") ?? "").padRight(18),
      _multiLinePadded(_limited(message, maxWidth - 31), 29),
      if (error != null)
        _multiLinePadded(
            "\n" + _ansiU("ERROR:") + " " + _multiLinePadded("$error", 8), 29),
      if (stackTrace != null)
        level.index >= traceMinLevel.index
            ? "\n".padRight(11) + _multiLinePadded(stackTrace.toString(), 11)
            : "\n".padRight(29) + _ansiU("TRACE:") + " [suppressed]"
    ].join("");
    // ignore: avoid_print
    print(level.ansify(msg));
  }
}
