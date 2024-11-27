import 'dart:async';

extension CompleterExt on Completer {
  safeFuture(Duration? timeout) {
    return future.withTimeout(timeout ?? const Duration(seconds: 3));
  }
}

extension FutureExt<T> on Future<T> {
  withTimeout(Duration timeout) {
    return this.timeout(
      timeout,
      onTimeout: () => throw TimeoutException(
        "Operation timed out after ${timeout.inSeconds} seconds",
        timeout,
      ),
    );
  }
}
