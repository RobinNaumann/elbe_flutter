part of './button.dart';

/// a custom Button that only contains an icon
class IconButton extends StatelessWidget {
  final ColorKinds kind;
  final ColorManners manner;
  final IconData icon;
  final String? hint;
  final RemConstraints? constraints;
  final VoidCallback? onTap;
  final bool splash;
  final bool transparent;

  /// create an icon button with all the options.
  /// IconButtons are automatically styled
  /// based on the [kind] and [manner] properties. If [onTap] is null, the
  /// button will be disabled.
  ///
  /// you can use
  /// - `IconButton.major`,
  /// - `IconButton.minor`,
  /// - `IconButton.flat`, or
  /// - `IconButton.flatPlain`
  const IconButton(
      {super.key,
      required this.icon,
      this.hint,
      this.onTap,
      this.constraints,
      this.kind = ColorKinds.accent,
      required this.manner,
      this.splash = true,
      this.transparent = false});

  /// create an icon button with a major manner.
  /// Major icon buttons signify the main action
  const IconButton.major(
      {super.key,
      required this.icon,
      this.hint,
      this.onTap,
      this.constraints,
      this.kind = ColorKinds.accent,
      this.splash = true,
      this.transparent = false})
      : manner = ColorManners.major;

  /// create an icon button with a minor manner.
  /// Minor icon buttons signify a secondary action
  const IconButton.minor(
      {super.key,
      required this.icon,
      this.hint,
      this.onTap,
      this.constraints,
      this.kind = ColorKinds.accent,
      this.splash = true,
      this.transparent = false})
      : manner = ColorManners.minor;

  /// create an icon button with a flat manner.
  /// Flat icon buttons are less prominent and are used for less important actions
  const IconButton.flat(
      {super.key,
      required this.icon,
      this.hint,
      this.onTap,
      this.constraints,
      this.kind = ColorKinds.accent,
      this.splash = true,
      this.transparent = false})
      : manner = ColorManners.flat;

  /// create an icon button with a flat manner and plain color.
  /// Flat plain icon buttons have no background color
  /// and are typically used for actions that are not the main focus
  const IconButton.plain(
      {super.key,
      required this.icon,
      this.hint,
      this.onTap,
      this.constraints,
      this.kind = ColorKinds.accent,
      this.splash = true,
      this.transparent = true})
      : manner = ColorManners.plain;

  Widget _maybeTooltip(
          BuildContext context, ElbeThemeData theme, Widget child) =>
      hint != null
          ? Tooltip(
              textStyle: theme.type.bodyM.toTextStyle(context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: theme.color.selected.back.withOpacity(0.8)),
              message: hint,
              child: child)
          : child;

  @override
  Widget build(BuildContext context) {
    return _maybeTooltip(
        context,
        context.theme,
        Card(
            color: transparent ? Colors.transparent : null,
            clipBehavior: Clip.hardEdge,
            padding: null,
            radius: 12,
            constraints:
                constraints ?? const RemConstraints(minHeight: 3, minWidth: 3),
            border: Border(width: 0),
            kind: kind,
            manner: manner,
            state: onTap != null ? ColorStates.neutral : ColorStates.disabled,
            child: _Inkwell(
              splash: splash,
              onPressed: onTap,
              child: Icon(icon),
            )));
  }
}
