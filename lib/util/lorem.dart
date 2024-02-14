const String _text =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

lorem(int words) {
  final split = _text.split(" ");
  final w = List.of(split);
  while (words > w.length) {
    w.addAll(List.of(split));
  }
  final res = w.take(words).toList();
  if (res.isNotEmpty) res.last = res.last.replaceAll(",", ".");
  return res.join(" ");
}
