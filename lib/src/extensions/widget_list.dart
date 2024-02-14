import 'package:flutter/widgets.dart';

extension SpacedWidgetList on Iterable<Widget> {
  List<Widget> spaced({double amount = 15, bool horizontal = false}) {
    List<Widget> l = toList();
    List<Widget> res = [];

    for (int i = 0; i < l.length; i++) {
      res.add(l[i]);
      if ((i + 1) < length) {
        res.add(SizedBox(
            width: horizontal ? amount : 0, height: horizontal ? 0 : amount));
      }
    }
    return res;
  }
}
