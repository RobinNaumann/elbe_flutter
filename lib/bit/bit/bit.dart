import 'dart:async';

import 'package:flutter/scheduler.dart';

typedef Maybe<T> = T? Function();

void postFrame(Function() f) =>
    SchedulerBinding.instance.addPostFrameCallback((_) => f());

T? maybeOr<T>(Maybe<T>? maybe, T? or) => maybe != null ? maybe() : or;

extension MaybeExt<T> on Maybe<T> {
  T orElse(T Function() orElse) => this() ?? orElse();
}

class _BitEntry<R, L> {
  final R Function()? result;
  final L Function()? loading;
  const _BitEntry.result(this.result) : loading = null;
  const _BitEntry.loading(this.loading) : result = null;
}

typedef BitWorker<V, L> = FutureOr<V> Function(Function(L updateValue) update);
typedef BitStreamWorker<V, L> = FutureOr<Stream<V>> Function(
    Function(L updateValue) update);

class Bit<R, L> {
  final BitWorker<R, L>? worker;
  final BitStreamWorker<R, L>? streamWorker;
  final Function()? _onDispose;
  StreamSubscription? _workerSubscription;
  final StreamController<_BitEntry<R, L>> _streamCtrl =
      StreamController.broadcast();

  late final Stream<L> loading = _streamCtrl.stream
      .where((e) => e.loading != null)
      .map((e) => e.loading!())
      .asBroadcastStream();

  late final Stream<R> result = _streamCtrl.stream
      .where((e) => e.result != null)
      .map((e) => e.result!())
      .asBroadcastStream();

  late final Future<R> asFuture = _getValue();

  Future<R> _getValue() async {
    final res = await _streamCtrl.stream.firstWhere((e) => e.result != null);
    return res.result!();
  }

  void update(L loadingValue) =>
      _addEvent(_BitEntry.loading(() => loadingValue));

  void resolve(R value) => _addEvent(_BitEntry.result(() => value));

  void _addEvent(_BitEntry<R, L> v) =>
      _streamCtrl.isClosed ? null : _streamCtrl.add(v);

  void reload() async {
    try {
      if (worker == null && streamWorker == null) {
        throw Exception('worker or streamWorker must be defined');
      }
      if (worker != null) {
        resolve(await worker!((v) => update(v)));
        return;
      }
      _workerSubscription = (await streamWorker!(update))
          .listen(resolve, onError: (e) => _streamCtrl.addError(e));
    } catch (e) {
      if (!_streamCtrl.isClosed) _streamCtrl.addError(e);
    }
  }

  Bit(BitWorker<R, L> this.worker)
      : streamWorker = null,
        _onDispose = null {
    reload();
  }

  Bit.stream(BitStreamWorker<R, L> this.streamWorker, {Function()? onDispose})
      : worker = null,
        _onDispose = onDispose {
    reload();
  }

  dispose() {
    _streamCtrl.close();
    _workerSubscription?.cancel();
    _onDispose?.call();
  }
}
