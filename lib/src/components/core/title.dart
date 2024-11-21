import '../../../elbe.dart';

/// A widget that displays a title with a specific style.
class Title extends ThemedWidget {
  final String text;
  final TextAlign textAlign;
  final int level;
  final TypeStyles style;
  final bool topPadded;

  /// create a title with the given text.
  ///
  /// To display text without margins, use `Text` instead.
  const Title.h1(this.text,
      {super.key, this.textAlign = TextAlign.start, this.topPadded = true})
      : level = 1,
        style = TypeStyles.h1;

  /// create a title with the given text.
  ///
  /// To display text without margins, use `Text` instead.
  const Title.h2(this.text,
      {super.key, this.textAlign = TextAlign.start, this.topPadded = true})
      : level = 2,
        style = TypeStyles.h2;

  /// create a title with the given text.
  ///
  /// To display text without margins, use `Text` instead.
  const Title.h3(this.text,
      {super.key, this.textAlign = TextAlign.start, this.topPadded = true})
      : level = 3,
        style = TypeStyles.h3;

  /// create a title with the given text.
  ///
  /// To display text without margins, use `Text` instead.
  const Title.h4(this.text,
      {super.key, this.textAlign = TextAlign.start, this.topPadded = true})
      : level = 4,
        style = TypeStyles.h4;

  /// create a title with the given text.
  ///
  /// To display text without margins, use `Text` instead.
  const Title.h5(this.text,
      {super.key, this.textAlign = TextAlign.start, this.topPadded = true})
      : level = 5,
        style = TypeStyles.h5;

  /// create a title with the given text.
  ///
  /// To display text without margins, use `Text` instead.
  const Title.h6(this.text,
      {super.key, this.textAlign = TextAlign.start, this.topPadded = true})
      : level = 6,
        style = TypeStyles.h6;

  @override
  Widget make(context, theme) {
    return Padded.only(
      top: topPadded ? 1.5 + 0.1 * level : 0,
      bottom: 0.6 + 0.1 * level,
      child: Text(text, textAlign: textAlign, style: style),
    );
  }
}
