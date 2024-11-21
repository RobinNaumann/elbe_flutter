import 'package:elbe/src/extensions/maybe_map.dart';

import '../../../elbe.dart';

/// an entry that can be selected from a list of options
class ToggleItem {
  final IconData? icon;
  final String label;

  const ToggleItem({this.icon, required this.label});
}

/// an entry that can be selected from a list of options by the user
class OptionsItem<T> extends ToggleItem {
  final T key;

  /// create an option item with a key, icon, and label
  /// [key] is the value that will be returned when the option is selected
  /// [icon] is the icon that will be displayed next to the label
  /// [label] is the text that will be displayed to the user
  const OptionsItem({required this.key, super.icon, required super.label});
}

/// a button that allows the user to select from a list of options
class OptionsButton<T> extends StatelessWidget {
  final T selected;
  final List<OptionsItem<T>> items;
  final Function(T id) onSelect;
  final bool vertical;
  final bool compact;

  /// a button that allows the user to select from a list of options
  ///
  /// [selected] is the currently selected option
  ///
  /// [items] is a list of options that the user can select from
  ///
  /// [onSelect] is a function that will be called when the user selects an option
  ///
  /// [vertical] is a flag that determines if the options should be displayed vertically
  const OptionsButton(
      {super.key,
      required this.selected,
      required this.items,
      required this.onSelect,
      this.compact = false,
      this.vertical = false});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Card(
          kind: ColorKinds.accent,
          padding: null,
          child: Flex(
              mainAxisSize: MainAxisSize.min,
              direction: vertical ? Axis.vertical : Axis.horizontal,
              children: items.listMap((e) => GestureDetector(
                  onTap: () => onSelect(e.key),
                  child: Box(
                    kind: ColorKinds.plain,
                    child: Card(
                        padding:
                            RemInsets.symmetric(horizontal: compact ? .7 : 1),
                        height: compact ? 2.5 : 3.5,
                        manner: selected == e.key
                            ? ColorManners.minor
                            : ColorManners.flat,
                        kind: ColorKinds.accent,
                        border: Border.noneRect,
                        child: Row(children: [
                          if (e.icon != null)
                            Padded.only(
                                right: compact ? .4 : 1, child: Icon(e.icon!)),
                          vertical
                              ? Expanded(
                                  child: Text(
                                  e.label,
                                  variant: TypeVariants.bold,
                                ))
                              : Text(e.label, variant: TypeVariants.bold),
                          if (selected == e.key && vertical)
                            Padded.only(left: 1, child: const Icon(Icons.check))
                        ])),
                  )))),
        ));
  }
}
