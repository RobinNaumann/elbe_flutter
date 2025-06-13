import 'package:elbe/elbe.dart';

/// defines a simple `BitControl`. This allows you to manage global state.
/// Provide a `worker` function that will be called when the bit is first
/// accessed. The `worker` function should return a `FutureOr<V>`. The `V`
/// type is the type of the data that the bit will hold. The Bit will automatically
/// also have a loading state and an error state.
///
/// Provide a BitControl in the context by using the `BitProvider` widget:
/// ```dart
/// BitProvider(
///   create: (context) => YourBit(...);
///   child: ...
/// }
/// ```
/// you can then access the bit in the context using `context.bit<YourBit>()`.
/// You can also use the `BitBuilder` widget to access the bit and build
/// widgets based on the state of the bit.
///
/// ## Tip:
/// It is advised to add a static `PlainBitBuilder builder` to your BitControl.
///
/// ```dart
/// class CounterBit extends SimpleBit<int> {
///    static const builder = PlainBitBuilder<int, CounterBit>.make;
///
///    CounterBit() : super(worker: (_) async => 0);
/// }
/// ```
///
/// This allows you to use it more elegantly:
///
/// ```dart
/// YourBit.builder(
///   onData: (bit, data) => ...
///   onLoading: (bit, loading) => ...
///   onError: (bit, error) => ...
/// )
/// ```
typedef SimpleBit<D> = MapMsgBitControl<D>;
typedef SimpleBitBuilder<D, B extends SimpleBit<D>> = MapMsgBitBuilder<D, B>;
