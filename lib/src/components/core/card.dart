import '../../../elbe.dart';
import 'maybe_hero.dart';

class Card extends ThemedWidget {
  final Clip? clipBehavior;
  final ColorSchemes scheme;
  final ColorStyles? style;
  final ColorStates? state;

  final RemInsets? margin;
  final RemInsets? padding;
  final RemConstraints? constraints;
  final Border? border;
  final double? height;
  final double? width;

  final Color? color;

  final VoidCallback? onTap;
  final VoidCallback? onLongTap;
  final String? heroTag;

  final Widget child;

  const Card(
      {super.key,
      this.clipBehavior = Clip.antiAlias,
      this.scheme = ColorSchemes.primary,
      this.style,
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
      required this.child});

  Widget _card(ThemeData theme) => MaybeHero(
        tag: heroTag,
        child: Box(
            scheme: scheme,
            style: style,
            state: state,
            clipBehavior: clipBehavior,
            width: width,
            height: height,
            padding: padding,
            margin: margin,
            constraints: constraints,
            border: border ?? theme.geometry.border,
            color: color,
            child: child),
      );

  @override
  Widget make(context, theme) => onTap != null
      ? InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: onTap,
          onLongPress: onLongTap,
          child: _card(theme))
      : _card(theme);
}
