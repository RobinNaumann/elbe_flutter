import 'package:elbe/elbe.dart';

/// differentiates between light and dark color modes
enum ColorContrasts {
  normal,
  highvis;

  bool get isHighVis => this == ColorContrasts.highvis;
}

class ContrastColorSeed {
  late final SeedModifier normal;
  late final SeedModifier highvis;

  ContrastColorSeed({SeedModifier? normal, SeedModifier? highvis}) {
    this.normal = normal ?? ((path, data, _) => data);

    this.highvis = highvis ??
        normal ??
        ((path, seed, _) => seed.copyWith(
            values: seed.values.copyWith(
                base: seed.values.base.withBorder(seed.values.base.front),
                accent: LayerColor.fromBack(ColorDefs.black))));
  }
}

class ContrastColor extends ModeColor {
  final ModeColor normal;
  final ModeColor highvis;

  ContrastColor({required this.normal, required this.highvis})
      : super.from(normal);

  ModeColor contrast(ColorContrasts contrast) =>
      [normal, highvis][contrast.index];

  ContrastColor.from(ContrastColor c)
      : this(normal: c.normal, highvis: c.highvis);

  factory ContrastColor.generate(List<String> path, ColorThemeSeed seed) =>
      ContrastColor(
        normal: ModeColor.generate([...path], seed),
        highvis: ModeColor.generate([...path, "highvis"], seed),
      );

  @override
  get map => {"normal": normal.map, "highvis": highvis.map};
}
