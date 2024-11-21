import '../../../elbe.dart';

/// A widget that adds padding to its child.
class Padded extends StatelessWidget {
  final Widget child;
  final RemInsets padding;
  const Padded({super.key, required this.padding, required this.child});

  /// add padding to all sides of the child
  Padded.all({super.key, double value = 1, required this.child})
      : padding = RemInsets.all(value);

  /// add padding to only specific sides of the child
  Padded.only(
      {super.key,
      double left = 0,
      double top = 0,
      double right = 0,
      double bottom = 0,
      required this.child})
      : padding = RemInsets.fromLTRB(left, top, right, bottom);

  /// add padding to the vertical and horizontal sides of the child
  Padded.symmetric(
      {super.key,
      double vertical = 0,
      double horizontal = 0,
      required this.child})
      : padding =
            RemInsets.fromLTRB(horizontal, vertical, horizontal, vertical);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: padding.toPixel(context), child: child);
  }
}
