/// Good enough for my usecases hahaha
///
/// a basic type that operates similar on java's optional type
/// which allows for a more explicit and strongly typed value
/// rather than just a nullable type (Type?)
final class Result<A, E /*usually this is a string*/ > {
  final A? _payload;
  final E? message;
  final bool _good; // bum

  Result._(this._payload, this.message, this._good);

  /// good job :D
  factory Result.good(A payload, [E? message]) =>
      Result<A, E>._(payload, message, true);

  /// bad job >:(
  factory Result.bad(E message) => Result<A, E>._(null, message, false);

  A get payload {
    if (_payload == null || !_good) {
      throw const _BadResultException("payload is not available!");
    }
    return _payload;
  }

  bool get isGood => _good;

  bool get isBad => !_good;
}

final class _BadResultException implements Exception {
  final String message;
  const _BadResultException(this.message);

  @override
  String toString() => "BadResult: $message";
}
