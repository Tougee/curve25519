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

> $ pub get  
> $ pub run benchmark/curve25519_benchmark.dart

| type |    rate    | iterations    |   time  | data throughput |
|----------|:----------:|---------------|:-------:|:---------------:|
| X25519 | 357.08 MB/s | 1786 iterations | 5001 ms | 1.74 GB |

#### AoT (native binary)

> $ pub get  
> $ dart2native benchmark/curve25519_benchmark.dart -o curve25519_benchmark  
> $ ./curve25519_benchmark

| type |    rate    | iterations    |   time  | data throughput |
|----------|:----------:|---------------|:-------:|:---------------:|
| X25519 | 521.88 MB/s | 2610 iterations | 5001 ms | 2.55 GB |


#### JS (Dart2JS) benchmark

> $ pub get  
> $ pub run benchmark/curve25519_benchmark.dart -p chrome

| type |    rate    | iterations    |   time  | data throughput |
|----------|:----------:|---------------|:-------:|:---------------:|
| X25519 | 362.38 MB/s | 1812 iterations | 5000 ms | 1.77 GB |
