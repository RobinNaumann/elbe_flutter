import 'package:lucide_icons/lucide_icons.dart';

import '../../../elbe.dart';

class ToggleButton extends StatelessWidget {
  final bool value;
  final ToggleItem item;
  final Function(bool value) onChanged;

  const ToggleButton(
      {super.key,
      required this.value,
      required this.item,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
        padding: null,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
                onTap: () => onChanged(!value),
                child: Card(
                    height: 3.5,
                    style: value ? ColorStyles.minorAccent : null,
                    border: Border.noneRect,
                    child: Row(children: [
                      if (item.icon != null)
                        Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(item.icon!)),
                      Expanded(
                          child: Text(
                        item.label,
                        variant: TypeVariants.bold,
                      )),
                      if (value)
                        Padded.only(
                            left: 1, child: const Icon(LucideIcons.check))
                    ])))));
  }
}
