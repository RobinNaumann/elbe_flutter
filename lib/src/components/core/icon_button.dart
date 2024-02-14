part of './button.dart';

class IconButton extends ThemedWidget {
  final ColorStyles style;
  final IconData icon;
  final String? hint;
  final RemConstraints? constraints;
  final VoidCallback? onTap;

  const IconButton(
      {super.key,
      required this.icon,
      this.hint,
      this.onTap,
      this.constraints,
      required this.style});

  const IconButton.major(
      {super.key, required this.icon, this.hint, this.onTap, this.constraints})
      : style = ColorStyles.majorAccent;

  const IconButton.minor(
      {super.key, required this.icon, this.hint, this.onTap, this.constraints})
      : style = ColorStyles.minorAccent;

  const IconButton.action(
      {super.key, required this.icon, this.hint, this.onTap, this.constraints})
      : style = ColorStyles.action;

  const IconButton.integrated(
      {super.key, required this.icon, this.hint, this.onTap, this.constraints})
      : style = ColorStyles.actionIntegrated;

  Widget _maybeTooltip(ThemeData theme, Widget child) => hint != null
      ? Tooltip(
          textStyle: theme.type.bodyM.toTextStyle(),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: theme.color.activeMode..withOpacity(0.8)),
          message: hint,
          child: child)
      : child;

  @override
  Widget make(context, theme) {
    return _maybeTooltip(
        theme,
        Card(
            padding: null,
            constraints: constraints ??
                const RemConstraints(minHeight: 2.5, minWidth: 2.5),
            border: (theme.geometry.buttonBorder ? const Border() : Border.none)
                .copyWith(borderRadius: BorderRadius.circular(200)),
            style: style,
            state: onTap != null ? ColorStates.neutral : ColorStates.disabled,
            child: _Inkwell(
              onPressed: onTap,
              child: Icon(icon),
            )));
  }
}
