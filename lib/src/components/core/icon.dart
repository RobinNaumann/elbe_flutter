import 'package:flutter/widgets.dart' as w;

import '../../../elbe.dart';

/// An icon with optional badge.
class Icon extends ThemedWidget {
  final IconData? icon;
  final String? semanticLabel;
  final Color? color;
  final TypeStyles style;
  final TypeStyle? resolvedStyle;
  final Badge? badge;

  /// create an icon with optional badge
  /// [icon] the icon to display. If null, a blank square will be displayed
  ///
  /// use `Icons`, `MaterialIcons`, `ApfelIcons`, or any other icon set
  const Icon(
    this.icon, {
    super.key,
    this.color,
    this.semanticLabel,
    this.style = TypeStyles.bodyM,
    this.resolvedStyle,
    this.badge,
  });

  Widget _icon(BuildContext c, TypeStyle type, Color color) => icon == null
      ? SizedBox.square(dimension: c.rem(type.iconSize))
      : w.Icon(icon,
          size: c.rem(type.iconSize),
          color: color,
          semanticLabel: semanticLabel,
          textDirection: TextDirection.ltr);

  @override
  Widget make(context, theme) {
    final appliedType =
        theme.type.selected.merge(theme.type.get(style)).merge(resolvedStyle);
    final appliedColor = color ?? theme.color.activeLayer.front;
    final appliedSize = appliedType.iconSize;

    if (badge == null) return _icon(context, appliedType, appliedColor);
    return w.SizedBox.square(
      dimension: context.rem(appliedSize),
      child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            _icon(context, appliedType, appliedColor),
            Positioned(
                top: -8.0,
                left: context.rem(appliedSize * 0.5),
                child: badge ?? const SizedBox.shrink())
          ]),
    );
  }
}
