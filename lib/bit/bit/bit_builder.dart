part of 'bit_control.dart';

class BitBuilder<M, V, L, B extends BitControl<M, V, L>>
    extends StatelessWidget {
  final Widget Function(B bit, L? loading)? onLoading;
  final Widget Function(B bit, dynamic error)? onError;
  final Widget Function(B bit, M data) onData;

  final bool small;
  const BitBuilder(
      {super.key,
      this.onLoading,
      this.onError,
      required this.onData,
      this.small = false});

  factory BitBuilder.make(
          {Key? key,
          Widget Function(B bit, L? loading)? onLoading,
          Widget Function(B bit, dynamic error)? onError,
          required Widget Function(B bit, M data) onData,
          bool small = false}) =>
      BitBuilder(
          key: key,
          onLoading: onLoading,
          onError: onError,
          onData: onData,
          small: small);

  @override
  Widget build(BuildContext context) {
    final bit = BitControl.of<B>(context);

    return StreamBuilder<BitState<M, L>>(
        initialData: bit.state,
        stream: bit.stream,
        builder: (c, s) {
          final state = s.data!;
          return state.when(
              onLoading: (l) =>
                  onLoading?.call(bit, l) ??
                  (small ? bitEmptyView() : bitLoadingView(bit)),
              onError: (e) =>
                  onError?.call(bit, e) ??
                  (small ? bitEmptyView() : bitErrorView(bit, e)),
              onData: (d) => onData(bit, d));
        });
  }
}

Widget bitEmptyView() => const SizedBox.shrink();
Widget bitEmpty(dynamic _, dynamic __) => const SizedBox.shrink();

Widget bitErrorView(BitControl bit, dynamic error) =>
    Center(child: BitErrorView(bit: bit, error: error));

Widget bitLoadingView(BitControl bit) => Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator.adaptive(),
          if (bit is MsgBitControl)
            Padded.only(
                top: 1,
                child: Box(
                  constraints: const RemConstraints(maxWidth: 20),
                  color: Colors.transparent,
                  border: Border.noneRect,
                  child: Text(
                      bit.state.whenOrNull<String?>(onLoading: (l) => l) ?? "",
                      textAlign: TextAlign.center),
                ))
        ]));
