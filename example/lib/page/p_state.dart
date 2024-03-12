import 'package:elbe/elbe.dart';
import 'package:example/main.dart';

class StatePage extends StatelessWidget {
  const StatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      title: "state",
      actions: [
        ColorModeBit.builder(
            onData: (bit, data) => IconButton.integrated(
                icon: data.isDark ? Icons.moon : Icons.sun, onTap: bit.toggle))
      ],
      //leadingIcon: LeadingIcon.back(),
      children: [
        Text(
            "elbe contains a simple state management system called 'bit'. It has a simmilar API to the 'provider' package, but with a more minimalistic approach. Each state can be in one of 3 modes: 'data' 'error' and 'loading'. In addition, bit also allows to react to stream changes and keeps a history of prior states."),
        Title.h6("define a bit"),
        Card(
            scheme: ColorSchemes.inverse,
            child: Text.code("""
class CountBit extends MapMsgBitControl<int> {
  static const builder = MapMsgBitBuilder<int, CountBit>.make;
  ColorModeBit() : super.worker((_) => 0);

  void add() => state.whenOrNull(onData: (d) => emit(d + 1),
}
"""
                .trim())),
        Title.h6("provide a bit"),
        Card(
            scheme: ColorSchemes.inverse,
            child: Text.code("""
BitProvider<CountBit>(
  create: (_) => CountBit(),
  child: ...,
)
"""
                .trim())),
        Title.h6("use a bit"),
        Card(
            scheme: ColorSchemes.inverse,
            child: Text.code("""
CountBit.builder(
  onData: (bit, data) => Text('\$data'),
)
"""
                .trim())),
      ],
    );
  }
}
