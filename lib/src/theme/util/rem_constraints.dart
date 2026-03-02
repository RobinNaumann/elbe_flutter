import '../../../elbe.dart' as elbe;
import '../../../elbe.dart';

extension RemContext on BuildContext {
  /// shorthand for `context.theme.geometry.rem(size)`. Use this to get the rem value in pixels.
  /// You can also use this to convert rem values to pixels,
  ///
  /// e.g. `context.rem(2)` will give you the pixel value of 2 rem.
  double rem([elbe.rem size = 1]) => this.theme.geometry.rem(size);
}

class RemConstraints {
  final double minWidth;
  final double minHeight;
  final double maxWidth;
  final double maxHeight;

  /// works like [BoxConstraints] but uses rem units. You can transform this
  /// to a [BoxConstraints] using the [toPixel] method.
  const RemConstraints(
      {this.minWidth = 0,
      this.minHeight = 0,
      this.maxWidth = double.infinity,
      this.maxHeight = double.infinity});

  RemConstraints.tight(Size size)
      : minWidth = size.width,
        maxWidth = size.width,
        minHeight = size.height,
        maxHeight = size.height;

  RemConstraints.loose(Size size)
      : minWidth = 0.0,
        maxWidth = size.width,
        minHeight = 0.0,
        maxHeight = size.height;

  BoxConstraints toPixel(BuildContext context) {
    final rem = context.rem;
    return BoxConstraints(
        minWidth: rem(minWidth),
        minHeight: rem(minHeight),
        maxWidth: rem(maxWidth),
        maxHeight: rem(maxHeight));
  }
}
