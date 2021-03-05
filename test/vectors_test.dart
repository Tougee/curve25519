// lowOrderPoints from libsodium.
// https://github.com/jedisct1/libsodium/blob/65621a1059a37d/src/libsodium/crypto_scalarmult/curve25519/ref10/x25519_ref10.c#L11-L70
var lowOrderPoints = List<List<int>>.from([
  List<int>.from([
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
    0x00
  ]),
  List<int>.from([
    0x01,
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
    0x00
  ]),
  List<int>.from([
    0xe0,
    0xeb,
    0x7a,
    0x7c,
    0x3b,
    0x41,
    0xb8,
    0xae,
    0x16,
    0x56,
    0xe3,
    0xfa,
    0xf1,
    0x9f,
    0xc4,
    0x6a,
    0xda,
    0x09,
    0x8d,
    0xeb,
    0x9c,
    0x32,
    0xb1,
    0xfd,
    0x86,
    0x62,
    0x05,
    0x16,
    0x5f,
    0x49,
    0xb8,
    0x00
  ]),
  List<int>.from([
    0x5f,
    0x9c,
    0x95,
    0xbc,
    0xa3,
    0x50,
    0x8c,
    0x24,
    0xb1,
    0xd0,
    0xb1,
    0x55,
    0x9c,
    0x83,
    0xef,
    0x5b,
    0x04,
    0x44,
    0x5c,
    0xc4,
    0x58,
    0x1c,
    0x8e,
    0x86,
    0xd8,
    0x22,
    0x4e,
    0xdd,
    0xd0,
    0x9f,
    0x11,
    0x57
  ]),
  List<int>.from([
    0xec,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0x7f
  ]),
  List<int>.from([
    0xed,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0x7f
  ]),
  List<int>.from([
    0xee,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0xff,
    0x7f
  ]),
]);

class TestVectors {
  final List<int> input;
  final List<int> base;
  final List<int> expect;

  TestVectors.from(this.input, this.base, this.expect);
}

// testVectors generated with BoringSSL.
var testVectors = List<TestVectors>.from([
  TestVectors.from([
    0x66,
    0x8f,
    0xb9,
    0xf7,
    0x6a,
    0xd9,
    0x71,
    0xc8,
    0x1a,
    0xc9,
    0x0,
    0x7,
    0x1a,
    0x15,
    0x60,
    0xbc,
    0xe2,
    0xca,
    0x0,
    0xca,
    0xc7,
    0xe6,
    0x7a,
    0xf9,
    0x93,
    0x48,
    0x91,
    0x37,
    0x61,
    0x43,
    0x40,
    0x14
  ], [
    0xdb,
    0x5f,
    0x32,
    0xb7,
    0xf8,
    0x41,
    0xe7,
    0xa1,
    0xa0,
    0x9,
    0x68,
    0xef,
    0xfd,
    0xed,
    0x12,
    0x73,
    0x5f,
    0xc4,
    0x7a,
    0x3e,
    0xb1,
    0x3b,
    0x57,
    0x9a,
    0xac,
    0xad,
    0xea,
    0xe8,
    0x9,
    0x39,
    0xa7,
    0xdd
  ], [
    0x9,
    0xd,
    0x85,
    0xe5,
    0x99,
    0xea,
    0x8e,
    0x2b,
    0xee,
    0xb6,
    0x13,
    0x4,
    0xd3,
    0x7b,
    0xe1,
    0xe,
    0xc5,
    0xc9,
    0x5,
    0xf9,
    0x92,
    0x7d,
    0x32,
    0xf4,
    0x2a,
    0x9a,
    0xa,
    0xfb,
    0x3e,
    0xb,
    0x40,
    0x74
  ]),
  TestVectors.from([
    0x63,
    0x66,
    0x95,
    0xe3,
    0x4f,
    0x75,
    0xb9,
    0xa2,
    0x79,
    0xc8,
    0x70,
    0x6f,
    0xad,
    0x12,
    0x89,
    0xf2,
    0xc0,
    0xb1,
    0xe2,
    0x2e,
    0x16,
    0xf8,
    0xb8,
    0x86,
    0x17,
    0x29,
    0xc1,
    0xa,
    0x58,
    0x29,
    0x58,
    0xaf
  ], [
    0x9,
    0xd,
    0x7,
    0x1,
    0xf8,
    0xfd,
    0xe2,
    0x8f,
    0x70,
    0x4,
    0x3b,
    0x83,
    0xf2,
    0x34,
    0x62,
    0x25,
    0x41,
    0x9b,
    0x18,
    0xa7,
    0xf2,
    0x7e,
    0x9e,
    0x3d,
    0x2b,
    0xfd,
    0x4,
    0xe1,
    0xf,
    0x3d,
    0x21,
    0x3e
  ], [
    0xbf,
    0x26,
    0xec,
    0x7e,
    0xc4,
    0x13,
    0x6,
    0x17,
    0x33,
    0xd4,
    0x40,
    0x70,
    0xea,
    0x67,
    0xca,
    0xb0,
    0x2a,
    0x85,
    0xdc,
    0x1b,
    0xe8,
    0xcf,
    0xe1,
    0xff,
    0x73,
    0xd5,
    0x41,
    0xcc,
    0x8,
    0x32,
    0x55,
    0x6
  ]),
  TestVectors.from([
    0x73,
    0x41,
    0x81,
    0xcd,
    0x1a,
    0x94,
    0x6,
    0x52,
    0x2a,
    0x56,
    0xfe,
    0x25,
    0xe4,
    0x3e,
    0xcb,
    0xf0,
    0x29,
    0x5d,
    0xb5,
    0xdd,
    0xd0,
    0x60,
    0x9b,
    0x3c,
    0x2b,
    0x4e,
    0x79,
    0xc0,
    0x6f,
    0x8b,
    0xd4,
    0x6d
  ], [
    0xf8,
    0xa8,
    0x42,
    0x1c,
    0x7d,
    0x21,
    0xa9,
    0x2d,
    0xb3,
    0xed,
    0xe9,
    0x79,
    0xe1,
    0xfa,
    0x6a,
    0xcb,
    0x6,
    0x2b,
    0x56,
    0xb1,
    0x88,
    0x5c,
    0x71,
    0xc5,
    0x11,
    0x53,
    0xcc,
    0xb8,
    0x80,
    0xac,
    0x73,
    0x15
  ], [
    0x11,
    0x76,
    0xd0,
    0x16,
    0x81,
    0xf2,
    0xcf,
    0x92,
    0x9d,
    0xa2,
    0xc7,
    0xa3,
    0xdf,
    0x66,
    0xb5,
    0xd7,
    0x72,
    0x9f,
    0xd4,
    0x22,
    0x22,
    0x6f,
    0xd6,
    0x37,
    0x42,
    0x16,
    0xbf,
    0x7e,
    0x2,
    0xfd,
    0xf,
    0x62
  ]),
  TestVectors.from([
    0x1f,
    0x70,
    0x39,
    0x1f,
    0x6b,
    0xa8,
    0x58,
    0x12,
    0x94,
    0x13,
    0xbd,
    0x80,
    0x1b,
    0x12,
    0xac,
    0xbf,
    0x66,
    0x23,
    0x62,
    0x82,
    0x5c,
    0xa2,
    0x50,
    0x9c,
    0x81,
    0x87,
    0x59,
    0xa,
    0x2b,
    0xe,
    0x61,
    0x72
  ], [
    0xd3,
    0xea,
    0xd0,
    0x7a,
    0x0,
    0x8,
    0xf4,
    0x45,
    0x2,
    0xd5,
    0x80,
    0x8b,
    0xff,
    0xc8,
    0x97,
    0x9f,
    0x25,
    0xa8,
    0x59,
    0xd5,
    0xad,
    0xf4,
    0x31,
    0x2e,
    0xa4,
    0x87,
    0x48,
    0x9c,
    0x30,
    0xe0,
    0x1b,
    0x3b
  ], [
    0xf8,
    0x48,
    0x2f,
    0x2e,
    0x9e,
    0x58,
    0xbb,
    0x6,
    0x7e,
    0x86,
    0xb2,
    0x87,
    0x24,
    0xb3,
    0xc0,
    0xa3,
    0xbb,
    0xb5,
    0x7,
    0x3e,
    0x4c,
    0x6a,
    0xcd,
    0x93,
    0xdf,
    0x54,
    0x5e,
    0xff,
    0xdb,
    0xba,
    0x50,
    0x5f
  ]),
  TestVectors.from([
    0x3a,
    0x7a,
    0xe6,
    0xcf,
    0x8b,
    0x88,
    0x9d,
    0x2b,
    0x7a,
    0x60,
    0xa4,
    0x70,
    0xad,
    0x6a,
    0xd9,
    0x99,
    0x20,
    0x6b,
    0xf5,
    0x7d,
    0x90,
    0x30,
    0xdd,
    0xf7,
    0xf8,
    0x68,
    0xc,
    0x8b,
    0x1a,
    0x64,
    0x5d,
    0xaa
  ], [
    0x4d,
    0x25,
    0x4c,
    0x80,
    0x83,
    0xd8,
    0x7f,
    0x1a,
    0x9b,
    0x3e,
    0xa7,
    0x31,
    0xef,
    0xcf,
    0xf8,
    0xa6,
    0xf2,
    0x31,
    0x2d,
    0x6f,
    0xed,
    0x68,
    0xe,
    0xf8,
    0x29,
    0x18,
    0x51,
    0x61,
    0xc8,
    0xfc,
    0x50,
    0x60
  ], [
    0x47,
    0xb3,
    0x56,
    0xd5,
    0x81,
    0x8d,
    0xe8,
    0xef,
    0xac,
    0x77,
    0x4b,
    0x71,
    0x4c,
    0x42,
    0xc4,
    0x4b,
    0xe6,
    0x85,
    0x23,
    0xdd,
    0x57,
    0xdb,
    0xd7,
    0x39,
    0x62,
    0xd5,
    0xa5,
    0x26,
    0x31,
    0x87,
    0x62,
    0x37
  ]),
  TestVectors.from([
    0x20,
    0x31,
    0x61,
    0xc3,
    0x15,
    0x9a,
    0x87,
    0x6a,
    0x2b,
    0xea,
    0xec,
    0x29,
    0xd2,
    0x42,
    0x7f,
    0xb0,
    0xc7,
    0xc3,
    0xd,
    0x38,
    0x2c,
    0xd0,
    0x13,
    0xd2,
    0x7c,
    0xc3,
    0xd3,
    0x93,
    0xdb,
    0xd,
    0xaf,
    0x6f
  ], [
    0x6a,
    0xb9,
    0x5d,
    0x1a,
    0xbe,
    0x68,
    0xc0,
    0x9b,
    0x0,
    0x5c,
    0x3d,
    0xb9,
    0x4,
    0x2c,
    0xc9,
    0x1a,
    0xc8,
    0x49,
    0xf7,
    0xe9,
    0x4a,
    0x2a,
    0x4a,
    0x9b,
    0x89,
    0x36,
    0x78,
    0x97,
    0xb,
    0x7b,
    0x95,
    0xbf
  ], [
    0x11,
    0xed,
    0xae,
    0xdc,
    0x95,
    0xff,
    0x78,
    0xf5,
    0x63,
    0xa1,
    0xc8,
    0xf1,
    0x55,
    0x91,
    0xc0,
    0x71,
    0xde,
    0xa0,
    0x92,
    0xb4,
    0xd7,
    0xec,
    0xaa,
    0xc8,
    0xe0,
    0x38,
    0x7b,
    0x5a,
    0x16,
    0xc,
    0x4e,
    0x5d
  ]),
  TestVectors.from(
    [
      0x13,
      0xd6,
      0x54,
      0x91,
      0xfe,
      0x75,
      0xf2,
      0x3,
      0xa0,
      0x8,
      0xb4,
      0x41,
      0x5a,
      0xbc,
      0x60,
      0xd5,
      0x32,
      0xe6,
      0x95,
      0xdb,
      0xd2,
      0xf1,
      0xe8,
      0x3,
      0xac,
      0xcb,
      0x34,
      0xb2,
      0xb7,
      0x2c,
      0x3d,
      0x70
    ],
    [
      0x2e,
      0x78,
      0x4e,
      0x4,
      0xca,
      0x0,
      0x73,
      0x33,
      0x62,
      0x56,
      0xa8,
      0x39,
      0x25,
      0x5e,
      0xd2,
      0xf7,
      0xd4,
      0x79,
      0x6a,
      0x64,
      0xcd,
      0xc3,
      0x7f,
      0x1e,
      0xb0,
      0xe5,
      0xc4,
      0xc8,
      0xd1,
      0xd1,
      0xe0,
      0xf5
    ],
    [
      0x56,
      0x3e,
      0x8c,
      0x9a,
      0xda,
      0xa7,
      0xd7,
      0x31,
      0x1,
      0xb0,
      0xf2,
      0xea,
      0xd3,
      0xca,
      0xe1,
      0xea,
      0x5d,
      0x8f,
      0xcd,
      0x5c,
      0xd3,
      0x60,
      0x80,
      0xbb,
      0x8e,
      0x6e,
      0xc0,
      0x3d,
      0x61,
      0x45,
      0x9,
      0x17
    ],
  ),
  TestVectors.from(
    [
      0x68,
      0x6f,
      0x7d,
      0xa9,
      0x3b,
      0xf2,
      0x68,
      0xe5,
      0x88,
      0x6,
      0x98,
      0x31,
      0xf0,
      0x47,
      0x16,
      0x3f,
      0x33,
      0x58,
      0x99,
      0x89,
      0xd0,
      0x82,
      0x6e,
      0x98,
      0x8,
      0xfb,
      0x67,
      0x8e,
      0xd5,
      0x7e,
      0x67,
      0x49
    ],
    [
      0x8b,
      0x54,
      0x9b,
      0x2d,
      0xf6,
      0x42,
      0xd3,
      0xb2,
      0x5f,
      0xe8,
      0x38,
      0xf,
      0x8c,
      0xc4,
      0x37,
      0x5f,
      0x99,
      0xb7,
      0xbb,
      0x4d,
      0x27,
      0x5f,
      0x77,
      0x9f,
      0x3b,
      0x7c,
      0x81,
      0xb8,
      0xa2,
      0xbb,
      0xc1,
      0x29
    ],
    [
      0x1,
      0x47,
      0x69,
      0x65,
      0x42,
      0x6b,
      0x61,
      0x71,
      0x74,
      0x9a,
      0x8a,
      0xdd,
      0x92,
      0x35,
      0x2,
      0x5c,
      0xe5,
      0xf5,
      0x57,
      0xfe,
      0x40,
      0x9,
      0xf7,
      0x39,
      0x30,
      0x44,
      0xeb,
      0xbb,
      0x8a,
      0xe9,
      0x52,
      0x79
    ],
  ),
  TestVectors.from(
    [
      0x82,
      0xd6,
      0x1c,
      0xce,
      0xdc,
      0x80,
      0x6a,
      0x60,
      0x60,
      0xa3,
      0x34,
      0x9a,
      0x5e,
      0x87,
      0xcb,
      0xc7,
      0xac,
      0x11,
      0x5e,
      0x4f,
      0x87,
      0x77,
      0x62,
      0x50,
      0xae,
      0x25,
      0x60,
      0x98,
      0xa7,
      0xc4,
      0x49,
      0x59
    ],
    [
      0x8b,
      0x6b,
      0x9d,
      0x8,
      0xf6,
      0x1f,
      0xc9,
      0x1f,
      0xe8,
      0xb3,
      0x29,
      0x53,
      0xc4,
      0x23,
      0x40,
      0xf0,
      0x7,
      0xb5,
      0x71,
      0xdc,
      0xb0,
      0xa5,
      0x6d,
      0x10,
      0x72,
      0x4e,
      0xce,
      0xf9,
      0x95,
      0xc,
      0xfb,
      0x25
    ],
    [
      0x9c,
      0x49,
      0x94,
      0x1f,
      0x9c,
      0x4f,
      0x18,
      0x71,
      0xfa,
      0x40,
      0x91,
      0xfe,
      0xd7,
      0x16,
      0xd3,
      0x49,
      0x99,
      0xc9,
      0x52,
      0x34,
      0xed,
      0xf2,
      0xfd,
      0xfb,
      0xa6,
      0xd1,
      0x4a,
      0x5a,
      0xfe,
      0x9e,
      0x5,
      0x58
    ],
  ),
  TestVectors.from(
    [
      0x7d,
      0xc7,
      0x64,
      0x4,
      0x83,
      0x13,
      0x97,
      0xd5,
      0x88,
      0x4f,
      0xdf,
      0x6f,
      0x97,
      0xe1,
      0x74,
      0x4c,
      0x9e,
      0xb1,
      0x18,
      0xa3,
      0x1a,
      0x7b,
      0x23,
      0xf8,
      0xd7,
      0x9f,
      0x48,
      0xce,
      0x9c,
      0xad,
      0x15,
      0x4b
    ],
    [
      0x1a,
      0xcd,
      0x29,
      0x27,
      0x84,
      0xf4,
      0x79,
      0x19,
      0xd4,
      0x55,
      0xf8,
      0x87,
      0x44,
      0x83,
      0x58,
      0x61,
      0xb,
      0xb9,
      0x45,
      0x96,
      0x70,
      0xeb,
      0x99,
      0xde,
      0xe4,
      0x60,
      0x5,
      0xf6,
      0x89,
      0xca,
      0x5f,
      0xb6
    ],
    [
      0x0,
      0xf4,
      0x3c,
      0x2,
      0x2e,
      0x94,
      0xea,
      0x38,
      0x19,
      0xb0,
      0x36,
      0xae,
      0x2b,
      0x36,
      0xb2,
      0xa7,
      0x61,
      0x36,
      0xaf,
      0x62,
      0x8a,
      0x75,
      0x1f,
      0xe5,
      0xd0,
      0x1e,
      0x3,
      0xd,
      0x44,
      0x25,
      0x88,
      0x59
    ],
  ),
  TestVectors.from(
    [
      0xfb,
      0xc4,
      0x51,
      0x1d,
      0x23,
      0xa6,
      0x82,
      0xae,
      0x4e,
      0xfd,
      0x8,
      0xc8,
      0x17,
      0x9c,
      0x1c,
      0x6,
      0x7f,
      0x9c,
      0x8b,
      0xe7,
      0x9b,
      0xbc,
      0x4e,
      0xff,
      0x5c,
      0xe2,
      0x96,
      0xc6,
      0xbc,
      0x1f,
      0xf4,
      0x45
    ],
    [
      0x55,
      0xca,
      0xff,
      0x21,
      0x81,
      0xf2,
      0x13,
      0x6b,
      0xe,
      0xd0,
      0xe1,
      0xe2,
      0x99,
      0x44,
      0x48,
      0xe1,
      0x6c,
      0xc9,
      0x70,
      0x64,
      0x6a,
      0x98,
      0x3d,
      0x14,
      0xd,
      0xc4,
      0xea,
      0xb3,
      0xd9,
      0x4c,
      0x28,
      0x4e
    ],
    [
      0xae,
      0x39,
      0xd8,
      0x16,
      0x53,
      0x23,
      0x45,
      0x79,
      0x4d,
      0x26,
      0x91,
      0xe0,
      0x80,
      0x1c,
      0xaa,
      0x52,
      0x5f,
      0xc3,
      0x63,
      0x4d,
      0x40,
      0x2c,
      0xe9,
      0x58,
      0xb,
      0x33,
      0x38,
      0xb4,
      0x6f,
      0x8b,
      0xb9,
      0x72
    ],
  ),
  TestVectors.from(
    [
      0x4e,
      0x6,
      0xc,
      0xe1,
      0xc,
      0xeb,
      0xf0,
      0x95,
      0x9,
      0x87,
      0x16,
      0xc8,
      0x66,
      0x19,
      0xeb,
      0x9f,
      0x7d,
      0xf6,
      0x65,
      0x24,
      0x69,
      0x8b,
      0xa7,
      0x98,
      0x8c,
      0x3b,
      0x90,
      0x95,
      0xd9,
      0xf5,
      0x1,
      0x34
    ],
    [
      0x57,
      0x73,
      0x3f,
      0x2d,
      0x86,
      0x96,
      0x90,
      0xd0,
      0xd2,
      0xed,
      0xae,
      0xc9,
      0x52,
      0x3d,
      0xaa,
      0x2d,
      0xa9,
      0x54,
      0x45,
      0xf4,
      0x4f,
      0x57,
      0x83,
      0xc1,
      0xfa,
      0xec,
      0x6c,
      0x3a,
      0x98,
      0x28,
      0x18,
      0xf3
    ],
    [
      0xa6,
      0x1e,
      0x74,
      0x55,
      0x2c,
      0xce,
      0x75,
      0xf5,
      0xe9,
      0x72,
      0xe4,
      0x24,
      0xf2,
      0xcc,
      0xb0,
      0x9c,
      0x83,
      0xbc,
      0x1b,
      0x67,
      0x1,
      0x47,
      0x48,
      0xf0,
      0x2c,
      0x37,
      0x1a,
      0x20,
      0x9e,
      0xf2,
      0xfb,
      0x2c
    ],
  ),
  TestVectors.from(
    [
      0x5c,
      0x49,
      0x2c,
      0xba,
      0x2c,
      0xc8,
      0x92,
      0x48,
      0x8a,
      0x9c,
      0xeb,
      0x91,
      0x86,
      0xc2,
      0xaa,
      0xc2,
      0x2f,
      0x1,
      0x5b,
      0xf3,
      0xef,
      0x8d,
      0x3e,
      0xcc,
      0x9c,
      0x41,
      0x76,
      0x97,
      0x62,
      0x61,
      0xaa,
      0xb1
    ],
    [
      0x67,
      0x97,
      0xc2,
      0xe7,
      0xdc,
      0x92,
      0xcc,
      0xbe,
      0x7c,
      0x5,
      0x6b,
      0xec,
      0x35,
      0xa,
      0xb6,
      0xd3,
      0xbd,
      0x2a,
      0x2c,
      0x6b,
      0xc5,
      0xa8,
      0x7,
      0xbb,
      0xca,
      0xe1,
      0xf6,
      0xc2,
      0xaf,
      0x80,
      0x36,
      0x44
    ],
    [
      0xfc,
      0xf3,
      0x7,
      0xdf,
      0xbc,
      0x19,
      0x2,
      0xb,
      0x28,
      0xa6,
      0x61,
      0x8c,
      0x6c,
      0x62,
      0x2f,
      0x31,
      0x7e,
      0x45,
      0x96,
      0x7d,
      0xac,
      0xf4,
      0xae,
      0x4a,
      0xa,
      0x69,
      0x9a,
      0x10,
      0x76,
      0x9f,
      0xde,
      0x14
    ],
  ),
  TestVectors.from(
    [
      0xea,
      0x33,
      0x34,
      0x92,
      0x96,
      0x5,
      0x5a,
      0x4e,
      0x8b,
      0x19,
      0x2e,
      0x3c,
      0x23,
      0xc5,
      0xf4,
      0xc8,
      0x44,
      0x28,
      0x2a,
      0x3b,
      0xfc,
      0x19,
      0xec,
      0xc9,
      0xdc,
      0x64,
      0x6a,
      0x42,
      0xc3,
      0x8d,
      0xc2,
      0x48
    ],
    [
      0x2c,
      0x75,
      0xd8,
      0x51,
      0x42,
      0xec,
      0xad,
      0x3e,
      0x69,
      0x44,
      0x70,
      0x4,
      0x54,
      0xc,
      0x1c,
      0x23,
      0x54,
      0x8f,
      0xc8,
      0xf4,
      0x86,
      0x25,
      0x1b,
      0x8a,
      0x19,
      0x46,
      0x3f,
      0x3d,
      0xf6,
      0xf8,
      0xac,
      0x61
    ],
    [
      0x5d,
      0xca,
      0xb6,
      0x89,
      0x73,
      0xf9,
      0x5b,
      0xd3,
      0xae,
      0x4b,
      0x34,
      0xfa,
      0xb9,
      0x49,
      0xfb,
      0x7f,
      0xb1,
      0x5a,
      0xf1,
      0xd8,
      0xca,
      0xe2,
      0x8c,
      0xd6,
      0x99,
      0xf9,
      0xc1,
      0xaa,
      0x33,
      0x37,
      0x34,
      0x2f
    ],
  ),
  TestVectors.from(
    [
      0x4f,
      0x29,
      0x79,
      0xb1,
      0xec,
      0x86,
      0x19,
      0xe4,
      0x5c,
      0xa,
      0xb,
      0x2b,
      0x52,
      0x9,
      0x34,
      0x54,
      0x1a,
      0xb9,
      0x44,
      0x7,
      0xb6,
      0x4d,
      0x19,
      0xa,
      0x76,
      0xf3,
      0x23,
      0x14,
      0xef,
      0xe1,
      0x84,
      0xe7
    ],
    [
      0xf7,
      0xca,
      0xe1,
      0x8d,
      0x8d,
      0x36,
      0xa7,
      0xf5,
      0x61,
      0x17,
      0xb8,
      0xb7,
      0xe,
      0x25,
      0x52,
      0x27,
      0x7f,
      0xfc,
      0x99,
      0xdf,
      0x87,
      0x56,
      0xb5,
      0xe1,
      0x38,
      0xbf,
      0x63,
      0x68,
      0xbc,
      0x87,
      0xf7,
      0x4c
    ],
    [
      0xe4,
      0xe6,
      0x34,
      0xeb,
      0xb4,
      0xfb,
      0x66,
      0x4f,
      0xe8,
      0xb2,
      0xcf,
      0xa1,
      0x61,
      0x5f,
      0x0,
      0xe6,
      0x46,
      0x6f,
      0xff,
      0x73,
      0x2c,
      0xe1,
      0xf8,
      0xa0,
      0xc8,
      0xd2,
      0x72,
      0x74,
      0x31,
      0xd1,
      0x6f,
      0x14
    ],
  ),
  TestVectors.from(
    [
      0xf5,
      0xd8,
      0xa9,
      0x27,
      0x90,
      0x1d,
      0x4f,
      0xa4,
      0x24,
      0x90,
      0x86,
      0xb7,
      0xff,
      0xec,
      0x24,
      0xf5,
      0x29,
      0x7d,
      0x80,
      0x11,
      0x8e,
      0x4a,
      0xc9,
      0xd3,
      0xfc,
      0x9a,
      0x82,
      0x37,
      0x95,
      0x1e,
      0x3b,
      0x7f
    ],
    [
      0x3c,
      0x23,
      0x5e,
      0xdc,
      0x2,
      0xf9,
      0x11,
      0x56,
      0x41,
      0xdb,
      0xf5,
      0x16,
      0xd5,
      0xde,
      0x8a,
      0x73,
      0x5d,
      0x6e,
      0x53,
      0xe2,
      0x2a,
      0xa2,
      0xac,
      0x14,
      0x36,
      0x56,
      0x4,
      0x5f,
      0xf2,
      0xe9,
      0x52,
      0x49
    ],
    [
      0xab,
      0x95,
      0x15,
      0xab,
      0x14,
      0xaf,
      0x9d,
      0x27,
      0xe,
      0x1d,
      0xae,
      0xc,
      0x56,
      0x80,
      0xcb,
      0xc8,
      0x88,
      0xb,
      0xd8,
      0xa8,
      0xe7,
      0xeb,
      0x67,
      0xb4,
      0xda,
      0x42,
      0xa6,
      0x61,
      0x96,
      0x1e,
      0xfc,
      0xb
    ],
  ),
]);
