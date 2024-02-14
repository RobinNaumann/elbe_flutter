part of 'bit_control.dart';

class BitNotifier<M, V, L, B extends BitControl<M, V, L>>
    extends StatefulWidget {
  final Function(B bit, L? loading)? onLoading;
  final Function(B bit, dynamic error)? onError;
  final Function(B bit, M data)? onData;
  final Widget child;
  const BitNotifier(
      {super.key,
      this.onLoading,
      this.onError,
      this.onData,
      required this.child});

  factory BitNotifier.make(
          {Key? key,
          Function(B bit, L? loading)? onLoading,
          Function(B bit, dynamic error)? onError,
          Function(B bit, M data)? onData,
          required Widget child}) =>
      BitNotifier(
          key: key,
          onLoading: onLoading,
          onError: onError,
          onData: onData,
          child: child);

  @override
  State<BitNotifier<M, V, L, B>> createState() =>
      _BitNotifierState<M, V, L, B>();
}

class _BitNotifierState<M, V, L, B extends BitControl<M, V, L>>
    extends State<BitNotifier<M, V, L, B>> {
  StreamSubscription? streamSub;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  _init() {
    if (streamSub != null) return;
    final bit = BitControl.of<B>(context);
    streamSub = bit.stream.listen((e) => _notify(bit, e));
    _notify(bit, bit.state);
  }

  _notify(B bit, BitState<M, L> s) => s.when(
      onLoading: (l) => widget.onLoading?.call(bit, l),
      onError: (e) => widget.onError?.call(bit, e),
      onData: (d) => widget.onData?.call(bit, d));

  @override
  void dispose() {
    streamSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
