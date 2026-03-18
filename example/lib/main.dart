import 'package:elbe/elbe.dart';
import 'package:example/routes.dart';

import 'bit/b_theme_seed.dart';

void main() => runApp(_App());

class _App extends StatelessWidget {
  _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BitProvider(
      create: (_) => ThemeSeedBit(),
      child: ThemeSeedBit.builder(
        onData: (bit, data) => ElbeApp(
          initialRoute: "/home",
          routes: appRoutes,
          mode: data.mode,
          debugShowCheckedModeBanner: false,
          theme: ElbeThemeData.preset(
              type: TypeThemeData.preset(
                  titleFont: data.font, titleVariant: TypeVariants.bold),
              geometry: GeometryThemeData.preset(
                  borderRadius: data.borderRadius,
                  borderWidth: data.borderWidth),
              color: ColorThemeData.preset(
                  values: ColorThemeValues(
                      accent: LayerColor.fromBack(data.accent)))),
        ),
      ));
}
