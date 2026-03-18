import '../../../elbe.dart';
import 'maybe_hero.dart';

/// a card is an interactive box with styling and geometry options
class Card extends StatelessWidget {
  final Clip? clipBehavior;
  final ColorSchemes? scheme;
  final ColorKinds? kind;
  final ColorManners? manner;
  final ColorStates? state;

  final RemInsets? margin;
  final RemInsets? padding;
  final RemConstraints? constraints;
  final Border? border;
  final double? height;
  final double? width;
  final int? flex;

  final Color? color;
  final double? radius;

  /// you can also use [radius] for a simple border radius, which will be merged with the theme's geometry settings.
  final BorderRadius? borderRadius;

  final VoidCallback? onTap;
  final VoidCallback? onLongTap;
  final String? heroTag;

  final Widget child;

  /// create a card by providing all properties. Cards are interactive boxes
  /// with styling and geometry options
  ///
  /// The style parameters will be merged with the current color scheme. This
  /// is also applied to child widgets.
  const Card(
      {super.key,
      this.clipBehavior,
      this.scheme,
      this.kind,
      this.manner,
      this.state,
      this.margin,
      this.color,
      this.padding = const RemInsets.all(1),
      this.constraints,
      this.border,
      this.width,
      this.height,
      this.onTap,
      this.onLongTap,
      this.heroTag,
      this.radius,
      this.borderRadius,
      this.flex,
      required this.child});

  Widget _card(ElbeThemeData theme) => MaybeHero(
        tag: heroTag,
        child: Box(
            scheme: scheme,
            kind: kind,
            manner: manner,
            state: state,
            clipBehavior: clipBehavior,
            width: width,
            height: height,
            padding: padding,
            margin: margin,
            constraints: constraints,
            border: border ?? const Border(width: 0),
            color: color,
            radius: radius,
            borderRadius: borderRadius,
            flex: flex,
            child: child),
      );

  @override
  Widget build(BuildContext context) => onTap != null
      ? GestureDetector(
          onTap: onTap, onLongPress: onLongTap, child: _card(context.theme))
      : _card(context.theme);
}
