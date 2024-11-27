import 'dart:async';
import 'dart:ui';

extension CompleterExt on Completer {
  safeFuture({
    Duration? timeout,
    VoidCallback? onLast,
  }) {
    final realTimeout = timeout ?? const Duration(seconds: 3);
    Timer(realTimeout, () {
      if (onLast != null) {
        onLast();
      }
    });
    return future.withTimeout(realTimeout);
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
