import 'package:x25519/src/number/stub.dart'
// ignore: uri_does_not_exist
    if (dart.library.io) 'package:x25519/src/number/int.dart'
// ignore: uri_does_not_exist
    if (dart.library.html) 'package:x25519/src/number/int64.dart';

abstract class Number {
  dynamic get val;

  int get intValue;

  Number operator +(Number value);

  Number operator -(Number value);

  Number operator -();

  Number operator *(Number value);

  Number operator &(Number value);

  Number operator >>(int value);

  Number operator <<(int value);

  Number operator ^(Number value);

  Number operator |(Number value);

  bool operator <(Number value);

  bool operator >(Number value);

  factory Number(int val) => createNumber(val);

  static Number zero = Number(0);
  static Number one = Number(1);
  static Number two = Number(2);
  static Number v19 = Number(19);
  static Number v38 = Number(38);
  static Number v64 = Number(64);
  static Number v127 = Number(127);
  static Number v248 = Number(248);
  static Number v121666 = Number(121666);
  static Number v0x7fffff = Number(0x7fffff);

}
