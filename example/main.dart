import 'package:hex/hex.dart';
import 'package:curve25519/curve25519.dart' as curve;

void useX25519() {
  const expectedHex =
      '89161fde887b2b53de549af483940106ecc114d6982daa98256de23bdf77661a';
  var x = List<int>.filled(32, 0);
  x[0] = 1;

  for (var i = 0; i < 200; i++) {
    x = curve.X25519(x, curve.basePoint);
  }
  assert(HEX.encode(x) == expectedHex);
}