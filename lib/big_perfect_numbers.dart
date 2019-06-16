import 'big_integer.dart';

class BigPerfectNumbers {
  static void test_01() {
    for (int i = 2; i < 500; i++) {
      if (_isPerfectNumber(i)) print("The value ${i} is PERFECT");
    }
  }

  static void test_02(int limit) {
    Stopwatch sw = new Stopwatch();
    sw.start();

    for (BigInteger n = BigInteger.Two;
        n < BigInteger.fromInt(limit);
        n += BigInteger.One) {
      if (_isPerfectNumberBig(n)) print("The value ${n} is PERFECT");
    }

    sw.stop();
    print("Computation Time: ${sw.elapsedMilliseconds}");
  }

  static void test_03() {
    Stopwatch sw = new Stopwatch();
    sw.start();

    // https://en.wikipedia.org/wiki/List_of_perfect_numbers
    List<String> perfectCandidates = [
      "6",
      "28",
      "496",
      "8.128",
      "33.550.336",
      "8.589.869.056",
      "137.438.691.328",
      "2.305.843.008.139.952.128",
      "2.658.455.991.569.831.744.654.692.615.953.842.176",
      "191.561.942.608.236.107.294.793.378.084.303.638.130.997.321.548.169.216"
    ];

    for (int i = 0; i < perfectCandidates.length; i++) {
      BigInteger n = new BigInteger(perfectCandidates[i]);
      if (_isPerfectNumberBig(n)) print("The value ${n} is PERFECT");
    }

    sw.stop();
    print("Computation Time: ${sw.elapsedMilliseconds}");
  }

  static bool _isPerfectNumber(int n) {
    int sumOfDivisors = 1;
    for (int i = 2; i < n / 2 + 1; i = i + 1) {
      if (n % i == 0) {
        sumOfDivisors = sumOfDivisors + i;
      }
    }

    return (n == sumOfDivisors) ? true : false;
  }

  static bool _isPerfectNumberBig(BigInteger n) {
    BigInteger sumOfDivisors = BigInteger.One;
    BigInteger limit = n / BigInteger.Two + BigInteger.One;

    for (BigInteger i = BigInteger.Two; i < limit; i += BigInteger.One) {
      if (n % i == BigInteger.Zero) {
        sumOfDivisors += i;
      }
    }

    return (n == sumOfDivisors) ? true : false;
  }
}
