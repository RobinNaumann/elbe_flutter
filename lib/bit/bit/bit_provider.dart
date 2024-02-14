part of 'bit_control.dart';

class BitBuildProvider<M, V, L, B extends BitControl<M, V, L>>
    extends StatelessWidget {
  final B? value;
  final B Function(BuildContext context)? create;

  final Widget Function(B bit, L? loading)? onLoading;
  final Widget Function(B bit, dynamic error)? onError;
  final Widget Function(B bit, M data) onData;
  final bool small = false;

  const BitBuildProvider(
      {super.key,
      this.value,
      this.onLoading,
      this.onError,
      required this.onData,
      required this.create});

  @override
  Widget build(BuildContext context) => BitProvider.adaptive(
      value: value,
      create: create,
      child: BitBuilder(
          onData: onData,
          onLoading: onLoading,
          onError: onError,
          small: small));
}

class BitProvider<B extends BitControl> extends StatefulWidget {
  final B? value;
  final B Function(BuildContext context)? create;
  final Widget? child;

  const BitProvider(
      {super.key,
      required B Function(BuildContext context) this.create,
      required this.child})
      : value = null;

  const BitProvider.value({super.key, required this.value, required this.child})
      : create = null;

  const BitProvider.adaptive(
      {super.key,
      required this.value,
      required this.create,
      required this.child});

  @override
  createState() => _BitProviderState<B>();
}

class _BitProviderState<B extends BitControl> extends State<BitProvider<B>> {
  late B? _value = widget.value;

  B get value => _value ?? (_value = widget.create!(context));

  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    // only dispose the TriBit if this is the creating provider
    if (widget.value == null) _value?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _TriInherited<B>(provider: this, child: widget.child ?? Spaced.zero);
}

class _TriInherited<B extends BitControl> extends InheritedWidget {
  final _BitProviderState provider;

  const _TriInherited({required this.provider, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
