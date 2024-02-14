part of 'bit_control.dart';

abstract class BitState<V, L> extends DataModel {
  const BitState._();
  factory BitState.loading(L? loading) => _LoadingBitState<V, L>(loading);
  factory BitState.error(dynamic e) => _ErrorBitState(e);
  factory BitState.data(V data) => _DataBitState(data);

  bool get isLoading => this is _LoadingBitState<V, L>;
  bool get isError => this is _ErrorBitState<V, L>;
  bool get isData => this is _DataBitState<V, L>;

  bool hasSameData(BitState other) =>
      isData && other.isData && other.hashCode == hashCode;

  R? whenData<R>(R Function(V data) onData) => whenOrNull(onData: onData);

  R when<R>(
          {required R Function(L? loading) onLoading,
          required R Function(dynamic error) onError,
          required R Function(V data) onData}) =>
      this.isData
          ? onData((this as _DataBitState).data)
          : (this.isError
              ? onError((this as _ErrorBitState).e)
              : onLoading((this as _LoadingBitState).loading));

  R? whenOrNull<R>(
          {R Function(L? loading)? onLoading,
          R Function(dynamic error)? onError,
          R Function(V data)? onData}) =>
      when(
          onLoading: onLoading ?? (_) => null,
          onError: onError ?? (_) => null,
          onData: onData ?? (_) => null);
}

class _LoadingBitState<V, L> extends BitState<V, L> {
  final L? loading;
  const _LoadingBitState(this.loading) : super._();
  @override
  JsonMap get map => {};
}

class _ErrorBitState<V, L> extends BitState<V, L> {
  final dynamic e;
  const _ErrorBitState(this.e) : super._();

  @override
  JsonMap get map => {"e": e};
}

class _DataBitState<V, L> extends BitState<V, L> {
  final V data;
  const _DataBitState(this.data) : super._();

  @override
  JsonMap get map => {"data": data};
}
