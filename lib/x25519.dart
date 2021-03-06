/// Package curve25519 provides an implementation of the X25519 function, which
/// performs scalar multiplication on the elliptic curve known as Curve25519.
/// See RFC 7748.
library x25519;

import 'dart:math';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:x25519/src/curve25519.dart' as curve;

/// ScalarSize is the size of the scalar input to X25519.
const ScalarSize = 32;

/// PointSize is the size of the point input to X25519.
const PointSize = 32;

final _random = Random.secure();

/// KeyPair is the type of Curve25519 public/private key pair.
class KeyPair {
  final List<int> privateKey;

  final List<int> publicKey;

  KeyPair({required this.privateKey, required this.publicKey});

  @override
  int get hashCode => publicKey.hashCode;

  @override
  bool operator ==(other) =>
      other is KeyPair &&
      publicKey == other.publicKey &&
      privateKey == other.privateKey;
}

/// GenerateKey generates a public/private key pair using entropy from secure random.
KeyPair generateKeyPair() {
  var private = List<int>.generate(ScalarSize, (i) => _random.nextInt(256));
  var public = List<int>.filled(32, 0);

  private[0] &= 248;
  private[31] &= 127;
  private[31] |= 64;

  ScalarBaseMult(public, private);

  return KeyPair(privateKey: private, publicKey: Uint8List.fromList(public));
}

/// ScalarMult sets dst to the product scalar * point.
///
/// Deprecated: when provided a low-order point, ScalarMult will set dst to all
/// zeroes, irrespective of the scalar. Instead, use the X25519 function, which
/// will return an error.
void ScalarMult(List<int> dst, List<int> scalar, List<int> point) {
  curve.scalarMultGeneric(dst, scalar, point);
}

/// ScalarBaseMult sets dst to the product scalar * base where base is the
/// standard generator.
///
/// It is recommended to use the X25519 function with Basepoint instead, as
/// copying into fixed size arrays can lead to unexpected bugs.
void ScalarBaseMult(List<int> dst, List<int> scalar) {
  curve.scalarMultGeneric(dst, scalar, basePoint);
}

var basePoint = List<int>.from([
  9,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
]);

void checkBasepoint() {
  ListEquality().equals(basePoint, [
    0x09,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
  ]);
}

/// X25519 returns the result of the scalar multiplication (scalar * point),
/// according to RFC 7748, Section 5. scalar, point and the return value are
/// slices of 32 bytes.
///
/// scalar can be generated at random, for example with crypto/rand. point should
/// be either Basepoint or the output of another X25519 call.
///
/// If point is Basepoint (but not if it's a different slice with the same
/// contents) a precomputed implementation might be used for performance.
Uint8List X25519(List<int> scalar, List<int> point) {
  /// Outline the body of function, to let the allocation be inlined in the
  /// caller, and possibly avoid escaping to the heap.
  var dst = List<int>.filled(32, 0);
  return x25519(dst, scalar, point);
}

Uint8List x25519(List<int> dst, List<int> scalar, List<int> point) {
  var input = List<int>.filled(32, 0);
  if (scalar.length != 32) {
    throw ArgumentError('bad scalar length: ${scalar.length}, expected 32');
  }
  if (point.length != 32) {
    throw ArgumentError('bad scalar length: ${point.length}, expected 32');
  }
  input.setRange(0, input.length, scalar);
  if (identical(point, basePoint)) {
    checkBasepoint();
    ScalarBaseMult(dst, input);
  } else {
    var base = List<int>.filled(32, 0);
    var zero = List<int>.filled(32, 0);
    base.setRange(0, base.length, point);
    ScalarMult(dst, input, base);
    if (ListEquality().equals(dst, zero)) {
      throw ArgumentError('bad input point: low order point');
    }
  }
  return Uint8List.fromList(dst);
}
