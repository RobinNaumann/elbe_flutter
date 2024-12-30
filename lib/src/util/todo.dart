import 'package:elbe/elbe.dart';

/// Visual indicator that a part of the app is still in development
///
/// This should not be included in the final app
class ToDo extends StatelessWidget {
  final String message;
  final bool shrink;
  final RemConstraints? size;

  /// Creates a visual indicator that a part of the app is still in development
  ///
  /// This should not be included in the final app
  const ToDo(this.message, {super.key})
      : shrink = false,
        size = null;
  const ToDo._shrink(this.message, {super.key})
      : shrink = true,
        size = null;

  /// creates a visual indicator that a part of the app is still in development
  /// with a pre-determined size
  ///
  /// This should not be included in the final app
  const ToDo.sized(this.size, this.message, {super.key, this.shrink = true});

  Widget _text() => Text.bodyS(message,
      maxLines: 7, overflow: TextOverflow.ellipsis, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    final radius = GeometryTheme.of(context).border.borderRadius;
    return Container(
        constraints: size?.toPixel(context),
        decoration: BoxDecoration(
          color: const Color(0xFFDAA5E4),
          borderRadius: radius,
        ),
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            if (size != null)
              ClipRRect(
                borderRadius: radius ?? BorderRadius.circular(0),
                child: Placeholder(
                  fallbackHeight: 0,
                  fallbackWidth: 0,
                  color: Colors.purple.shade200,
                ),
              ),
            Padded.symmetric(
              vertical: .5,
              horizontal: .75,
              child: Wrap(
                spacing: context.rem(0.125),
                runSpacing: context.rem(0.125),
                children: [
                  Icon(Icons.clipboardCheck,
                      style: TypeStyles.bodyS, color: Colors.black),
                  Text.bodyS("ToDo:",
                      variant: TypeVariants.bold, color: Colors.black),
                  shrink ? _text() : Expanded(child: _text())
                ],
              ),
            ),
          ],
        ));
  }
}
