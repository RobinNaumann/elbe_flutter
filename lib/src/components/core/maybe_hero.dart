import '../../../elbe.dart';

class MaybeHero extends StatefulWidget {
  final Widget? child;
  final Widget Function(bool traveling)? builder;
  final String? tag;
  final Widget Function(BuildContext, Animation<double>, HeroFlightDirection,
      BuildContext, BuildContext)? flightShuttleBuilder;
  const MaybeHero(
      {super.key,
      required this.tag,
      this.child,
      this.builder,
      this.flightShuttleBuilder})
      : assert((child != null) ^ (builder != null),
            "MaybeHero: provide exactly one of child, builder");

  @override
  State<MaybeHero> createState() => _MaybeHeroState();
}

class _MaybeHeroState extends State<MaybeHero> {
  bool traveling = true;

  @override
  Widget build(BuildContext context) => widget.tag != null
      ? Hero(
          tag: widget.tag!,
          flightShuttleBuilder: (_, animation, ___, ____, _____) {
            animation.addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                setState(() => traveling = false);
              }
            });
            return Material(
                color: Colors.transparent,
                elevation: 0,
                child: widget.builder?.call(true) ?? widget.child!);
          },
          child: widget.builder?.call(traveling) ?? widget.child!)
      : widget.builder?.call(false) ?? widget.child!;
}
