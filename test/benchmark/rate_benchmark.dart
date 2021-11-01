import 'package:benchmark_harness/benchmark_harness.dart';

abstract class RateBenchmark extends BenchmarkBase {
  RateBenchmark(String name, {this.runLength = 5000})
      : super(name, emitter: RateEmitter()) {
    (emitter as RateEmitter).benchmark = this;
  }

  final int runLength;
  int _iterations = 0;

  @override
  ScoreEmitter get emitter => super.emitter;

  @override
  void exercise() {
    _iterations = 0;

    var watch = Stopwatch()..start();
    while (watch.elapsedMilliseconds < runLength) {
      run();
      _iterations++;
    }
  }
}

class RateEmitter implements ScoreEmitter {
  late RateBenchmark benchmark;

  int get iterations => benchmark._iterations;

  @override
  void emit(String testName, double value) {
    final ms = value / 1000;
    final date = DateTime.now().toString().split('.')[0];

    print('| $date | '
        '$testName | '
        '$iterations iterations | '
        '${ms.toInt()} ms');
  }
}
