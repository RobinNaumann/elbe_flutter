
/*
typedef CounterTriProvider = TriProvider<int, CounterTribit>;
typedef CounterTriBuilder = TriBuilder<int, CounterTribit>;

typedef LetterTriProvider = TriProvider<String, LetterTribit>;
typedef LetterTriBuilder = TriBuilder<String, LetterTribit>;

class LetterTribit extends TriBit<String> {
  LetterTribit()
      : super(
            worker: () async =>
                await Future.delayed(const Duration(seconds: 3), () => "A"));

  void add() => state.whenOrNull(onData: (v) => emit("$v+"));
}

class CounterTribit extends TriBit<int> {
  CounterTribit()
      : super(
            worker: () async =>
                await Future.delayed(const Duration(seconds: 3), () => 42));

  void add() => state.whenOrNull(onData: (v) => emit(v + 1));
}

class TribitDemo extends StatelessWidget {
  const TribitDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        title: "Tribit Demo",
        body: Padded.all(
            child: CounterTriProvider(
                create: (_) => CounterTribit(),
                child: CounterTriBuilder(
                  onData: (bit, number) => Column(
                    children: [
                      Button.action(label: "reload", onTap: () => bit.reload()),
                      Button.action(label: "$number", onTap: () => bit.add()),
                      Expanded(
                          child: Card(
                              child: CounterTriProvider.value(
                                  value: bit,
                                  child: CounterTriBuilder(
                                      onData: (bit, number) =>
                                          Text("by value: $number"))))),
                      Expanded(
                          child: LetterTriProvider(
                              create: (_) => LetterTribit(),
                              child: LetterTriBuilder(
                                  onData: (bit, v) => Button.action(
                                      label: "$number $v",
                                      onTap: () => bit.add()))))
                    ],
                  ),
                ))));
  }
}
*/