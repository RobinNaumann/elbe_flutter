import 'package:elbe/elbe.dart';
import 'package:example/bit/b_theme_seed.dart';

class ThemeEdit extends StatelessWidget {
  const ThemeEdit({super.key});

  Widget _entry({required String label, required Widget child}) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 100, child: Text("$label:")),
          Expanded(child: child)
        ].spaced(),
      );

  @override
  Widget build(BuildContext context) {
    return ThemeSeedBit.builder(onData: (bit, data) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text.h6("Color"),
          _entry(
              label: "mode",
              child: OptionsButton(
                  compact: true,
                  selected: data.mode,
                  items: const [
                    OptionsItem(
                        key: ColorModes.light, icon: Icons.sun, label: "light"),
                    OptionsItem(
                        key: ColorModes.dark, icon: Icons.moon, label: "dark"),
                  ],
                  onSelect: (v) => bit.set(mode: v))),
          _entry(
              label: "primary",
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final e in accentColors)
                      GestureDetector(
                          onTap: () => bit.set(primary: e),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: e,
                                  borderRadius: BorderRadius.circular(20)),
                              width: context.rem(2.5),
                              height: context.rem(2.5),
                              child: data.accent == e
                                  ? const Icon(Icons.check, color: Colors.white)
                                  : null))
                  ].spaced(),
                ),
              )),
          const Text.h6("Typography"),
          _entry(
              label: "title font",
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final e in headerFonts)
                      ToggleButton.custom(
                        showCheck: false,
                        value: data.font == e,
                        onChanged: (v) => bit.set(font: () => e),
                        child: Text(e,
                            resolvedStyle: TypeStyle(
                              variant: TypeVariants.bold,
                              fontFamily: e,
                            )),
                      )
                  ].spaced(),
                ),
              )),
          const Text.h6("Geometry"),
          _entry(
              label: "roundness",
              child: SliderSelect(
                  value: data.borderRadius,
                  max: 30,
                  onChanged: (v) => bit.set(borderRadius: v))),
          _entry(
              label: "border width",
              child: SliderSelect(
                  value: data.borderWidth,
                  max: 5,
                  onChanged: (v) => bit.set(borderWidth: v))),
        ].spaced(),
      );
    });
  }
}
