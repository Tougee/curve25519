import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:x25519/x25519.dart';
import 'package:test/test.dart';
import 'package:hex/hex.dart';

import 'vectors_test.dart';

const expectedHex =
    '89161fde887b2b53de549af483940106ecc114d6982daa98256de23bdf77661a';

void main() {
  test('testX25519Basepoint', () {
    var x = List<int>.filled(32, 0);
    x[0] = 1;

    for (var i = 0; i < 200; i++) {
      x = X25519(x, basePoint);
    }
    assert(HEX.encode(x) == expectedHex);
  });

  test('testLowOrderPoints', () {
    var scalar = List<int>.filled(ScalarSize, 0);
    for (var i = 1; i < lowOrderPoints.length; i++) {
      try {
        var out = X25519(scalar, lowOrderPoints[i]);
        fail('$i expect error, got $out');
        // ignore: empty_catches
      } on ArgumentError {}
    }
  });

  test('testTestVectors', () {
    for (var i = 0; i < testVectors.length; i++) {
      var item = testVectors[i];
      var got = List<int>.filled(ScalarSize, 0);
      ScalarMult(got, item.input, item.base);
      assert(ListEquality().equals(Uint8List.fromList(got), item.expect));
    }

    for (var i = 0; i < testVectors.length; i++) {
      var item = testVectors[i];
      var got = X25519(item.input, item.base);
      assert(ListEquality().equals(got, item.expect));
    }
  });

  test('testGenKeyAndX25519', () {
    var aliceKeyPair = generateKeyPair();
    var bobKeyPair = generateKeyPair();

    var aliceSharedKey = X25519(aliceKeyPair.privateKey, bobKeyPair.publicKey);
    var bobSharedKey = X25519(bobKeyPair.privateKey, aliceKeyPair.publicKey);

    assert(ListEquality().equals(aliceSharedKey, bobSharedKey));
  });
}
