import '../../../elbe.dart';

extension SpacedWidgetList on Iterable<Widget> {
  List<Widget> spaced({bool? vertical, double amount = 1}) {
    final List<Widget> widgets = toList();
    List<Widget> res = [];
    for (int i = 0; i < widgets.length; i++) {
      res.add(widgets[i]);
      if ((i + 1) < length) {
        res.add(vertical != null
            ? (vertical ? Spaced.vertical(amount) : Spaced.horizontal(amount))
            : Spaced(width: amount, height: amount));
      }
    }
    return res;
  }
}
