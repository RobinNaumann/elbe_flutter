extension UnixDate on DateTime {
  UnixMs get asUnixMs => UnixMs(millisecondsSinceEpoch);
}

extension UnixMsConv on int {
  UnixMs get asUnixMs => UnixMs(this);
}

/// a class that represents a time in milliseconds since epoch.
///
/// create using one of:
/// - `UnixMs(x)`,
/// - `x.asUnixMs`
/// - `x as UnixMs`
extension type UnixMs(int i) {
  /// get the current time in milliseconds since epoch
  UnixMs get now => DateTime.now().asUnixMs;

  /// convert this UnixMs to a DateTime
  DateTime get asDateTime => DateTime.fromMillisecondsSinceEpoch(i);

  /// explicit type conversion to int
  int get asInt => i;
}
