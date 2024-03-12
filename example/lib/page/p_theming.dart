import 'package:elbe/elbe.dart';
import 'package:example/main.dart';
import 'package:example/page/p_components.dart';
import 'package:example/view/v_section.dart';

class ThemingPage extends StatelessWidget {
  const ThemingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      title: "theming",
      actions: [
        ColorModeBit.builder(
            onData: (bit, data) => IconButton.integrated(
                icon: data.isDark ? Icons.moon : Icons.sun, onTap: bit.toggle))
      ],
      //leadingIcon: LeadingIcon.back(),
      children: const [
        _ColorView(),
        _TypeView(),
        _GeometryView(),
      ],
    );
  }
}

class _ColorView extends StatelessWidget {
  const _ColorView({super.key});

  @override
  Widget build(BuildContext context) => SectionView(
      initial: {"show_names": false},
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
              const Text.h6("scheme"),
              Wrap(
                runSpacing: context.rem(1),
                spacing: context.rem(1),
                children: [
                  for (final s in ColorSchemes.values)
                    AnimatedSize(
                        duration: const Duration(milliseconds: 200),
                        child: Card(
                            scheme: s,
                            width: n ? 11 : 3.5,
                            height: 3.5,
                            border: Border.noneRect,
                            child: n ? Text(s.name) : Spaced.zero))
                ],
              ),
              const Text.h6("style"),
              Wrap(
                  runSpacing: context.rem(1),
                  spacing: context.rem(1),
                  children: [
                    for (final s in ColorStyles.values)
                      AnimatedSize(
                        duration: const Duration(milliseconds: 200),
                        child: Card(
                            style: s,
                            width: n ? 11 : 3.5,
                            height: 3.5,
                            border: Border.noneRect,
                            child: n ? Text(s.name) : Spaced.zero),
                      )
                  ]),
              const Text.h6("state"),
              Wrap(
                runSpacing: context.rem(1),
                spacing: context.rem(1),
                children: [
                  for (final s in ColorStates.values)
                    AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      child: Card(
                          style: ColorStyles.majorAccent,
                          state: s,
                          width: n ? 11 : 3.5,
                          height: 3.5,
                          border: Border.noneRect,
                          child: n ? Text(s.name) : Spaced.zero),
                    ),
                ],
              ),
              const Text.h6("layer"),
              Wrap(
                runSpacing: context.rem(1),
                spacing: context.rem(1),
                children: [
                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: Card(
                        color: ColorTheme.of(context).activeLayer.back,
                        width: n ? 11 : 3.5,
                        height: 3.5,
                        border: Border.noneRect,
                        child: n ? Text("back") : Spaced.zero),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: Card(
                        color: ColorTheme.of(context).activeLayer.front,
                        width: n ? 11 : 3.5,
                        height: 3.5,
                        border: Border.noneRect,
                        child: n
                            ? Text("front",
                                color: ColorTheme.of(context).activeLayer.back)
                            : Spaced.zero),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: Card(
                        color: ColorTheme.of(context).activeLayer.border,
                        width: n ? 11 : 3.5,
                        height: 3.5,
                        border: Border.noneRect,
                        child: n ? Text("border") : Spaced.zero),
                  )
                ],
              ),
            ].spaced());
      });
}

class _TypeView extends StatelessWidget {
  const _TypeView({super.key});

  @override
  Widget build(BuildContext context) => SectionView(
      title: "Typography",
      about: "define the way written content is displayed",
      initial: {"bold": false, "italic": false},
      code: (s) => """
Text("hello", 
  style: TypeStyles.bodyS,
  variant: TypeVariants.bold,
);
""",
      child: (get, _) =>
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            for (final s in TypeStyles.values)
              Text("${s.name} text",
                  style: s,
                  variant: get("bold")
                      ? (get("italic")
                          ? TypeVariants.boldItalic
                          : TypeVariants.bold)
                      : (get("italic") ? TypeVariants.italic : null)),
          ]));
}

class _GeometryView extends StatelessWidget {
  const _GeometryView({super.key});

  @override
  Widget build(BuildContext context) => SectionView(
      title: "Geometry",
      about:
          "defines the spacing within the application. It is based on the rem unit. This makes it easier to adapt scaling to different needs.",
      initial: {"larger": false},
      code: (s) => """
Padded.all(child: Text("padded"));
Spaced.vertical(1);
Spaced.zero;

// get rem size
context.rem();
""",
      child: (get, _) => GeometryTheme(
            data: GeometryThemeData.preset(remSize: get("larger") ? 32 : 16),
            child: Box(
                scheme: ColorSchemes.secondary,
                padding: RemInsets.all(1),
                border: Border.noneRect,
                child: Row(
                  children: [
                    Box(
                        scheme: ColorSchemes.inverse,
                        padding: RemInsets.all(1),
                        border: Border.noneRect,
                        child: Spaced.zero),
                    Spaced.horizontal(),
                    Box(
                        scheme: ColorSchemes.inverse,
                        padding: RemInsets.all(1),
                        border: Border.noneRect,
                        child: Spaced.zero),
                    Spaced.horizontal(),
                    Text("box"),
                  ],
                )),
          ));
}
