import 'dart:io';
import 'big_integer.dart';

class BigPowerByTwo {
  static void test_01_power_by_two() {
    Stopwatch sw = new Stopwatch();
    sw.start();

    BigInteger power = BigInteger.One;
    for (int i = 1; i <= 100; i++) {
      power = power * BigInteger.Two;

      print('2 ^ ${i} = ${power}');
    }

    sw.stop();
    print("[${sw.elapsedMilliseconds} msecs]");
  }

  static void test_02_power_by_two() {
    Stopwatch sw = new Stopwatch();
    sw.start();

    BigInteger huge = BigInteger("2.475.880.078.570.760.549.798.248.448");
    while (huge != BigInteger.One) {
      // cout << huge << " / 2 = ";
      stdout.write('${huge} / 2 = ');
      huge = huge / BigInteger.Two;
      // cout << huge << endl;
      print('${huge}');
    }

    sw.stop();
    print("[${sw.elapsedMilliseconds} msecs]");
  }
}
