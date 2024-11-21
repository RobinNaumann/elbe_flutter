import 'package:elbe/elbe.dart';

import '../bit/b_theme_seed.dart';

class UtilsPage extends StatelessWidget {
  const UtilsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      childrenMaxWidth: 40,
      title: "utilities",
      actions: [
        ThemeSeedBit.builder(
            onData: (bit, data) => IconButton.flatPlain(
                icon: data.mode.isDark ? Icons.moon : Icons.sun,
                onTap: bit.toggle))
      ],
      //leadingIcon: LeadingIcon.back(),
      children: [
        const Title.h6("logger"),
        Card(
            scheme: ColorSchemes.inverse,
            child: Text.code("""
log.d(this,"a log message");
"""
                .trim())),
      ],
    );
  }
}
