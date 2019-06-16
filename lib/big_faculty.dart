import 'big_integer.dart';

class BigFaculty {
  static void test_01(int limit) {
    Stopwatch sw = new Stopwatch();
    sw.start();

    for (int n = 1; n < limit; n++) {
      int f = faculty(n);
      print("Faculty of ${n}: ${f}");
    }

    sw.stop();
    print("[${sw.elapsedMilliseconds} msecs]");
  }

  static void test_02(int limit) {
    Stopwatch sw = new Stopwatch();
    sw.start();

    BigInteger upperLimit = BigInteger.fromInt(limit);
    for (BigInteger n = BigInteger.One; n < upperLimit; n += BigInteger.One) {
      BigInteger f = facultyBig(n);
      print("Faculty of ${n}: ${f.toStringFormatted()}");
    }

    sw.stop();
    print("[${sw.elapsedMilliseconds} msecs]");
  }

  static int faculty(int n) {
    if (n == 1)
      return 1;
    else
      return n * faculty(n - 1);
  }

  static BigInteger facultyBig(BigInteger n) {
    if (n == BigInteger.One) {
      return BigInteger.One;
    } else {
      return n * facultyBig(n - BigInteger.One);
    }
  }
}
