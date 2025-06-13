import 'package:elbe/elbe.dart';
import 'package:example/view/v_section.dart';

import '../bit/b_theme_seed.dart';
import 'v_color.dart';

class ThemingPage extends StatelessWidget {
  const ThemingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      childrenMaxWidth: 40,
      title: "theming",
      actions: [
        ThemeSeedBit.builder(
            onData: (bit, data) => IconButton.flatPlain(
                icon: data.mode.isDark ? Icons.moon : Icons.sun,
                onTap: bit.toggle))
      ],
      //leadingIcon: LeadingIcon.back(),
      children: const [
        ColorView(),
        _TypeView(),
        _GeometryView(),
      ],
    );
  }
}

class _TypeView extends StatelessWidget {
  const _TypeView();

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${s.name} text",
                      style: s,
                      variant: get("bold")
                          ? (get("italic")
                              ? TypeVariants.boldItalic
                              : TypeVariants.bold)
                          : (get("italic") ? TypeVariants.italic : null)),
                  Icon(Icons.leaf, style: s),
                ],
              ),
          ]));
}

class _GeometryView extends StatelessWidget {
  const _GeometryView();

  @override
  Widget build(BuildContext context) => SectionView(
      title: "Geometry",
      about:
          "defines the spacing within the application. It is based on the rem unit. This makes it easier to adapt scaling to different needs.",
      initial: const {"larger": false},
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
