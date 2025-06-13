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
extension type UnixMs(int i) implements int {
  /// get the current time in milliseconds since epoch
  static UnixMs get now => DateTime.now().asUnixMs;

  /// get the date at 1970-01-01 00:00:00.000
  static UnixMs get zero => UnixMs(0);

  /// convert this UnixMs to a DateTime
  DateTime get asDateTime => DateTime.fromMillisecondsSinceEpoch(i);

  /// explicit type conversion to int
  int get asInt => i;
}
