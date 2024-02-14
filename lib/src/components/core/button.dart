import '../../../elbe.dart';

part './icon_button.dart';

class Button extends ThemedWidget {
  final ColorStyles style;
  final IconData? icon;
  final String? label;
  final RemConstraints? constraints;
  final VoidCallback? onTap;
  final bool? border;
  final MainAxisAlignment alignment;

  const Button(
      {super.key,
      this.icon,
      this.label,
      this.onTap,
      this.constraints,
      this.border,
      required this.style,
      this.alignment = MainAxisAlignment.center});

  const Button.major(
      {super.key,
      this.icon,
      this.label,
      this.onTap,
      this.constraints,
      this.border,
      this.alignment = MainAxisAlignment.center})
      : style = ColorStyles.majorAccent;

  const Button.minor(
      {super.key,
      this.icon,
      this.label,
      this.onTap,
      this.constraints,
      this.border,
      this.alignment = MainAxisAlignment.center})
      : style = ColorStyles.minorAccent;

  const Button.action(
      {super.key,
      this.icon,
      this.label,
      this.onTap,
      this.constraints,
      this.border = false,
      this.alignment = MainAxisAlignment.center})
      : style = ColorStyles.action;

  const Button.integrated(
      {super.key,
      this.icon,
      this.label,
      this.onTap,
      this.constraints,
      this.border = false,
      this.alignment = MainAxisAlignment.center})
      : style = ColorStyles.actionIntegrated;

  @override
  Widget make(context, theme) {
    return Card(
        padding: null,
        constraints: constraints ?? const RemConstraints(minHeight: 3.5),
        border: (border ?? theme.geometry.buttonBorder) ? null : Border.none,
        style: style,
        state: onTap != null ? ColorStates.neutral : ColorStates.disabled,
        child: _Inkwell(
          onPressed: onTap,
          child: Padded.symmetric(
            horizontal: 0.75,
            child: Row(
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
  final Widget child;
  const _Inkwell({this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    final m = ColorTheme.of(context).activeStyle.pressed.back;
    return Material(
        color: Colors.transparent,
        child: onPressed == null
            ? child
            : InkWell(splashColor: m, onTap: onPressed, child: child));
  }
}
