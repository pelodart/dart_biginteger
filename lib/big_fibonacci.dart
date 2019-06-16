import 'big_integer.dart';

class BigFibonacci {
  static void test_01(int max) {
    Stopwatch sw = new Stopwatch();
    sw.start();

    for (int i = 1; i < max; i++) {
      int f = _fibonacciRecursive(i);
      print("Fibonacci of ${i}: ${f}");
    }

    sw.stop();
    print("[${sw.elapsedMilliseconds} msecs]");
  }

  static void test_02(int max) {
    Stopwatch sw = new Stopwatch();
    sw.start();

    for (int i = 1; i < max; i++) {
      int f = _fibonacciIterative(i);
      print("Fibonacci of ${i}: ${f}");
    }

    sw.stop();
    print("[${sw.elapsedMilliseconds} msecs]");
  }

  static void test_03(int max) {
    Stopwatch sw = new Stopwatch();
    sw.start();

    BigInteger limit = BigInteger.fromInt(max);
    for (BigInteger n = BigInteger.Two; n < limit; n += BigInteger.One) {
      BigInteger f = _fibonacciRecursiveBig(n);
      print("Fibonacci of ${n}: ${f}");
    }

    sw.stop();
    print("[${sw.elapsedMilliseconds} msecs]");
  }

  static void test_04(int max) {
    Stopwatch sw = new Stopwatch();
    sw.start();

    BigInteger limit = BigInteger.fromInt(max);
    for (BigInteger n = BigInteger.Two; n < limit; n += BigInteger.One) {
      BigInteger f = _fibonacciIterativeBig(n);
      print("Fibonacci of ${n}: ${f}");
    }

    sw.stop();
    print("[${sw.elapsedMilliseconds} msecs]");
  }

  static int _fibonacciRecursive(int n) {
    if (n == 1 || n == 2)
      return 1;
    else
      return _fibonacciRecursive(n - 1) + _fibonacciRecursive(n - 2);
  }

  static BigInteger _fibonacciRecursiveBig(BigInteger n) {
    if (n == BigInteger.One || n == BigInteger.Two)
      return BigInteger.One;
    else
      return _fibonacciRecursiveBig(n - BigInteger.One) +
          _fibonacciRecursiveBig(n - BigInteger.Two);
  }

  static int _fibonacciIterative(int n) {
    if (n == 1) {
      return 1;
    } else {
      int a = 0;
      int b = 1;
      int i = 2;
      while (i <= n) {
        int tmp_a = b;
        int tmp_b = a + b;
        a = tmp_a;
        b = tmp_b;
        i++;
      }

      return b;
    }
  }

  static BigInteger _fibonacciIterativeBig(BigInteger n) {
    if (n == BigInteger.One) {
      return BigInteger.One;
    } else {
      BigInteger a = BigInteger.Zero;
      BigInteger b = BigInteger.One;
      BigInteger i = BigInteger.Two;

      while (i <= n) {
        BigInteger tmp_a = b;
        BigInteger tmp_b = a + b;
        a = tmp_a;
        b = tmp_b;
        i += BigInteger.One;
      }

      return b;
    }
  }
}
