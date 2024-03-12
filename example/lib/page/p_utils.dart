import 'package:elbe/elbe.dart';
import 'package:example/main.dart';

class UtilsPage extends StatelessWidget {
  const UtilsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      title: "utilities",
      actions: [
        ColorModeBit.builder(
            onData: (bit, data) => IconButton.integrated(
                icon: data.isDark ? Icons.moon : Icons.sun, onTap: bit.toggle))
      ],
      //leadingIcon: LeadingIcon.back(),
      children: [
        Title.h6("logger"),
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
