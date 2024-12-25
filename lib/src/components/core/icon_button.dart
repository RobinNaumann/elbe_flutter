part of './button.dart';

/// a custom Button that only contains an icon
class IconButton extends ThemedWidget {
  final ColorKinds kind;
  final ColorManners manner;
  final IconData icon;
  final String? hint;
  final RemConstraints? constraints;
  final VoidCallback? onTap;
  final bool splash;

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
      this.splash = true});

  /// create an icon button with a major manner.
  /// Major icon buttons signify the main action
  const IconButton.major(
      {super.key,
      required this.icon,
      this.hint,
      this.onTap,
      this.constraints,
      this.kind = ColorKinds.accent,
      this.splash = true})
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
      this.splash = true})
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
      this.splash = true})
      : manner = ColorManners.flat;

  /// create an icon button with a flat manner and plain color.
  /// Flat plain icon buttons have no background color
  /// and are typically used for actions that are not the main focus
  const IconButton.flatPlain(
      {super.key,
      required this.icon,
      this.hint,
      this.onTap,
      this.constraints,
      this.splash = true})
      : manner = ColorManners.flat,
        kind = ColorKinds.plain;

  Widget _maybeTooltip(BuildContext context, ThemeData theme, Widget child) =>
      hint != null
          ? Tooltip(
              textStyle: theme.type.bodyM.toTextStyle(context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: theme.color.activeSchemes.back.withOpacity(0.8)),
              message: hint,
              child: child)
          : child;

  @override
  Widget make(context, theme) {
    return _maybeTooltip(
        context,
        theme,
        Card(
            padding: null,
            constraints: constraints ??
                const RemConstraints(minHeight: 2.5, minWidth: 2.5),
            border: (theme.geometry.buttonBorder ? const Border() : Border.none)
                .copyWith(borderRadius: BorderRadius.circular(200)),
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
