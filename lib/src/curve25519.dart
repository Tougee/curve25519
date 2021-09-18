import 'package:adaptive_number/adaptive_number.dart';
import 'package:x25519/src/numbers.dart';

class FieldElement {
  late List<Number> innerList;
  FieldElement() {
    innerList = List<Number>.generate(10, (index) => Number.zero);
  }
  FieldElement.fromList(List<Number> list) {
    innerList = list;
  }

  Number operator [](int index) {
    return innerList[index];
  }

  void operator []=(int index, Number value) {
    innerList[index] = value;
  }

  int get length => innerList.length;
}

void fieldElementCopy(
    FieldElement src, int srcPos, FieldElement dest, int destPos, int length) {
  dest.innerList.setRange(destPos, length + destPos, src.innerList, srcPos);
}

void fieldElementFullCopy(FieldElement src, FieldElement dest) {
  fieldElementCopy(src, 0, dest, 0, dest.length);
}

var zero = FieldElement();

void FeZero(FieldElement fe) {
  fieldElementFullCopy(zero, fe);
}

void FeOne(FieldElement fe) {
  FeZero(fe);
  fe[0] = Number.one;
}

void FeAdd(FieldElement dst, FieldElement a, FieldElement b) {
  dst[0] = a[0] + b[0];
  dst[1] = a[1] + b[1];
  dst[2] = a[2] + b[2];
  dst[3] = a[3] + b[3];
  dst[4] = a[4] + b[4];
  dst[5] = a[5] + b[5];
  dst[6] = a[6] + b[6];
  dst[7] = a[7] + b[7];
  dst[8] = a[8] + b[8];
  dst[9] = a[9] + b[9];
}

void FeSub(FieldElement dst, FieldElement a, FieldElement b) {
  dst[0] = a[0] - b[0];
  dst[1] = a[1] - b[1];
  dst[2] = a[2] - b[2];
  dst[3] = a[3] - b[3];
  dst[4] = a[4] - b[4];
  dst[5] = a[5] - b[5];
  dst[6] = a[6] - b[6];
  dst[7] = a[7] - b[7];
  dst[8] = a[8] - b[8];
  dst[9] = a[9] - b[9];
}

void FeCopy(FieldElement dst, FieldElement src) {
  fieldElementFullCopy(src, dst);
}

// feCSwap replaces (f,g) with (g,f) if b == 1; replaces (f,g) with (f,g) if b == 0.
//
// Preconditions: b in {0,1}.
void feCSwap(FieldElement f, FieldElement g, Number b) {
  b = -b;
  for (var i = 0; i < f.length; i++) {
    var t = b & (f[i] ^ g[i]);
    f[i] ^= t;
    g[i] ^= t;
  }
}

// load3 reads a 24-bit, little-endian value from in.
Number load3(List<int> input) {
  var r;
  r = input[0];
  r |= input[1] << 8;
  r |= input[2] << 16;
  return Number(r);
}

// load4 reads a 32-bit, little-endian value from in.
Number load4(List<int> input) {
  int r;
  r = input[0];
  r |= input[1] << 8;
  r |= input[2] << 16;
  r |= input[3] << 24;
  return Number(r);
}

void feFromBytes(FieldElement dst, List<int> src) {
  var h0 = load4(src.sublist(0, src.length));
  var h1 = load3(src.sublist(4, src.length)) << 6;
  var h2 = load3(src.sublist(7, src.length)) << 5;
  var h3 = load3(src.sublist(10, src.length)) << 3;
  var h4 = load3(src.sublist(13, src.length)) << 2;
  var h5 = load4(src.sublist(16, src.length));
  var h6 = load3(src.sublist(20, src.length)) << 7;
  var h7 = load3(src.sublist(23, src.length)) << 5;
  var h8 = load3(src.sublist(26, src.length)) << 4;
  var h9 = (load3(src.sublist(29, src.length)) & Numbers.v0x7fffff) << 2;

  var carry = List<Number>.filled(10, Number.zero);
  carry[9] = (h9 + (Number.one << 24)) >> 25;
  h0 += carry[9] * Numbers.v19;
  h9 -= carry[9] << 25;
  carry[1] = (h1 + (Number.one << 24)) >> 25;
  h2 += carry[1];
  h1 -= carry[1] << 25;
  carry[3] = (h3 + (Number.one << 24)) >> 25;
  h4 += carry[3];
  h3 -= carry[3] << 25;
  carry[5] = (h5 + (Number.one << 24)) >> 25;
  h6 += carry[5];
  h5 -= carry[5] << 25;
  carry[7] = (h7 + (Number.one << 24)) >> 25;
  h8 += carry[7];
  h7 -= carry[7] << 25;

  carry[0] = (h0 + (Number.one << 25)) >> 26;
  h1 += carry[0];
  h0 -= carry[0] << 26;
  carry[2] = (h2 + (Number.one << 25)) >> 26;
  h3 += carry[2];
  h2 -= carry[2] << 26;
  carry[4] = (h4 + (Number.one << 25)) >> 26;
  h5 += carry[4];
  h4 -= carry[4] << 26;
  carry[6] = (h6 + (Number.one << 25)) >> 26;
  h7 += carry[6];
  h6 -= carry[6] << 26;
  carry[8] = (h8 + (Number.one << 25)) >> 26;
  h9 += carry[8];
  h8 -= carry[8] << 26;

  dst[0] = h0;
  dst[1] = h1;
  dst[2] = h2;
  dst[3] = h3;
  dst[4] = h4;
  dst[5] = h5;
  dst[6] = h6;
  dst[7] = h7;
  dst[8] = h8;
  dst[9] = h9;
}

/// FeToBytes marshals h to s.
/// Preconditions:
///   |h| bounded by 1.1*2^25,1.1*2^24,1.1*2^25,1.1*2^24,etc.
///
/// Write p=2^255-19; q=floor(h/p).
/// Basic claim: q = floor(2^(-255)(h + 19 2^(-25)h9 + 2^(-1))).
///
/// Proof:
///   Have |h|<=p so |q|<=1 so |19^2 2^(-255) q|<1/4.
///   Also have |h-2^230 h9|<2^230 so |19 2^(-255)(h-2^230 h9)|<1/4.
///
///   Write y=2^(-1)-19^2 2^(-255)q-19 2^(-255)(h-2^230 h9).
///   Then 0<y<1.
///
///   Write r=h-pq.
///   Have 0<=r<=p-1=2^255-20.
///   Thus 0<=r+19(2^-255)r<r+19(2^-255)2^255<=2^255-1.
///
///   Write x=r+19(2^-255)r+y.
///   Then 0<x<2^255 so floor(2^(-255)x) = 0 so floor(q+2^(-255)x) = q.
///
///   Have q+2^(-255)x = 2^(-255)(h + 19 2^(-25) h9 + 2^(-1))
///   so floor(2^(-255)(h + 19 2^(-25) h9 + 2^(-1))) = q.
void FeToBytes(List<int> s, FieldElement h) {
  var carry = List<Number>.filled(10, Number.zero);

  var q = (Numbers.v19 * h[9] + (Number.one << 24)) >> 25;
  q = (h[0] + q) >> 26;
  q = (h[1] + q) >> 25;
  q = (h[2] + q) >> 26;
  q = (h[3] + q) >> 25;
  q = (h[4] + q) >> 26;
  q = (h[5] + q) >> 25;
  q = (h[6] + q) >> 26;
  q = (h[7] + q) >> 25;
  q = (h[8] + q) >> 26;
  q = (h[9] + q) >> 25;

  // Goal: Output h-(2^255-19)q, which is between 0 and 2^255-20.
  h[0] += Numbers.v19 * q;
  // Goal: Output h-2^255 q, which is between 0 and 2^255-20.

  carry[0] = h[0] >> 26;
  h[1] += carry[0];
  h[0] -= carry[0] << 26;
  carry[1] = h[1] >> 25;
  h[2] += carry[1];
  h[1] -= carry[1] << 25;
  carry[2] = h[2] >> 26;
  h[3] += carry[2];
  h[2] -= carry[2] << 26;
  carry[3] = h[3] >> 25;
  h[4] += carry[3];
  h[3] -= carry[3] << 25;
  carry[4] = h[4] >> 26;
  h[5] += carry[4];
  h[4] -= carry[4] << 26;
  carry[5] = h[5] >> 25;
  h[6] += carry[5];
  h[5] -= carry[5] << 25;
  carry[6] = h[6] >> 26;
  h[7] += carry[6];
  h[6] -= carry[6] << 26;
  carry[7] = h[7] >> 25;
  h[8] += carry[7];
  h[7] -= carry[7] << 25;
  carry[8] = h[8] >> 26;
  h[9] += carry[8];
  h[8] -= carry[8] << 26;
  carry[9] = h[9] >> 25;
  h[9] -= carry[9] << 25;
  // h10 = carry9

  // Goal: Output h[0]+...+2^255 h10-2^255 q, which is between 0 and 2^255-20.
  // Have h[0]+...+2^230 h[9] between 0 and 2^255-1;
  // evidently 2^255 h10-2^255 q = 0.
  // Goal: Output h[0]+...+2^230 h[9].

  s[0] = (h[0] >> 0).intValue;
  s[1] = (h[0] >> 8).intValue;
  s[2] = (h[0] >> 16).intValue;
  s[3] = ((h[0] >> 24) | (h[1] << 2)).intValue;
  s[4] = (h[1] >> 6).intValue;
  s[5] = (h[1] >> 14).intValue;
  s[6] = ((h[1] >> 22) | (h[2] << 3)).intValue;
  s[7] = (h[2] >> 5).intValue;
  s[8] = (h[2] >> 13).intValue;
  s[9] = ((h[2] >> 21) | (h[3] << 5)).intValue;
  s[10] = (h[3] >> 3).intValue;
  s[11] = (h[3] >> 11).intValue;
  s[12] = ((h[3] >> 19) | (h[4] << 6)).intValue;
  s[13] = (h[4] >> 2).intValue;
  s[14] = (h[4] >> 10).intValue;
  s[15] = (h[4] >> 18).intValue;
  s[16] = (h[5] >> 0).intValue;
  s[17] = (h[5] >> 8).intValue;
  s[18] = (h[5] >> 16).intValue;
  s[19] = ((h[5] >> 24) | (h[6] << 1)).intValue;
  s[20] = (h[6] >> 7).intValue;
  s[21] = (h[6] >> 15).intValue;
  s[22] = ((h[6] >> 23) | (h[7] << 3)).intValue;
  s[23] = (h[7] >> 5).intValue;
  s[24] = (h[7] >> 13).intValue;
  s[25] = ((h[7] >> 21) | (h[8] << 4)).intValue;
  s[26] = (h[8] >> 4).intValue;
  s[27] = (h[8] >> 12).intValue;
  s[28] = ((h[8] >> 20) | (h[9] << 6)).intValue;
  s[29] = (h[9] >> 2).intValue;
  s[30] = (h[9] >> 10).intValue;
  s[31] = (h[9] >> 18).intValue;
}

/// feMul calculates h = f * g
/// Can overlap h with f or g.
///
/// Preconditions:
///    |f| bounded by 1.1*2^26,1.1*2^25,1.1*2^26,1.1*2^25,etc.
///    |g| bounded by 1.1*2^26,1.1*2^25,1.1*2^26,1.1*2^25,etc.
///
/// Postconditions:
///    |h| bounded by 1.1*2^25,1.1*2^24,1.1*2^25,1.1*2^24,etc.
///
/// Notes on implementation strategy:
///
/// Using schoolbook multiplication.
/// Karatsuba would save a little in some cost models.
///
/// Most multiplications by 2 and 19 are 32-bit precomputations;
/// cheaper than 64-bit postcomputations.
///
/// There is one remaining multiplication by 19 in the carry chain;
/// one *19 precomputation can be merged into this,
/// but the resulting data flow is considerably less clean.
///
/// There are 12 carries below.
/// 10 of them are 2-way parallelizable and vectorizable.
/// Can get away with 11 carries, but then data flow is much deeper.
///
/// With tighter constraints on inputs can squeeze carries into int32.
void feMul(FieldElement h, FieldElement f, FieldElement g) {
  var f0 = f[0];
  var f1 = f[1];
  var f2 = f[2];
  var f3 = f[3];
  var f4 = f[4];
  var f5 = f[5];
  var f6 = f[6];
  var f7 = f[7];
  var f8 = f[8];
  var f9 = f[9];
  var g0 = g[0];
  var g1 = g[1];
  var g2 = g[2];
  var g3 = g[3];
  var g4 = g[4];
  var g5 = g[5];
  var g6 = g[6];
  var g7 = g[7];
  var g8 = g[8];
  var g9 = g[9];
  var g1_19 = Numbers.v19 * g[1]; /* 1.4*2^29 */
  var g2_19 = Numbers.v19 * g[2]; /* 1.4*2^30; still ok */
  var g3_19 = Numbers.v19 * g[3];
  var g4_19 = Numbers.v19 * g[4];
  var g5_19 = Numbers.v19 * g[5];
  var g6_19 = Numbers.v19 * g[6];
  var g7_19 = Numbers.v19 * g[7];
  var g8_19 = Numbers.v19 * g[8];
  var g9_19 = Numbers.v19 * g[9];
  var f1_2 = Number.two * f[1];
  var f3_2 = Number.two * f[3];
  var f5_2 = Number.two * f[5];
  var f7_2 = Number.two * f[7];
  var f9_2 = Number.two * f[9];
  var f0g0 = f0 * g0;
  var f0g1 = f0 * g1;
  var f0g2 = f0 * g2;
  var f0g3 = f0 * g3;
  var f0g4 = f0 * g4;
  var f0g5 = f0 * g5;
  var f0g6 = f0 * g6;
  var f0g7 = f0 * g7;
  var f0g8 = f0 * g8;
  var f0g9 = f0 * g9;
  var f1g0 = f1 * g0;
  var f1g1_2 = f1_2 * g1;
  var f1g2 = f1 * g2;
  var f1g3_2 = f1_2 * g3;
  var f1g4 = f1 * g4;
  var f1g5_2 = f1_2 * g5;
  var f1g6 = f1 * g6;
  var f1g7_2 = f1_2 * g7;
  var f1g8 = f1 * g8;
  var f1g9_38 = f1_2 * g9_19;
  var f2g0 = f2 * g0;
  var f2g1 = f2 * g1;
  var f2g2 = f2 * g2;
  var f2g3 = f2 * g3;
  var f2g4 = f2 * g4;
  var f2g5 = f2 * g5;
  var f2g6 = f2 * g6;
  var f2g7 = f2 * g7;
  var f2g8_19 = f2 * g8_19;
  var f2g9_19 = f2 * g9_19;
  var f3g0 = f3 * g0;
  var f3g1_2 = f3_2 * g1;
  var f3g2 = f3 * g2;
  var f3g3_2 = f3_2 * g3;
  var f3g4 = f3 * g4;
  var f3g5_2 = f3_2 * g5;
  var f3g6 = f3 * g6;
  var f3g7_38 = f3_2 * g7_19;
  var f3g8_19 = f3 * g8_19;
  var f3g9_38 = f3_2 * g9_19;
  var f4g0 = f4 * g0;
  var f4g1 = f4 * g1;
  var f4g2 = f4 * g2;
  var f4g3 = f4 * g3;
  var f4g4 = f4 * g4;
  var f4g5 = f4 * g5;
  var f4g6_19 = f4 * g6_19;
  var f4g7_19 = f4 * g7_19;
  var f4g8_19 = f4 * g8_19;
  var f4g9_19 = f4 * g9_19;
  var f5g0 = f5 * g0;
  var f5g1_2 = f5_2 * g1;
  var f5g2 = f5 * g2;
  var f5g3_2 = f5_2 * g3;
  var f5g4 = f5 * g4;
  var f5g5_38 = f5_2 * g5_19;
  var f5g6_19 = f5 * g6_19;
  var f5g7_38 = f5_2 * g7_19;
  var f5g8_19 = f5 * g8_19;
  var f5g9_38 = f5_2 * g9_19;
  var f6g0 = f6 * g0;
  var f6g1 = f6 * g1;
  var f6g2 = f6 * g2;
  var f6g3 = f6 * g3;
  var f6g4_19 = f6 * g4_19;
  var f6g5_19 = f6 * g5_19;
  var f6g6_19 = f6 * g6_19;
  var f6g7_19 = f6 * g7_19;
  var f6g8_19 = f6 * g8_19;
  var f6g9_19 = f6 * g9_19;
  var f7g0 = f7 * g0;
  var f7g1_2 = f7_2 * g1;
  var f7g2 = f7 * g2;
  var f7g3_38 = f7_2 * g3_19;
  var f7g4_19 = f7 * g4_19;
  var f7g5_38 = f7_2 * g5_19;
  var f7g6_19 = f7 * g6_19;
  var f7g7_38 = f7_2 * g7_19;
  var f7g8_19 = f7 * g8_19;
  var f7g9_38 = f7_2 * g9_19;
  var f8g0 = f8 * g0;
  var f8g1 = f8 * g1;
  var f8g2_19 = f8 * g2_19;
  var f8g3_19 = f8 * g3_19;
  var f8g4_19 = f8 * g4_19;
  var f8g5_19 = f8 * g5_19;
  var f8g6_19 = f8 * g6_19;
  var f8g7_19 = f8 * g7_19;
  var f8g8_19 = f8 * g8_19;
  var f8g9_19 = f8 * g9_19;
  var f9g0 = f9 * g0;
  var f9g1_38 = f9_2 * g1_19;
  var f9g2_19 = f9 * g2_19;
  var f9g3_38 = f9_2 * g3_19;
  var f9g4_19 = f9 * g4_19;
  var f9g5_38 = f9_2 * g5_19;
  var f9g6_19 = f9 * g6_19;
  var f9g7_38 = f9_2 * g7_19;
  var f9g8_19 = f9 * g8_19;
  var f9g9_38 = f9_2 * g9_19;
  var h0 = f0g0 +
      f1g9_38 +
      f2g8_19 +
      f3g7_38 +
      f4g6_19 +
      f5g5_38 +
      f6g4_19 +
      f7g3_38 +
      f8g2_19 +
      f9g1_38;
  var h1 = f0g1 +
      f1g0 +
      f2g9_19 +
      f3g8_19 +
      f4g7_19 +
      f5g6_19 +
      f6g5_19 +
      f7g4_19 +
      f8g3_19 +
      f9g2_19;
  var h2 = f0g2 +
      f1g1_2 +
      f2g0 +
      f3g9_38 +
      f4g8_19 +
      f5g7_38 +
      f6g6_19 +
      f7g5_38 +
      f8g4_19 +
      f9g3_38;
  var h3 = f0g3 +
      f1g2 +
      f2g1 +
      f3g0 +
      f4g9_19 +
      f5g8_19 +
      f6g7_19 +
      f7g6_19 +
      f8g5_19 +
      f9g4_19;
  var h4 = f0g4 +
      f1g3_2 +
      f2g2 +
      f3g1_2 +
      f4g0 +
      f5g9_38 +
      f6g8_19 +
      f7g7_38 +
      f8g6_19 +
      f9g5_38;
  var h5 = f0g5 +
      f1g4 +
      f2g3 +
      f3g2 +
      f4g1 +
      f5g0 +
      f6g9_19 +
      f7g8_19 +
      f8g7_19 +
      f9g6_19;
  var h6 = f0g6 +
      f1g5_2 +
      f2g4 +
      f3g3_2 +
      f4g2 +
      f5g1_2 +
      f6g0 +
      f7g9_38 +
      f8g8_19 +
      f9g7_38;
  var h7 =
      f0g7 + f1g6 + f2g5 + f3g4 + f4g3 + f5g2 + f6g1 + f7g0 + f8g9_19 + f9g8_19;
  var h8 = f0g8 +
      f1g7_2 +
      f2g6 +
      f3g5_2 +
      f4g4 +
      f5g3_2 +
      f6g2 +
      f7g1_2 +
      f8g0 +
      f9g9_38;
  var h9 = f0g9 + f1g8 + f2g7 + f3g6 + f4g5 + f5g4 + f6g3 + f7g2 + f8g1 + f9g0;

  var carry = List<Number>.filled(10, Number.zero);

// |h0| <= (1.1*1.1*2^52*(1+19+19+19+19)+1.1*1.1*2^50*(38+38+38+38+38))
//   i.e. |h0| <= 1.2*2^59; narrower ranges for h2, h4, h6, h8
// |h1| <= (1.1*1.1*2^51*(1+1+19+19+19+19+19+19+19+19))
//   i.e. |h1| <= 1.5*2^58; narrower ranges for h3, h5, h7, h9

  carry[0] = (h0 + (Number.one << 25)) >> 26;
  h1 += carry[0];
  h0 -= carry[0] << 26;
  carry[4] = (h4 + (Number.one << 25)) >> 26;
  h5 += carry[4];
  h4 -= carry[4] << 26;
// |h0| <= 2^25
// |h4| <= 2^25
// |h1| <= 1.51*2^58
// |h5| <= 1.51*2^58

  carry[1] = (h1 + (Number.one << 24)) >> 25;
  h2 += carry[1];
  h1 -= carry[1] << 25;
  carry[5] = (h5 + (Number.one << 24)) >> 25;
  h6 += carry[5];
  h5 -= carry[5] << 25;
// |h1| <= 2^24; from now on fits into int32
// |h5| <= 2^24; from now on fits into int32
// |h2| <= 1.21*2^59
// |h6| <= 1.21*2^59

  carry[2] = (h2 + (Number.one << 25)) >> 26;
  h3 += carry[2];
  h2 -= carry[2] << 26;
  carry[6] = (h6 + (Number.one << 25)) >> 26;
  h7 += carry[6];
  h6 -= carry[6] << 26;
// |h2| <= 2^25; from now on fits into int32 unchanged
// |h6| <= 2^25; from now on fits into int32 unchanged
// |h3| <= 1.51*2^58
// |h7| <= 1.51*2^58

  carry[3] = (h3 + (Number.one << 24)) >> 25;
  h4 += carry[3];
  h3 -= carry[3] << 25;
  carry[7] = (h7 + (Number.one << 24)) >> 25;
  h8 += carry[7];
  h7 -= carry[7] << 25;
// |h3| <= 2^24; from now on fits into int32 unchanged
// |h7| <= 2^24; from now on fits into int32 unchanged
// |h4| <= 1.52*2^33
// |h8| <= 1.52*2^33

  carry[4] = (h4 + (Number.one << 25)) >> 26;
  h5 += carry[4];
  h4 -= carry[4] << 26;
  carry[8] = (h8 + (Number.one << 25)) >> 26;
  h9 += carry[8];
  h8 -= carry[8] << 26;
// |h4| <= 2^25; from now on fits into int32 unchanged
// |h8| <= 2^25; from now on fits into int32 unchanged
// |h5| <= 1.01*2^24
// |h9| <= 1.51*2^58

  carry[9] = (h9 + (Number.one << 24)) >> 25;
  h0 += carry[9] * Numbers.v19;
  h9 -= carry[9] << 25;
// |h9| <= 2^24; from now on fits into int32 unchanged
// |h0| <= 1.8*2^37

  carry[0] = (h0 + (Number.one << 25)) >> 26;
  h1 += carry[0];
  h0 -= carry[0] << 26;
// |h0| <= 2^25; from now on fits into int32 unchanged
// |h1| <= 1.01*2^24

  h[0] = h0;
  h[1] = h1;
  h[2] = h2;
  h[3] = h3;
  h[4] = h4;
  h[5] = h5;
  h[6] = h6;
  h[7] = h7;
  h[8] = h8;
  h[9] = h9;
}

/// feSquare calculates h = f*f. Can overlap h with f.
///
/// Preconditions:
///    |f| bounded by 1.1*2^26,1.1*2^25,1.1*2^26,1.1*2^25,etc.
///
/// Postconditions:
///    |h| bounded by 1.1*2^25,1.1*2^24,1.1*2^25,1.1*2^24,etc.
void feSquare(FieldElement h, FieldElement f) {
  var f0 = f[0];
  var f1 = f[1];
  var f2 = f[2];
  var f3 = f[3];
  var f4 = f[4];
  var f5 = f[5];
  var f6 = f[6];
  var f7 = f[7];
  var f8 = f[8];
  var f9 = f[9];
  var f0_2 = Number.two * f0;
  var f1_2 = Number.two * f1;
  var f2_2 = Number.two * f2;
  var f3_2 = Number.two * f3;
  var f4_2 = Number.two * f4;
  var f5_2 = Number.two * f5;
  var f6_2 = Number.two * f6;
  var f7_2 = Number.two * f7;
  var f5_38 = Numbers.v38 * f5; // 1.31*2^30
  var f6_19 = Numbers.v19 * f6; // 1.31*2^30
  var f7_38 = Numbers.v38 * f7; // 1.31*2^30
  var f8_19 = Numbers.v19 * f8; // 1.31*2^30
  var f9_38 = Numbers.v38 * f9; // 1.31*2^30
  var f0f0 = f0 * f0;
  var f0f1_2 = f0_2 * f1;
  var f0f2_2 = f0_2 * f2;
  var f0f3_2 = f0_2 * f3;
  var f0f4_2 = f0_2 * f4;
  var f0f5_2 = f0_2 * f5;
  var f0f6_2 = f0_2 * f6;
  var f0f7_2 = f0_2 * f7;
  var f0f8_2 = f0_2 * f8;
  var f0f9_2 = f0_2 * f9;
  var f1f1_2 = f1_2 * f1;
  var f1f2_2 = f1_2 * f2;
  var f1f3_4 = f1_2 * f3_2;
  var f1f4_2 = f1_2 * f4;
  var f1f5_4 = f1_2 * f5_2;
  var f1f6_2 = f1_2 * f6;
  var f1f7_4 = f1_2 * f7_2;
  var f1f8_2 = f1_2 * f8;
  var f1f9_76 = f1_2 * f9_38;
  var f2f2 = f2 * f2;
  var f2f3_2 = f2_2 * f3;
  var f2f4_2 = f2_2 * f4;
  var f2f5_2 = f2_2 * f5;
  var f2f6_2 = f2_2 * f6;
  var f2f7_2 = f2_2 * f7;
  var f2f8_38 = f2_2 * f8_19;
  var f2f9_38 = f2 * f9_38;
  var f3f3_2 = f3_2 * f3;
  var f3f4_2 = f3_2 * f4;
  var f3f5_4 = f3_2 * f5_2;
  var f3f6_2 = f3_2 * f6;
  var f3f7_76 = f3_2 * f7_38;
  var f3f8_38 = f3_2 * f8_19;
  var f3f9_76 = f3_2 * f9_38;
  var f4f4 = f4 * f4;
  var f4f5_2 = f4_2 * f5;
  var f4f6_38 = f4_2 * f6_19;
  var f4f7_38 = f4 * f7_38;
  var f4f8_38 = f4_2 * f8_19;
  var f4f9_38 = f4 * f9_38;
  var f5f5_38 = f5 * f5_38;
  var f5f6_38 = f5_2 * f6_19;
  var f5f7_76 = f5_2 * f7_38;
  var f5f8_38 = f5_2 * f8_19;
  var f5f9_76 = f5_2 * f9_38;
  var f6f6_19 = f6 * f6_19;
  var f6f7_38 = f6 * f7_38;
  var f6f8_38 = f6_2 * f8_19;
  var f6f9_38 = f6 * f9_38;
  var f7f7_38 = f7 * f7_38;
  var f7f8_38 = f7_2 * f8_19;
  var f7f9_76 = f7_2 * f9_38;
  var f8f8_19 = f8 * f8_19;
  var f8f9_38 = f8 * f9_38;
  var f9f9_38 = f9 * f9_38;
  var h0 = f0f0 + f1f9_76 + f2f8_38 + f3f7_76 + f4f6_38 + f5f5_38;
  var h1 = f0f1_2 + f2f9_38 + f3f8_38 + f4f7_38 + f5f6_38;
  var h2 = f0f2_2 + f1f1_2 + f3f9_76 + f4f8_38 + f5f7_76 + f6f6_19;
  var h3 = f0f3_2 + f1f2_2 + f4f9_38 + f5f8_38 + f6f7_38;
  var h4 = f0f4_2 + f1f3_4 + f2f2 + f5f9_76 + f6f8_38 + f7f7_38;
  var h5 = f0f5_2 + f1f4_2 + f2f3_2 + f6f9_38 + f7f8_38;
  var h6 = f0f6_2 + f1f5_4 + f2f4_2 + f3f3_2 + f7f9_76 + f8f8_19;
  var h7 = f0f7_2 + f1f6_2 + f2f5_2 + f3f4_2 + f8f9_38;
  var h8 = f0f8_2 + f1f7_4 + f2f6_2 + f3f5_4 + f4f4 + f9f9_38;
  var h9 = f0f9_2 + f1f8_2 + f2f7_2 + f3f6_2 + f4f5_2;
  var carry = List<Number>.filled(10, Number.zero);

  carry[0] = (h0 + (Number.one << 25)) >> 26;
  h1 += carry[0];
  h0 -= carry[0] << 26;
  carry[4] = (h4 + (Number.one << 25)) >> 26;
  h5 += carry[4];
  h4 -= carry[4] << 26;

  carry[1] = (h1 + (Number.one << 24)) >> 25;
  h2 += carry[1];
  h1 -= carry[1] << 25;
  carry[5] = (h5 + (Number.one << 24)) >> 25;
  h6 += carry[5];
  h5 -= carry[5] << 25;

  carry[2] = (h2 + (Number.one << 25)) >> 26;
  h3 += carry[2];
  h2 -= carry[2] << 26;
  carry[6] = (h6 + (Number.one << 25)) >> 26;
  h7 += carry[6];
  h6 -= carry[6] << 26;

  carry[3] = (h3 + (Number.one << 24)) >> 25;
  h4 += carry[3];
  h3 -= carry[3] << 25;
  carry[7] = (h7 + (Number.one << 24)) >> 25;
  h8 += carry[7];
  h7 -= carry[7] << 25;

  carry[4] = (h4 + (Number.one << 25)) >> 26;
  h5 += carry[4];
  h4 -= carry[4] << 26;
  carry[8] = (h8 + (Number.one << 25)) >> 26;
  h9 += carry[8];
  h8 -= carry[8] << 26;

  carry[9] = (h9 + (Number.one << 24)) >> 25;
  h0 += carry[9] * Numbers.v19;
  h9 -= carry[9] << 25;

  carry[0] = (h0 + (Number.one << 25)) >> 26;
  h1 += carry[0];
  h0 -= carry[0] << 26;

  h[0] = h0;
  h[1] = h1;
  h[2] = h2;
  h[3] = h3;
  h[4] = h4;
  h[5] = h5;
  h[6] = h6;
  h[7] = h7;
  h[8] = h8;
  h[9] = h9;
}

/// feMul121666 calculates h = f * 121666. Can overlap h with f.
///
/// Preconditions:
///    |f| bounded by 1.1*2^26,1.1*2^25,1.1*2^26,1.1*2^25,etc.
///
/// Postconditions:
///    |h| bounded by 1.1*2^25,1.1*2^24,1.1*2^25,1.1*2^24,etc.
void feMul121666(FieldElement h, FieldElement f) {
  var h0 = f[0] * Numbers.v121666;
  var h1 = f[1] * Numbers.v121666;
  var h2 = f[2] * Numbers.v121666;
  var h3 = f[3] * Numbers.v121666;
  var h4 = f[4] * Numbers.v121666;
  var h5 = f[5] * Numbers.v121666;
  var h6 = f[6] * Numbers.v121666;
  var h7 = f[7] * Numbers.v121666;
  var h8 = f[8] * Numbers.v121666;
  var h9 = f[9] * Numbers.v121666;
  var carry = List<Number>.filled(10, Number.zero);

  carry[9] = (h9 + (Number.one << 24)) >> 25;
  h0 += carry[9] * Numbers.v19;
  h9 -= carry[9] << 25;
  carry[1] = (h1 + (Number.one << 24)) >> 25;
  h2 += carry[1];
  h1 -= carry[1] << 25;
  carry[3] = (h3 + (Number.one << 24)) >> 25;
  h4 += carry[3];
  h3 -= carry[3] << 25;
  carry[5] = (h5 + (Number.one << 24)) >> 25;
  h6 += carry[5];
  h5 -= carry[5] << 25;
  carry[7] = (h7 + (Number.one << 24)) >> 25;
  h8 += carry[7];
  h7 -= carry[7] << 25;

  carry[0] = (h0 + (Number.one << 25)) >> 26;
  h1 += carry[0];
  h0 -= carry[0] << 26;
  carry[2] = (h2 + (Number.one << 25)) >> 26;
  h3 += carry[2];
  h2 -= carry[2] << 26;
  carry[4] = (h4 + (Number.one << 25)) >> 26;
  h5 += carry[4];
  h4 -= carry[4] << 26;
  carry[6] = (h6 + (Number.one << 25)) >> 26;
  h7 += carry[6];
  h6 -= carry[6] << 26;
  carry[8] = (h8 + (Number.one << 25)) >> 26;
  h9 += carry[8];
  h8 -= carry[8] << 26;

  h[0] = h0;
  h[1] = h1;
  h[2] = h2;
  h[3] = h3;
  h[4] = h4;
  h[5] = h5;
  h[6] = h6;
  h[7] = h7;
  h[8] = h8;
  h[9] = h9;
}

/// feInvert sets out = z^-1.
void feInvert(FieldElement out, FieldElement z) {
  var t0 = FieldElement();
  var t1 = FieldElement();
  var t2 = FieldElement();
  var t3 = FieldElement();
  var i = 0;

  feSquare(t0, z);
  for (i = 1; i < 1; i++) {
    feSquare(t0, t0);
  }
  feSquare(t1, t0);
  for (i = 1; i < 2; i++) {
    feSquare(t1, t1);
  }
  feMul(t1, z, t1);
  feMul(t0, t0, t1);
  feSquare(t2, t0);
  for (i = 1; i < 1; i++) {
    feSquare(t2, t2);
  }
  feMul(t1, t1, t2);
  feSquare(t2, t1);
  for (i = 1; i < 5; i++) {
    feSquare(t2, t2);
  }
  feMul(t1, t2, t1);
  feSquare(t2, t1);
  for (i = 1; i < 10; i++) {
    feSquare(t2, t2);
  }
  feMul(t2, t2, t1);
  feSquare(t3, t2);
  for (i = 1; i < 20; i++) {
    feSquare(t3, t3);
  }
  feMul(t2, t3, t2);
  feSquare(t2, t2);
  for (i = 1; i < 10; i++) {
    feSquare(t2, t2);
  }
  feMul(t1, t2, t1);
  feSquare(t2, t1);
  for (i = 1; i < 50; i++) {
    feSquare(t2, t2);
  }
  feMul(t2, t2, t1);
  feSquare(t3, t2);
  for (i = 1; i < 100; i++) {
    feSquare(t3, t3);
  }
  feMul(t2, t3, t2);
  feSquare(t2, t2);
  for (i = 1; i < 50; i++) {
    feSquare(t2, t2);
  }
  feMul(t1, t2, t1);
  feSquare(t1, t1);
  for (i = 1; i < 5; i++) {
    feSquare(t1, t1);
  }
  feMul(out, t1, t0);
}

void scalarMultGeneric(List<int> out, List<int> input, List<int> base) {
  var e = List<Number>.filled(32, Number.zero);

  e.setRange(0, e.length, input.map((e) => Number(e)).toList());
  e[0] &= Numbers.v248;
  e[31] &= Numbers.v127;
  e[31] |= Numbers.v64;

  var x1 = FieldElement();
  var x2 = FieldElement();
  var z2 = FieldElement();
  var x3 = FieldElement();
  var z3 = FieldElement();
  var tmp0 = FieldElement();
  var tmp1 = FieldElement();

  feFromBytes(x1, base);
  FeOne(x2);
  FeCopy(x3, x1);
  FeOne(z3);

  var swap = Number.zero;
  for (var pos = 254; pos >= 0; pos--) {
    var b = e[pos ~/ 8] >> (pos & 7);
    b &= Number.one;
    swap ^= b;
    feCSwap(x2, x3, swap);
    feCSwap(z2, z3, swap);
    swap = b;

    FeSub(tmp0, x3, z3);
    FeSub(tmp1, x2, z2);
    FeAdd(x2, x2, z2);
    FeAdd(z2, x3, z3);
    feMul(z3, tmp0, x2);
    feMul(z2, z2, tmp1);
    feSquare(tmp0, tmp1);
    feSquare(tmp1, x2);
    FeAdd(x3, z3, z2);
    FeSub(z2, z3, z2);
    feMul(x2, tmp1, tmp0);
    FeSub(tmp1, tmp1, tmp0);
    feSquare(z2, z2);
    feMul121666(z3, tmp1);
    feSquare(x3, x3);
    FeAdd(tmp0, tmp0, z3);
    feMul(z3, x1, z2);
    feMul(z2, tmp1, tmp0);
  }

  feCSwap(x2, x3, swap);
  feCSwap(z2, z3, swap);

  feInvert(z2, z2);
  feMul(x2, x2, z2);
  FeToBytes(out, x2);
}
