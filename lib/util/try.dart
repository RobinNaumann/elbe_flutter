import 'dart:async';

T? tryCatch<T>(T Function() worker, [T? Function(dynamic e)? onError]) {
  try {
    return worker();
  } catch (e) {
    return onError?.call(e);
  }
}

Future<T?> tryCatchAsync<T>(FutureOr<T> Function() worker,
    [Future<T?> Function(dynamic e)? onError]) async {
  try {
    return await worker();
  } catch (e) {
    return onError?.call(e);
  }
}

T tryOr<T>(T Function() worker, T onError) {
  try {
    return worker();
  } catch (e) {
    return onError;
  }
}

Future<T> tryOrAsync<T>(FutureOr<T> Function() worker, T onError) async {
  try {
    return await worker();
  } catch (e) {
    return onError;
  }
}
