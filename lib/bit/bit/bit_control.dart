import 'dart:async';
import 'dart:core';
import 'dart:math';

import 'package:flutter/scheduler.dart';

import '../../elbe.dart';
import '../../util/json_tools.dart';
import '../../util/m_data.dart';
import 'bit.dart';

part 'bit_builder.dart';
part 'bit_notifier.dart';
part 'bit_provider.dart';
part 'bit_state.dart';

extension BitContext on BuildContext {
  B bit<B extends BitControl>() => BitControl.of<B>(this);
  B? maybeBit<B extends BitControl>() => BitControl.maybeOf<B>(this);
}

typedef MsgBitControl<M, V> = BitControl<M, V, String>;
typedef MsgBit<V> = Bit<V, String>;
typedef MsgBitBuilder<M, V, B extends MsgBitControl<M, V>>
    = BitBuilder<M, V, String, B>;

typedef MapMsgBitControl<V> = MsgBitControl<V, V>;
typedef MapMsgBitBuilder<V, B extends MsgBitControl<V, V>>
    = MsgBitBuilder<V, V, B>;

typedef BitMapper<M, V> = M Function(V value, M? previous);

class BitControl<M, V, L> {
  final M Function(V value, M? previous)? map;
  final Bit<V, L> _bit;
  BitState<M, L> state;
  List<M>? _history;

  final _streamController = StreamController<BitState<M, L>>();
  Stream<BitState<M, L>>? _stream;

  Stream<BitState<M, L>> get stream => _stream != null ? _stream! : _init();

  Stream<BitState<M, L>> _init() {
    _bit.loading.listen((e) => emitLoading(e));
    _bit.result.listen((e) => _emitData(e), onError: (e) => emitError(e));

    //setup the stream
    _stream = _streamController.stream.asBroadcastStream();
    _stream!.listen((e) => state = e);
    reload();
    return _stream!;
  }

  BitControl(this._bit,
      {this.map, M? initial, bool lazy = true, bool history = true})
      : assert(M == V || map != null,
            "BitControl: Add a map function or make sure M = V"),
        _history = history ? [] : null,
        state = initial != null
            ? BitState.data(initial)
            : BitState<M, L>.loading(null) {
    if (!lazy) _init();
  }

  BitControl.worker(BitWorker<V, L> worker,
      {M? initial, bool lazy = true, bool history = true})
      : this(Bit<V, L>(worker), initial: initial, lazy: lazy, history: history);

  void _emitState(BitState<M, L> state, [bool addToHistory = true]) {
    if (_streamController.isClosed) return;
    if (addToHistory && this.state.isData) {
      _history?.add((this.state as _DataBitState<M, L>).data);
    }
    _streamController.add(state);
    onStateChange();
  }

  void dispose() {
    _streamController.close();
    _bit.dispose();
  }

  void reload({bool silent = false}) {
    if (!silent) emitLoading();
    _bit.reload();
  }

  void _emitData(V data) =>
      _emitState(BitState.data(map != null ? map!(data, null) : data as M));
  void emit(M data) => _emitState(BitState.data(data));
  void emitLoading([L? loading]) => _emitState(BitState<M, L>.loading(loading));
  void emitError(dynamic e) => _emitState(BitState.error(e));

  /// Emits the previous state, if [history] is enabled.
  void back() {
    if (_history?.isEmpty ?? true) return;
    _emitState(BitState.data(_history!.removeLast()), false);
  }

  static B? maybeOf<B extends BitControl>(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_TriInherited<B>>()
      ?.provider
      .value as B;

  static B of<B extends BitControl>(BuildContext context) =>
      maybeOf<B>(context) ??
      (throw Exception("cannot find a TriBit of type $B in the context"));

  void onStateChange() {}
}
