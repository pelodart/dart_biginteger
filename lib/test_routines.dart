import 'big_integer.dart';

class BigIntegerTest {
  static void test_ctors() {
    // testing c'tors
    BigInteger zero = BigInteger.zero();
    print('${zero}');

    BigInteger n = new BigInteger('12345');
    print('${n}');

    n = new BigInteger('12345678901234567890123456789012345678901234567890');
    print('${n}');
    n = new BigInteger('-12345678901234567890123456789012345678901234567890');
    print('${n}');
    n = new BigInteger('-123.456.789.012.345.678');
    print('${n}');
    print('');
  }

  static void test_toString() {
    // testing toString
    BigInteger n;

    n = new BigInteger("+123.456.789.012");
    print('${n}');
    n = new BigInteger("-123.456.789.012");
    print('${n}');

    n = new BigInteger("123.456.789.012");
    print('${n}');
    n = new BigInteger("12.345.678.901");
    print('${n}');
    n = new BigInteger("1.234.567.890");
    print('${n}');
    n = new BigInteger("123.456.789");
    print('${n}');

    print('');
  }

  static void test_equals() {
    BigInteger n1 = new BigInteger("123456789");
    BigInteger n2 = new BigInteger("123456789");
    print("${n1} Equals ${n2}: ${n1 == n2}");

    n1 += BigInteger.One;
    print("${n1} Equals ${n2}: ${n1 == n2}");
    n1 -= BigInteger.One;
    print("${n1} Equals ${n2}: ${n1 == n2}");
  }

  static void test_clone() {
    BigInteger n1 = new BigInteger('12345');
    print('${n1}');
    BigInteger n2 = BigInteger.clone(n1);
    print('${n2}');
    print('');
  }

  static void test_add_01_unsigned_simple() {
    // testing unsigned add operation
    BigInteger n1;
    BigInteger n2;

    n1 = new BigInteger('123');
    n2 = new BigInteger('321');
    print('${n1} + ${n2} = ${n1 + n2}');

    n1 = new BigInteger('999');
    n2 = new BigInteger('1');
    print('${n1} + ${n2} = ${n1 + n2}');
    print('');
  }

  static void test_add_01_unsigned() {
    // testing unsigned add operation
    BigInteger n1;
    BigInteger n2;

    n1 = new BigInteger('12345678');
    n2 = new BigInteger('87654321');
    print('${n1} + ${n2} = ${n1 + n2}');

    n1 = new BigInteger('99999999999999');
    n2 = new BigInteger('1');
    print('${n1} + ${n2} = ${n1 + n2}');
    print('');
  }

  static void test_add_02_signed() {
    // testing signed add operation
    BigInteger n1;
    BigInteger n2;

    n1 = new BigInteger('333');
    n2 = new BigInteger('222');
    print('${n1} + ${n2} = ${n1 + n2}');

    n1 = new BigInteger('-333');
    n2 = new BigInteger('222');
    print('${n1} + ${n2} = ${n1 + n2}');

    n1 = new BigInteger('333');
    n2 = new BigInteger('-222');
    print('${n1} + ${n2} = ${n1 + n2}');

    n1 = new BigInteger('-333');
    n2 = new BigInteger('-222');
    print('${n1} + ${n2} = ${n1 + n2}');
    print('');
  }

  static void test_add_03_signed() {
    // testing signed add operation
    int n1;
    int n2;

    n1 = 98765432123456789;
    n2 = 989898989898;
    print('${n1} + ${n2} = ${n1 + n2}');

    n1 = -98765432123456789;
    n2 = 989898989898;
    print('${n1} + ${n2} = ${n1 + n2}');

    n1 = 98765432123456789;
    n2 = -989898989898;
    print('${n1} + ${n2} = ${n1 + n2}');

    n1 = -98765432123456789;
    n2 = -989898989898;
    print('${n1} + ${n2} = ${n1 + n2}');
    print('');

    // testing signed add operation
    BigInteger b1;
    BigInteger b2;

    b1 = BigInteger.fromInt(98765432123456789);
    b2 = BigInteger.fromInt(989898989898);
    print('${b1} + ${b2} = ${b1 + b2}');

    b1 = BigInteger.fromInt(-98765432123456789);
    b2 = BigInteger.fromInt(989898989898);
    print('${b1} + ${b2} = ${b1 + b2}');

    b1 = BigInteger.fromInt(98765432123456789);
    b2 = BigInteger.fromInt(-989898989898);
    print('${b1} + ${b2} = ${b1 + b2}');

    b1 = BigInteger.fromInt(-98765432123456789);
    b2 = BigInteger.fromInt(-989898989898);
    print('${b1} + ${b2} = ${b1 + b2}');
    print('');
  }

  static void test_sub_01_unsigned() {
    // testing unsigned sub operation
    BigInteger b1;
    BigInteger b2;

    b1 = new BigInteger('999');
    b2 = new BigInteger('900');
    print('${b1} - ${b2} = ${b1 - b2}');

    b1 = new BigInteger('999');
    b2 = new BigInteger('998');
    print('${b1} - ${b2} = ${b1 - b2}');

    b1 = new BigInteger('999');
    b2 = new BigInteger('999');
    print('${b1} - ${b2} = ${b1 - b2}');

    b1 = new BigInteger('11111');
    b2 = new BigInteger('222');
    print('${b1} - ${b2} = ${b1 - b2}');

    b1 = new BigInteger('1000000');
    b2 = new BigInteger('1');
    print('${b1} - ${b2} = ${b1 - b2}');
    print('');
  }

  static void test_sub_02_signed() {
    // testing signed sub operation
    BigInteger n1;
    BigInteger n2;

    n1 = new BigInteger('333');
    n2 = new BigInteger('222');
    print('${n1} - ${n2} = ${n1 - n2}');

    n1 = new BigInteger('-333');
    n2 = new BigInteger('222');
    print('${n1} - ${n2} = ${n1 - n2}');

    n1 = new BigInteger('333');
    n2 = new BigInteger('-222');
    print('${n1} - ${n2} = ${n1 - n2}');

    n1 = new BigInteger('-333');
    n2 = new BigInteger('-222');
    print('${n1} - ${n2} = ${n1 - n2}');
    print('');

    // -----------------------------------------------------

    n1 = new BigInteger('222');
    n2 = new BigInteger('333');
    print('${n1} - ${n2} = ${n1 - n2}');

    n1 = new BigInteger('-222');
    n2 = new BigInteger('333');
    print('${n1} - ${n2} = ${n1 - n2}');

    n1 = new BigInteger('222');
    n2 = new BigInteger('-333');
    print('${n1} - ${n2} = ${n1 - n2}');

    n1 = new BigInteger('-222');
    n2 = new BigInteger('-333');
    print('${n1} - ${n2} = ${n1 - n2}');
    print('');
  }

  static void test_sub_03_signed() {
    // testing c'tors
    int n1;
    int n2;

    n1 = 98765432123456789;
    n2 = 989898989898;
    print('${n1} - ${n2} = ${n1 - n2}');

    n1 = -98765432123456789;
    n2 = 989898989898;
    print('${n1} - ${n2} = ${n1 - n2}');

    n1 = 98765432123456789;
    n2 = -989898989898;
    print('${n1} - ${n2} = ${n1 - n2}');

    n1 = -98765432123456789;
    n2 = -989898989898;
    print('${n1} - ${n2} = ${n1 - n2}');
    print('');

    BigInteger b1;
    BigInteger b2;

    b1 = BigInteger.fromInt(98765432123456789);
    b2 = BigInteger.fromInt(989898989898);
    print('${b1} - ${b2} = ${b1 - b2}');

    b1 = BigInteger.fromInt(-98765432123456789);
    b2 = BigInteger.fromInt(989898989898);
    print('${b1} - ${b2} = ${b1 - b2}');

    b1 = BigInteger.fromInt(98765432123456789);
    b2 = BigInteger.fromInt(-989898989898);
    print('${b1} - ${b2} = ${b1 - b2}');

    b1 = BigInteger.fromInt(-98765432123456789);
    b2 = BigInteger.fromInt(-989898989898);
    print('${b1} - ${b2} = ${b1 - b2}');
    print('');

    // ---------------------------------------------------

    n1 = 989898989898;
    n2 = 98765432123456789;
    print('${n1} - ${n2} = ${n1 - n2}');

    n1 = 989898989898;
    n2 = -98765432123456789;
    print('${n1} - ${n2} = ${n1 - n2}');

    n1 = -989898989898;
    n2 = 98765432123456789;
    print('${n1} - ${n2} = ${n1 - n2}');

    n1 = -989898989898;
    n2 = -98765432123456789;
    print('${n1} - ${n2} = ${n1 - n2}');
    print('');

    // ---------------------------------------------------

    b1 = BigInteger.fromInt(989898989898);
    b2 = BigInteger.fromInt(98765432123456789);
    print('${b1} - ${b2} = ${b1 - b2}');

    b1 = BigInteger.fromInt(989898989898);
    b2 = BigInteger.fromInt(-98765432123456789);
    print('${b1} - ${b2} = ${b1 - b2}');

    b1 = BigInteger.fromInt(-989898989898);
    b2 = BigInteger.fromInt(98765432123456789);
    print('${b1} - ${b2} = ${b1 - b2}');

    b1 = BigInteger.fromInt(-989898989898);
    b2 = BigInteger.fromInt(-98765432123456789);
    print('${b1} - ${b2} = ${b1 - b2}');
    print('');
  }

  // ---------------------------------------------------

  static void test_mul_01_unsigned() {
    // testing unsigned mul operation
    BigInteger n1;
    BigInteger n2;

    n1 = new BigInteger.fromInt(99);
    n2 = new BigInteger.fromInt(99);
    print('${n1} * ${n2} = ${n1 * n2}');

    n1 = new BigInteger.fromInt(9999999999);
    n2 = new BigInteger.fromInt(9999999999);
    print('${n1} * ${n2} = ${n1 * n2}');

    // testing multiplication
    n1 = new BigInteger('1212121212');
    n2 = new BigInteger('4343434343');
    print('${n1} * ${n2} = ${n1 * n2}');

    // multiplication example from script
    n1 = new BigInteger('973018');
    n2 = new BigInteger('9758');
    print('${n1} * ${n2} = ${n1 * n2}');

    // testing multiplication
    n1 = new BigInteger('3');
    n2 = new BigInteger('50');
    print('${n1} * ${n2} = ${n1 * n2}');
    print('');
  }

  static void test_mul_02_signed() {
    // testing signed mul operation
    BigInteger n1;
    BigInteger n2;

    n1 = new BigInteger('333');
    n2 = new BigInteger('222');
    print('${n1} * ${n2} = ${n1 * n2}');

    n1 = new BigInteger('-333');
    n2 = new BigInteger('222');
    print('${n1} * ${n2} = ${n1 * n2}');

    n1 = new BigInteger('333');
    n2 = new BigInteger('-222');
    print('${n1} * ${n2} = ${n1 * n2}');

    n1 = new BigInteger('-333');
    n2 = new BigInteger('-222');
    print('${n1} * ${n2} = ${n1 * n2}');
    print('');
  }

  static void test_mul_03_signed() {
    // testing signed mul operation
    BigInteger n1 = BigInteger.fromInt(98765432123456789);
    BigInteger n2 = BigInteger.fromInt(989898989898);
    print('${n1} * ${n2} = ${n1 * n2}');

    n1 = BigInteger.fromInt(-98765432123456789);
    n2 = BigInteger.fromInt(989898989898);
    print('${n1} * ${n2} = ${n1 * n2}');

    n1 = BigInteger.fromInt(98765432123456789);
    n2 = BigInteger.fromInt(-989898989898);
    print('${n1} * ${n2} = ${n1 * n2}');

    n1 = BigInteger.fromInt(-98765432123456789);
    n2 = BigInteger.fromInt(-989898989898);
    print('${n1} * ${n2} = ${n1 * n2}');
    print('');
  }

  // ---------------------------------------------------

  static void test_div_01_unsigned() {
    // testing unsigned div operation
    BigInteger n1;
    BigInteger n2;

    // 10
    n1 = BigInteger.fromInt(100);
    n2 = BigInteger.fromInt(10);
    print('${n1} / ${n2} = ${n1 / n2}');

    // 34.096
    n1 = BigInteger.fromInt(6682850);
    n2 = BigInteger.fromInt(196);
    print('${n1} / ${n2} = ${n1 / n2}');

    // 3003
    n1 = BigInteger.fromInt(30027000);
    n2 = BigInteger.fromInt(9999);
    print('${n1} / ${n2} = ${n1 / n2}');

    // 13.821.503
    n1 = BigInteger.fromInt(191033945179009);
    n2 = BigInteger.fromInt(13821503);
    print('${n1} / ${n2} = ${n1 / n2}');

    // 3707
    n1 = new BigInteger("1234567");
    n2 = new BigInteger("333");
    print('${n1} / ${n2} = ${n1 / n2}');

    // 22985
    n1 = new BigInteger("7654321");
    n2 = new BigInteger("333");
    print('${n1} / ${n2} = ${n1 / n2}');

    // 33
    n1 = new BigInteger("1111");
    n2 = new BigInteger("33");
    print('${n1} / ${n2} = ${n1 / n2}');
    print('');
  }

  static void test_div_02_signed() {
    // testing signed div operation
    BigInteger n1;
    BigInteger n2;

    n1 = BigInteger.fromInt(1000);
    n2 = BigInteger.fromInt(33);
    print('${n1} / ${n2} = ${n1 / n2}');

    n1 = BigInteger.fromInt(-1000);
    n2 = BigInteger.fromInt(33);
    print('${n1} / ${n2} = ${n1 / n2}');

    n1 = BigInteger.fromInt(1000);
    n2 = BigInteger.fromInt(-33);
    print('${n1} / ${n2} = ${n1 / n2}');

    n1 = BigInteger.fromInt(-1000);
    n2 = BigInteger.fromInt(-33);
    print('${n1} / ${n2} = ${n1 / n2}');
    print('');
  }

  // ---------------------------------------------------

  static void test_mod_01_signed() {
    // testing signed modulus operation
    BigInteger n1;
    BigInteger n2;

    n1 = BigInteger.fromInt(1000);
    n2 = BigInteger.fromInt(33);
    print('${n1} % ${n2} = ${n1 % n2}');

    n1 = BigInteger.fromInt(-1000);
    n2 = BigInteger.fromInt(33);
    print('${n1} % ${n2} = ${n1 % n2}');

    n1 = BigInteger.fromInt(1000);
    n2 = BigInteger.fromInt(-33);
    print('${n1} % ${n2} = ${n1 % n2}');

    n1 = BigInteger.fromInt(-1000);
    n2 = BigInteger.fromInt(-33);
    print('${n1} % ${n2} = ${n1 % n2}');
    print('');
  }

  static void test_mod_02_signed() {
    // testing signed modulus operation - from Wikipedia ("Division mit Rest")
    BigInteger n1;
    BigInteger n2;

    n1 = BigInteger.fromInt(7);
    n2 = BigInteger.fromInt(3);
    print('${n1} % ${n2} = ${n1 % n2}');

    n1 = BigInteger.fromInt(-7);
    n2 = BigInteger.fromInt(3);
    print('${n1} % ${n2} = ${n1 % n2}');

    n1 = BigInteger.fromInt(7);
    n2 = BigInteger.fromInt(-3);
    print('${n1} % ${n2} = ${n1 % n2}');

    n1 = BigInteger.fromInt(-7);
    n2 = BigInteger.fromInt(-3);
    print('${n1} % ${n2} = ${n1 % n2}');
    print('');
  }
}
