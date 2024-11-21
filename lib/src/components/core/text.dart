import 'package:flutter/widgets.dart' as w;

import '../../../elbe.dart';

/// use *WText* to use the default Flutter Text widget
class Text extends ThemedWidget {
  final String value;
  final Color? color;
  final TypeStyles? style;
  final ColorKinds? colorKind;
  final ColorManners? colorManner;
  final ColorStates? colorState;
  final TypeVariants? variant;
  final TypeStyle? resolvedStyle;
  final TextAlign textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? semanticLabel;

  /// create a text widget with the given value
  /// [value] is the text to display
  ///
  /// for the Flutter Text widget, use `WText`
  ///
  /// for predefined text styles, use:
  /// - `Text.bodyS`
  /// - `Text.bodyM`
  /// - `Text.bodyL`
  /// - `Text.code`
  /// - `Text.h6`
  /// - `Text.h5`
  /// - `Text.h4`
  /// - `Text.h3`
  /// - `Text.h2`
  /// - `Text.h1`
  const Text(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.style,
      this.colorKind,
      this.colorManner,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start});

  /// create a small body text
  const Text.bodyS(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorKind,
      this.colorManner,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start})
      : style = TypeStyles.bodyS;

  /// create a medium body text. this is the default body text
  const Text.bodyM(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorKind,
      this.colorManner,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start})
      : style = TypeStyles.bodyM;

  /// create a large body text
  const Text.bodyL(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorKind,
      this.colorManner,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start})
      : style = TypeStyles.bodyL;

  /// create a code text. it is monospaced
  const Text.code(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorKind,
      this.colorManner,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start})
      : style = TypeStyles.code;

  /// create a text with heading 6 style
  const Text.h6(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorKind,
      this.colorManner,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start})
      : style = TypeStyles.h6;

  /// create a text with heading 5 style
  const Text.h5(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorKind,
      this.colorManner,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start})
      : style = TypeStyles.h5;

  /// create a text with heading 4 style
  const Text.h4(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorKind,
      this.colorManner,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start})
      : style = TypeStyles.h4;

  /// create a text with heading 3 style
  const Text.h3(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorKind,
      this.colorManner,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start})
      : style = TypeStyles.h3;

  /// create a text with heading 2 style
  const Text.h2(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorKind,
      this.colorManner,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start})
      : style = TypeStyles.h2;

  /// create a text with heading 1 style
  const Text.h1(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.colorState,
      this.colorKind,
      this.colorManner,
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
        theme.color
            .resolve(kind: colorKind, manner: colorManner, state: colorState)
            .front;

    return w.Text(value,
        textAlign: textAlign,
        overflow: overflow,
        semanticsLabel: semanticLabel,
        maxLines: maxLines,
        softWrap: true,
        style: appliedType.toTextStyle(context, appliedColor));
  }
}
