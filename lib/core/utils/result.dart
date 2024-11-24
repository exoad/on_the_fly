/// Good enough for my usecases hahaha
final class Result<A, E /*usually this is a string*/ > {
  final A payload;
  final E? message;
  final bool _good;

  Result._(this.payload, this.message, this._good);

  factory Result.good(A payload, [E? message]) =>
      Result<A, E>._(payload, message, true);

  factory Result.bad(A payload, E message) =>
      Result<A, E>._(payload, message, false);

  bool get isGood => _good;

  bool get isBad => !_good;
}
