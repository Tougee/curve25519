Dart port of [Curve25519](https://github.com/golang/crypto/tree/master/curve25519)

[Pub package](https://pub.dev/packages/x25519)

Usage
```dart

import 'package:x25519/x25519.dart';

void genKeyAndX25519() {
  var aliceKeyPair = generateKeyPair();
  var bobKeyPair = generateKeyPair();

  var aliceSharedKey = X25519(aliceKeyPair.privateKey, bobKeyPair.publicKey);
  var bobSharedKey = X25519(bobKeyPair.privateKey, aliceKeyPair.publicKey);

  assert(ListEquality().equals(aliceSharedKey, bobSharedKey));
}

void useX25519() {
  const expectedHex =
      '89161fde887b2b53de549af483940106ecc114d6982daa98256de23bdf77661a';
  var x = List<int>.filled(32, 0);
  x[0] = 1;

  for (var i = 0; i < 200; i++) {
    x = X25519(x, basePoint);
  }
  assert(HEX.encode(x) == expectedHex);
}
```

For **dart2js** or **Flutter web** usage, check [here](https://github.com/Tougee/curve25519/tree/feature/bigint).
