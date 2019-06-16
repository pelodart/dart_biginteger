import 'big_integer.dart';

class BigMersenneNumbers {
  static void test_01() {
    Stopwatch sw = new Stopwatch();
    sw.start();

    BigInteger mersenne = BigInteger.Two;
    mersenne = mersenne.power(11213);
    mersenne = mersenne - BigInteger.One;

    sw.stop();

    print("Mersenne:");
    print("${mersenne.toStringFormatted()}");
    print("Number of Digits: ${mersenne.Cardinality}");
    print("Computation Time: ${sw.elapsedMilliseconds}");
  }

  static void test_02() {
    Stopwatch sw = new Stopwatch();

    // list of known Mersenne primes
    // see https://en.wikipedia.org/wiki/Mersenne_prime
    List<int> power = [
      2,
      3,
      5,
      7,
      13,
      17,
      19,
      31,
      61,
      89,
      107,
      127,
      521,
      607,
      1279,
      2203,
      2281,
      3217,
      4253,
      4423,
      9689,
      9941,
      11213,
      19937,
      21701,
      23209,
      44497,
      86243,
      110503,
      132049,
      216091,
      756839,
      859433
    ];

    for (int i = 0; i < power.length; i++) {
      int pow = power[i];

      sw.start();
      BigInteger mersenne = BigInteger.Two;
      mersenne = mersenne.power(pow);
      mersenne = mersenne - BigInteger.One;
      sw.stop();

      print("${i + 1}.th Mersenne Prime:");
      print("${mersenne}");
      print(
          "Number of Digits: ${mersenne.Cardinality} [Computation time: ${sw.elapsedMilliseconds} msecs]");
      print('');
    }
  }
}
