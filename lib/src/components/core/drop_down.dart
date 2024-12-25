import 'package:elbe/elbe.dart';

/// A dropdown menu that allows the user to select a value from a list of
/// options. The dropdown menu is displayed as a button that, when clicked,
/// displays a list of options that the user can select from.
class DropDown<T> extends ThemedWidget {
  final List<OptionsItem<T>> items;
  final T? selected;
  final Function(T? v)? onSelect;

  const DropDown(
      {super.key, required this.items, this.selected, this.onSelect});

  @override
  Widget make(context, theme) {
    final oneHasIcon = items.any((e) => e.icon != null);

    return Box(
      border: Border(),
      child: DropdownButton<T>(
        value: selected,
        borderRadius: theme.geometry.border.borderRadius,
        icon: Icon(Icons.chevronDown),
        isExpanded: true,
        dropdownColor: theme.color.activeSchemes.secondary.back,

        focusColor: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: context.rem(1)),
        //style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 0,
          color: Colors.transparent,
        ),
        onChanged: (v) => onSelect?.call(v),
        items: items.map<DropdownMenuItem<T>>((v) {
          return DropdownMenuItem<T>(
              value: v.key,
              child: Row(
                children: [
                  if (oneHasIcon) Icon(v.icon),
                  Expanded(
                      child: Text(
                    v.label,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  )),
                ].spaced(),
              ));
        }).toList(),
      ),
    );
  }
}
