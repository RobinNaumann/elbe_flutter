import 'package:lucide_icons/lucide_icons.dart';

import '../../../elbe.dart';

/// a toggle button that can be switched on or off
class ToggleButton extends StatelessWidget {
  final bool value;
  final String label;
  final IconData? icon;
  final Function(bool value) onChanged;

  /// create a toggle button with a label and an optional icon
  const ToggleButton(
      {super.key,
      required this.value,
      required this.label,
      this.icon,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
        onTap: () => onChanged(!value),
        height: 3.5,
        kind: value ? ColorKinds.accent : null,
        manner: ColorManners.minor,
        border: Border.none,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (icon != null)
            Padding(
                padding: const EdgeInsets.only(right: 10), child: Icon(icon!)),
          Text(
            label,
            variant: TypeVariants.bold,
          ),
          if (value) Padded.only(left: 2, child: const Icon(LucideIcons.check))
        ]));
  }
}
