class RangedIncrementor {
  double _value;
  final double max;
  final double min;

  RangedIncrementor(
      {required double initialValue, required this.max, required this.min})
      : _value = initialValue;

  double get value => _value;

  void increment([double add = 1]) {
    _value += add;
    if (_value > max) {
      _value = max;
    } else if (_value < min) {
      _value = min;
    }
  }

  double operator +(double by) {
    increment(by);
    return value;
  }

  double operator -(double by) {
    increment(-by);
    return value;
  }

  set value(double value) {
    if (value > max) {
      _value = max;
    } else if (value < min) {
      _value = min;
    } else {
      _value = value;
    }
  }
}
