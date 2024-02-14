extension UnixDate on DateTime {
  int get asUnixMs => millisecondsSinceEpoch;
  static DateTime parse(int unixMs) =>
      DateTime.fromMillisecondsSinceEpoch(unixMs);
}
