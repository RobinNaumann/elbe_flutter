import 'package:lucide_icons/lucide_icons.dart';

import '../../../elbe.dart';

/// a toggle button that can be switched on or off
class ToggleButton extends StatelessWidget {
  final bool value;
  final String label;
  final IconData? icon;

  /// override [label] and [icon] with a custom widget
  final Widget? child;
  final bool showCheck;
  final Function(bool value) onChanged;

  /// create a toggle button with a label and an optional icon
  ///
  /// use `ToggleButton.custom` to
  const ToggleButton(
      {super.key,
      required this.value,
      required this.label,
      this.icon,
      this.showCheck = true,
      required this.onChanged})
      : child = null;

  /// override `label` and `icon` with a custom [child] widget
  const ToggleButton.custom(
      {super.key,
      this.value = false,
      this.showCheck = true,
      required Widget child,
      required this.onChanged})
      : label = "",
        icon = null,
        child = child;

  @override
  Widget build(BuildContext context) {
    return Card(
        onTap: () => onChanged(!value),
        height: 3.5,
        kind: ColorKinds.accent,
        manner: value ? ColorManners.minor : ColorManners.flat,
        border: Border.none,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (icon != null && child == null)
            Padding(
                padding: const EdgeInsets.only(right: 10), child: Icon(icon!)),
          child ??
              Text(
                label,
                variant: TypeVariants.bold,
              ),
          if (value && showCheck)
            Padded.only(left: 2, child: const Icon(LucideIcons.check))
        ]));
  }
}
