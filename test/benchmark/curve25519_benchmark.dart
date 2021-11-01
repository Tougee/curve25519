import 'package:x25519/x25519.dart';

import 'rate_benchmark.dart';

class X25519Benchmark extends RateBenchmark {
  X25519Benchmark() : super('X25519');

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
  }
}

class GenerateKeyPairBenchmark extends RateBenchmark {
  GenerateKeyPairBenchmark() : super('generateKeyPair');

  @override
  void run() {
    generateKeyPair();
  }
}

void main() {
  GenerateKeyPairBenchmark().report();
  X25519Benchmark().report();
}
