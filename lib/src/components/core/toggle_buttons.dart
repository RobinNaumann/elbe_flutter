import 'package:elbe/src/extensions/maybe_map.dart';

import '../../../elbe.dart';

class ToggleItem {
  final IconData? icon;
  final String label;

  const ToggleItem({this.icon, required this.label});
}

class MultiToggleItem<T> extends ToggleItem {
  final T key;

  const MultiToggleItem({required this.key, super.icon, required super.label});
}

class ToggleButtons<T> extends StatelessWidget {
  final T selected;
  final List<MultiToggleItem<T>> items;
  final Function(T id) onSelect;

  const ToggleButtons(
      {super.key,
      required this.selected,
      required this.items,
      required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Card(
        padding: null,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
                children: items.listMap((e) => InkWell(
                    onTap: () => onSelect(e.key),
                    child: Card(
                        padding: const RemInsets.symmetric(horizontal: 1),
                        height: 3.5,
                        style:
                            selected == e.key ? ColorStyles.minorAccent : null,
                        border: Border.noneRect,
                        child: Row(children: [
                          if (e.icon != null)
                            Padded.only(right: 1, child: Icon(e.icon!)),
                          Expanded(
                              child: Text(
                            e.label,
                            variant: TypeVariants.bold,
                          )),
                          if (selected == e.key)
                            Padded.only(left: 1, child: const Icon(Icons.check))
                        ])))))));
  }
}
