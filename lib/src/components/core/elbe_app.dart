import '../../../elbe.dart';
import 'package:flutter/material.dart' as m;

class ElbeApp extends StatelessWidget {
  final bool debugShowCheckedModeBanner;
  final ThemeData theme;
  final ColorModes mode;
  final Widget home;
  const ElbeApp(
      {super.key,
      required this.home,
      required this.theme,
      this.mode = ColorModes.light,
      this.debugShowCheckedModeBanner = true});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: theme,
        child: Box.plain(
            mode: mode,
            child: m.MaterialApp(
                theme: m.ThemeData.from(
                    useMaterial3: true,
                    colorScheme: theme.color.copyWith(mode: mode).asMaterial()),

                /* m.ThemeData.from(
                    useMaterial3: true, colorScheme: theme.color.asMaterial()),*/
                debugShowCheckedModeBanner: true,
                home: home)));
  }
}
