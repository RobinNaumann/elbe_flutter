import 'package:elbe/elbe.dart';

import '../view/v_section.dart';

class _ColorCard extends StatelessWidget {
  final ColorSchemes? scheme;
  final ColorKinds? kind;
  final ColorManners? manner;
  final ColorStates? state;
  final Enum current;
  final bool showName;
  final VoidCallback onTap;

  const _ColorCard({
    super.key,
    required this.current,
    required this.showName,
    required this.onTap,
    this.scheme,
    this.kind,
    this.manner,
    this.state,
  });

  @override
  Widget build(BuildContext context) {
    final name = (state ?? manner ?? kind ?? scheme)?.name ?? "-";
    final icon = Icon((name == current.name) ? Icons.check : null);
    return AnimatedSize(
        duration: const Duration(milliseconds: 200),
        child: Card(
            onTap: onTap,
            scheme: scheme ?? ColorSchemes.primary,
            kind: kind,
            manner: manner,
            state: state,
            width: showName ? 11 : 4,
            height: 4,
            child: !showName
                ? Center(child: icon)
                : Row(
                    children: [
                      icon,
                      Expanded(child: Text(name)),
                    ].spaced(),
                  )));
  }
}

class ColorView extends StatefulWidget {
  const ColorView({super.key});

  @override
  State<ColorView> createState() => _ColorViewState();
}

class _ColorViewState extends State<ColorView> {
  ColorModes mode = ColorModes.light;
  ColorSchemes scheme = ColorSchemes.secondary;
  ColorKinds kind = ColorKinds.accent;
  ColorManners manner = ColorManners.major;
  ColorStates state = ColorStates.neutral;

  @override
  Widget build(BuildContext context) => SectionView(
      initial: const {"show_names": false},
      title: "Colors",
      about:
          "this describes the color palette used by elbe. the following definitions define a tree structure. This allows for good contrast and readability.",
      code: (_) => """
Card(
  scheme: ColorSchemes.primary,
  style: ColorStyles.majorAccent,
  state: ColorStates.disabled,
  child: Text("colors"),
);
""",
      child: (get, __) {
        final n = get("show_names");
        return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text.h6("mode"),
              const Text(
                  "use the IconButton in the TitleBar to switch between light and dark mode"),
              const Text.h6("scheme"),
              Wrap(
                  runSpacing: context.rem(1),
                  spacing: context.rem(1),
                  children: [
                    for (final s in ColorSchemes.values)
                      _ColorCard(
                        onTap: () => setState(() => scheme = s),
                        current: scheme,
                        showName: n,
                        scheme: s,
                      )
                  ]),
              const Text.h6("kind"),
              Wrap(
                  runSpacing: context.rem(1),
                  spacing: context.rem(1),
                  children: [
                    for (final k in ColorKinds.values)
                      _ColorCard(
                        onTap: () => setState(() => kind = k),
                        current: kind,
                        showName: n,
                        scheme: scheme,
                        kind: k,
                      )
                  ]),
              const Text.h6("manner"),
              Wrap(
                  runSpacing: context.rem(1),
                  spacing: context.rem(1),
                  children: [
                    for (final m in ColorManners.values)
                      _ColorCard(
                          onTap: () => setState(() => manner = m),
                          current: manner,
                          showName: n,
                          scheme: scheme,
                          kind: kind,
                          manner: m)
                  ]),
              const Text.h6("state"),
              Wrap(
                  runSpacing: context.rem(1),
                  spacing: context.rem(1),
                  children: [
                    for (final s in ColorStates.values)
                      _ColorCard(
                          onTap: () => setState(() => state = s),
                          current: state,
                          showName: n,
                          scheme: scheme,
                          kind: kind,
                          manner: manner,
                          state: s)
                  ]),
            ].spaced());
      });
}
