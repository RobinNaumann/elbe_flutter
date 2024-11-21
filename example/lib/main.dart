import 'package:elbe/elbe.dart';
import 'package:example/routes.dart';

void main() => runApp(_App());

class _App extends StatelessWidget {
  _App({Key? key}) : super(key: key);

  final GoRouter _appRouter = GoRouter(routes: appRoutes);

  final t = ThemeData.preset();

  @override
  Widget build(BuildContext context) =>
      BitBuildProvider<ColorModes, ColorModes, String, ColorModeBit>(
          create: (_) => ColorModeBit(),
          onData: (_, d) => ElbeApp(
                router: _appRouter,
                mode: d,
                debugShowCheckedModeBanner: false,
                theme: t,
              ));
}

class ColorModeBit extends MapMsgBitControl<ColorModes> {
  static const builder = MapMsgBitBuilder<ColorModes, ColorModeBit>.make;
  ColorModeBit()
      : super.worker((w) => ColorModes.light, initial: ColorModes.light);

  void toggle() => state.whenOrNull(onData: (d) {
        emit(d == ColorModes.light ? ColorModes.dark : ColorModes.light);
      });
}
