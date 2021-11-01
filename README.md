# Curve25519

Dart port of [Curve25519](https://github.com/golang/crypto/tree/master/curve25519)

[Pub package](https://pub.dev/packages/x25519)

## Usage
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

## Benchmark

Simulate from [pinenacl-dart Benchmark](https://github.com/ilap/pinenacl-dart/blob/master/benchmark/README.md)

MacBook Pro (16-inch, 2019), macOS Big Sur, with 2.4GHz i9 32GB

#### JiT (Dart VM) Benchmark

> dart test test/benchmark/curve25519_benchmark.dart

| type | iterations    |   time  |
|:----------:|:----------:|---------------|
| generateKeyPair | 1259 iterations | 5001 ms
| X25519 | 1745 iterations | 5001 ms

#### AoT (native binary)

> dart2native test/benchmark/curve25519_benchmark.dart -o curve25519_benchmark  
> ./curve25519_benchmark

| type | iterations    |   time  |
|:----------:|---------------|:-------:|
| generateKeyPair | 1751 iterations | 5002 ms
| X25519 | 2266 iterations | 5000 ms


#### JS (Dart2JS) benchmark

> dart test test/benchmark/curve25519_benchmark.dart -p chrome

| type | iterations    |   time  |
|:----------:|:---------------|:-------:|
| generateKeyPair | 242 iterations | 5022 ms
| X25519 | 244 iterations | 5013 ms
