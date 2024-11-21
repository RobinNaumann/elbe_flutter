import '../../../elbe.dart';

part './icon_button.dart';

class Button extends ThemedWidget {
  final ColorKinds kind;
  final ColorManners manner;
  final IconData? icon;
  final String? label;
  final RemConstraints? constraints;
  final VoidCallback? onTap;
  final bool? border;
  final bool expand;
  final MainAxisAlignment alignment;
  final bool splash;

  /// create a button with all the options. Buttons are automatically styled
  /// based on the [kind] and [manner] properties. If [onTap] is null, the
  /// button will be disabled.
  ///
  /// you can use:
  /// - `Button.major`
  /// - `Button.minor`
  /// - `Button.flat`
  /// - `Button.flatPlain`
  ///
  /// to create a button with a specific manner.
  const Button(
      {super.key,
      this.icon,
      this.label,
      this.onTap,
      this.constraints,
      this.border,
      this.kind = ColorKinds.accent,
      this.manner = ColorManners.major,
      this.alignment = MainAxisAlignment.center,
      this.expand = false,
      this.splash = true});

  /// create a button with a major manner. Major buttons signify the main action
  const Button.major(
      {super.key,
      this.icon,
      this.label,
      this.onTap,
      this.constraints,
      this.border,
      this.alignment = MainAxisAlignment.center,
      this.kind = ColorKinds.accent,
      this.expand = false,
      this.splash = true})
      : manner = ColorManners.major;

  /// create a button with a minor manner. Minor buttons signify a secondary action
  /// or a less important action
  const Button.minor(
      {super.key,
      this.icon,
      this.label,
      this.onTap,
      this.constraints,
      this.border,
      this.alignment = MainAxisAlignment.center,
      this.kind = ColorKinds.accent,
      this.expand = false,
      this.splash = true})
      : manner = ColorManners.minor;

  /// create a button with a flat manner. Flat buttons have no background color
  /// and are typically used for actions that are not the main focus
  const Button.flat(
      {super.key,
      this.icon,
      this.label,
      this.onTap,
      this.constraints,
      this.border = false,
      this.alignment = MainAxisAlignment.center,
      this.kind = ColorKinds.accent,
      this.expand = false,
      this.splash = true})
      : manner = ColorManners.flat;

  /// create a button with a flat manner and a plain color scheme. Flat plain
  /// buttons have no background color and are typically used for actions that
  /// are not the main focus. They are used within other widgets
  const Button.flatPlain(
      {super.key,
      this.icon,
      this.label,
      this.onTap,
      this.constraints,
      this.border = false,
      this.alignment = MainAxisAlignment.center,
      this.expand = false,
      this.splash = true})
      : manner = ColorManners.flat,
        kind = ColorKinds.plain;

  @override
  Widget make(context, theme) {
    return Card(
        clipBehavior: Clip.antiAlias,
        padding: null,
        constraints: constraints ?? const RemConstraints(minHeight: 3.5),
        border: (border ?? theme.geometry.buttonBorder) ? null : Border.none,
        kind: kind,
        manner: manner,
        //color: manner == ColorManners.flat ? Colors.transparent : null,
        state: onTap != null ? ColorStates.neutral : ColorStates.disabled,
        child: _Inkwell(
          splash: splash,
          onPressed: onTap,
          child: Padded.symmetric(
            horizontal: 0.75,
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: alignment,
                children: [
                  if (icon != null) Icon(icon!),
                  if (label != null) Text(label!, variant: TypeVariants.bold)
                ].spaced(amount: 0.75)),
          ),
        ));
  }
}

class _Inkwell extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool splash;
  final Widget child;
  const _Inkwell({this.onPressed, required this.splash, required this.child});

  @override
  Widget build(BuildContext context) {
    final m = ColorTheme.of(context)
        .activeManner
        .active
        .back
        .inter(Colors.black, .5)
        .withOpacity(.125);
    return Material(
        color: Colors.transparent,
        child: onPressed == null
            ? child
            : InkWell(
                hoverColor: splash ? null : Colors.transparent,
                focusColor: splash ? null : Colors.transparent,
                highlightColor: splash ? null : Colors.transparent,
                splashColor: splash ? m : Colors.transparent,
                onTap: onPressed,
                child: child));
  }
}
