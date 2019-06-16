import 'dart:io';
import 'big_integer.dart';

class BigPrimeNumbers {
  static void test_01() {
    // some examples for prime numbers
    _testRange(1000);
    _testRangeBig(BigInteger("1000"));
    _testRange(10000);
    _testRangeBig(BigInteger("10000"));
  }

  static void test_02() {
    // some examples for factorization
    _factorize_01();
    _factorize_02();
  }

  static void _testRange(int max) {
    Stopwatch sw = new Stopwatch();
    sw.start();

    int found = 0;
    for (int i = 2; i < max; i++) {
      if (_isPrime(i)) found++;
    }

    sw.stop();
    print("Number of Primes up to ${max}: ${found}");
    print("[${sw.elapsedMilliseconds} msecs]");
  }

  static void _testRangeBig(BigInteger max) {
    Stopwatch sw = new Stopwatch();
    sw.start();

    BigInteger found = BigInteger.Zero;
    for (BigInteger i = BigInteger.Two; i < max; i += BigInteger.One) {
      if (_isPrimeBig(i)) found += BigInteger.One;

      if (i % BigInteger.fromInt(1000) == BigInteger.Zero) stdout.write(".");
    }

    sw.stop();
    print("Number of Primes up to ${max}: ${found}");
    print("[${sw.elapsedMilliseconds} msecs]");
  }

  static void _factorize_01() {
    int number = 13821503 * 13821503;
    List<int> result = _factorize(number);

    if (result[0] != 1) {
      print("found factors ${result[0]} and ${result[1]}.");
    } else {
      print("${number} is prime.");
    }
  }

  static void _factorize_02() {
    BigInteger n = new BigInteger("21089");
    BigInteger number = n * n;
    List<BigInteger> result = _factorizeBig(number);

    if (result[0] != BigInteger.One) {
      print("found factors ${result[0]} and ${result[1]}.");
    } else {
      print("${number} is prime.");
    }
  }

  static List<int> _factorize(int number) {
    List<int> result = [1, number];

    // factorizing a int variable using a very simple approach
    for (int i = 2; i < number; i++) {
      if ((number % i) == 0) {
        result[0] = i;
        result[1] = number ~/ i;
        break;
      }
    }

    return result;
  }

  static List<BigInteger> _factorizeBig(BigInteger number) {
    List<BigInteger> result = [BigInteger.One, number];

    // factorizing a big integer object using a very simple approach
    for (BigInteger i = BigInteger.Two; i < number; i += BigInteger.One) {
      if ((number % i) == BigInteger.Zero) {
        result[0] = i;
        result[1] = number / i;
        break;
      }
    }

    return result;
  }

  static bool _isPrime(int number) {
    // the smallest prime number is 2
    if (number <= 2) return number == 2;

    // even numbers other than 2 are not prime
    if (number % 2 == 0) return false;

    // check odd divisors from 3 to the half of the number
    // (in lack of a high precision sqare root function)
    int end = number ~/ 2 + 1;
    for (int i = 3; i <= end; i += 2) if (number % i == 0) return false;

    // found prime number
    return true;
  }

  static bool _isPrimeBig(BigInteger number) {
    // the smallest prime number is 2
    if (number <= BigInteger.Two) return number == BigInteger.Two;

    // even numbers other than 2 are not prime
    if (number % BigInteger.Two == BigInteger.Zero) return false;

    // check odd divisors from 3 to the half of the number
    // (in lack of a high precision sqare root function)
    BigInteger end = number / BigInteger.Two + BigInteger.One;
    for (BigInteger i = BigInteger.fromInt(3); i <= end; i += BigInteger.Two)
      if (number % i == BigInteger.Zero) return false;

    // found prime number
    return true;
  }
}
