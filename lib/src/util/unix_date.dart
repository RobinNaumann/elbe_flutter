typedef UnixMs = int;

extension UnixDate on DateTime {
  UnixMs get asUnixMs => millisecondsSinceEpoch;
  static DateTime fromUnixMs(int unixMs) =>
      DateTime.fromMillisecondsSinceEpoch(unixMs);
}
