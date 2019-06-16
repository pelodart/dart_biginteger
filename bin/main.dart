import '../lib/big_faculty.dart';
import '../lib/big_fibonacci.dart';
import '../lib/big_mersenne_numbers.dart';
import '../lib/big_perfect_numbers.dart';
import '../lib/big_power_by_two.dart';
import '../lib/big_prime_numbers.dart';
import '../lib/test_routines.dart';

void main() {
  // testGeneral();
  testMathFunctions();
  print('Done');
}

void testGeneral() {
  BigIntegerTest.test_ctors();
  BigIntegerTest.test_toString();
  BigIntegerTest.test_equals();
  BigIntegerTest.test_clone();

  BigIntegerTest.test_add_01_unsigned();
  BigIntegerTest.test_add_02_signed();
  BigIntegerTest.test_add_03_signed();

  BigIntegerTest.test_sub_01_unsigned();
  BigIntegerTest.test_sub_02_signed();
  BigIntegerTest.test_sub_03_signed();

  BigIntegerTest.test_mul_01_unsigned();
  BigIntegerTest.test_mul_02_signed();
  BigIntegerTest.test_mul_03_signed();

  BigIntegerTest.test_div_01_unsigned();
  BigIntegerTest.test_div_02_signed();

  BigIntegerTest.test_mod_01_signed();
  BigIntegerTest.test_mod_02_signed();
}

void testMathFunctions() {
  // testing prime numbers
//   BigPrimeNumbers.test_01();
//   BigPrimeNumbers.test_02();


  // testing faculties
  // BigFaculty.test_01(50);  // using int data-type (partially wrong results)
  BigFaculty.test_02(50); // using BigInteger

  return; // TODO: Wieder entfernen !!!

  // testing fibonacci numbers
  BigFibonacci.test_01(30);  // built-in data types, recursive
  BigFibonacci.test_02(100); // built-in data types, iterative
  BigFibonacci.test_03(30);  // using BigInteger, recursive
  BigFibonacci.test_04(100); // using BigInteger, iterative

  // testing mersenne prime numbers
  BigMersenneNumbers.test_01();
  BigMersenneNumbers.test_02();

  // testing power method
  BigPowerByTwo.test_01_power_by_two();
  BigPowerByTwo.test_02_power_by_two();

  // testing perfect numbers
  BigPerfectNumbers.test_01();
  BigPerfectNumbers.test_02(10000);
  BigPerfectNumbers.test_03();
}
