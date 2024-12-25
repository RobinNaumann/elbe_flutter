import 'package:elbe/elbe.dart';
import 'package:example/routes.dart';

import 'bit/b_theme_seed.dart';

void main() => runApp(_App());

class _App extends StatelessWidget {
  _App({Key? key}) : super(key: key);

  final GoRouter _appRouter = GoRouter(routes: appRoutes);

  @override
  Widget build(BuildContext context) => BitProvider(
      create: (_) => ThemeSeedBit(),
      child: ThemeSeedBit.builder(
        onData: (bit, data) => ElbeApp(
          router: _appRouter,
          mode: data.mode,
          debugShowCheckedModeBanner: false,
          theme: ThemeData.preset(
              titleVariant: TypeVariants.bold,
              titleFont: data.font,
              border: Border(
                borderRadius: BorderRadius.circular(data.borderRadius),
                pixelWidth: data.borderWidth,
              ),
              colorSeed:
                  ColorSeed.make(accent: LayerColor.fromBack(data.accent))),
        ),
      ));
}
