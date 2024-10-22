import 'package:flutter/widgets.dart' as w;

import '../../../elbe.dart';

/// use *WText* to use the default Flutter Text widget
class Text extends ThemedWidget {
  final String value;
  final Color? color;
  final TypeStyles? style;
  final ColorStyles? colorStyle;
  final ColorStates? colorState;
  final TypeVariants? variant;
  final TypeStyle? resolvedStyle;
  final TextAlign textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? semanticLabel;

  const Text(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.style,
      this.colorStyle,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start});

  const Text.bodyS(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorStyle,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start})
      : style = TypeStyles.bodyS;

  const Text.bodyM(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorStyle,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start})
      : style = TypeStyles.bodyM;

  const Text.bodyL(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorStyle,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start})
      : style = TypeStyles.bodyL;

  const Text.code(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorStyle,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start})
      : style = TypeStyles.code;

  const Text.h6(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorStyle,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start})
      : style = TypeStyles.h6;

  const Text.h5(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorStyle,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start})
      : style = TypeStyles.h5;

  const Text.h4(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorStyle,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start})
      : style = TypeStyles.h4;

  const Text.h3(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorStyle,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start})
      : style = TypeStyles.h3;

  const Text.h2(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorStyle,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start})
      : style = TypeStyles.h2;

  const Text.h1(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorStyle,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start})
      : style = TypeStyles.h1;

  @override
  Widget make(context, theme) {
    final appliedType =
        (style != null ? theme.type.get(style!) : theme.type.selected)
            .copyWith(variant: variant)
            .merge(resolvedStyle);

    final appliedColor = color ??
        theme.color.resolve(style: colorStyle, state: colorState).front;

    return w.Text(value,
        textAlign: textAlign,
        overflow: overflow,
        semanticsLabel: semanticLabel,
        maxLines: maxLines,
        softWrap: true,
        style: appliedType.toTextStyle(context, appliedColor));
  }
}
