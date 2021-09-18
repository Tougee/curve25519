import 'dart:typed_data';

import 'package:x25519/x25519.dart';

import 'rate_benchmark.dart';

class Curve25519Benchmark extends RateBenchmark {
  Curve25519Benchmark([int dataLength = 1024 * 1024])
      : _data = Uint8List(dataLength),
        super('X25519');

  final Uint8List _data;
  late final KeyPair _aliceKeyPair;
  late final KeyPair _bobKeyPair;

  @override
  void setup() {
    _aliceKeyPair = generateKeyPair();
    _bobKeyPair = generateKeyPair();
  }

  @override
  void run() {
    X25519(_aliceKeyPair.publicKey, _bobKeyPair.privateKey);
    addSample(_data.length);
  }
}

void main() {
  Curve25519Benchmark().report();
}
