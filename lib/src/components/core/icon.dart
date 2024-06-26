import 'package:flutter/widgets.dart' as w;

import '../../../elbe.dart';

class Icon extends ThemedWidget {
  final IconData icon;
  final String? semanticLabel;
  final Color? color;
  final TypeStyles style;
  final TypeStyle? resolvedStyle;
  final Badge? badge;

  const Icon(
    this.icon, {
    super.key,
    this.color,
    this.semanticLabel,
    this.style = TypeStyles.bodyM,
    this.resolvedStyle,
    this.badge,
  });

  Widget _icon(BuildContext c, TypeStyle type, Color color) => w.Icon(icon,
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
    return Stack(alignment: Alignment.centerLeft, children: [
      _icon(context, appliedType, appliedColor),
      Padding(
          padding: EdgeInsets.only(
              left: appliedSize / 2,
              bottom: appliedSize / 2 + theme.geometry.rem(0.3)),
          child: badge)
    ]);
  }
}
