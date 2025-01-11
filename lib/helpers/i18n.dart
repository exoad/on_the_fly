import 'package:on_the_fly/shared/app.dart';

class LocaleProducer {
  final String _value;
  final bool _isKey;

  LocaleProducer._(this._isKey, this._value);

  factory LocaleProducer.raw(String value) => LocaleProducer._(false, value);

  factory LocaleProducer.key(String value) => LocaleProducer._(true, value);

  String get value => _isKey ? localeMap[_value]! : _value;

  bool get isKey => _isKey;
}
