import '../../../elbe.dart';
import '../../../elbe.dart' as elbe;

extension RemContext on BuildContext {
  double rem([elbe.rem size = 1]) => GeometryTheme.of(this).rem(size);
}

class RemConstraints {
  final double minWidth;
  final double minHeight;
  final double maxWidth;
  final double maxHeight;

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
