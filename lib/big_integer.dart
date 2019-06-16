class BigInteger {
  static const int _Blocks = 24; // formatted output

  List<int> _digits; // digits of big number (in reverse order)
  bool _sign; // sign of big number

  // user-defined c'tor(s)
  BigInteger.zero() {
    _digits = List<int>();
    _digits.add(0);
    _sign = true;
  }

  BigInteger(String s) {
    // set sign
    _sign = (s[0] == '-') ? false : true;

    // copy digits into array in reverse order
    _digits = List<int>();
    List<int> codeUnits = s.codeUnits;
    for (int i = s.length - 1; i >= 0; i--) {
      if (codeUnits[i] >= 48 && codeUnits[i] <= 57) {
        _digits.add(codeUnits[i] - 48);
      }
    }
  }

  BigInteger.fromInt(int n) : this(n.toString());

  BigInteger.clone(BigInteger number) {
    _digits = List<int>.from(number._digits);
    _sign = number._sign;
  }

  // internal helper c'tor
  BigInteger._internal(bool sign, List<int> digits) {
    _digits = digits;
    _sign = sign;
  }

  // singletons for numbers 0, 1 and 2
  static final BigInteger _singleZero = new BigInteger.zero();
  static final BigInteger _singleOne = new BigInteger.fromInt(1);
  static final BigInteger _singleTwo = new BigInteger.fromInt(2);
  static BigInteger get Zero => _singleZero;
  static BigInteger get One => _singleOne;
  static BigInteger get Two => _singleTwo;

  // getter/setter
  bool get Sign => _sign;
  int get Cardinality => _digits.length;
  bool get IsNull => _digits.length == 1 && _digits[0] == 0;

  // public interface - binary arithmetic operators
  BigInteger add(BigInteger number) {
    // handle sign and change operation, if necessary
    if (_sign != number._sign)
      return (_sign) ? this - number.abs() : number - this.abs();

    // allocate new array
    List<int> digits = List<int>();

    // need maximum length of corresponding digit lists
    int numDigits = number.Cardinality + 1;
    if (Cardinality >= number.Cardinality) numDigits = Cardinality + 1;

    // add numbers digit per digit
    int carry = 0;
    for (int i = 0; i < numDigits; i++) {
      if (i < Cardinality) carry += _digits[i];
      if (i < number.Cardinality) carry += number._digits[i];

      digits.add(carry % 10);
      carry = carry ~/ 10;
    }

    BigInteger tmp = BigInteger._internal(_sign, digits);
    tmp._removeLeadingZeros();
    return tmp;
  }

  BigInteger sub(BigInteger number) {
    // handle sign and change operation, if necessary
    if (_sign != number.Sign)
      return (_sign) ? this + number.abs() : -(this.abs() + number);

    if (this.abs() < number.abs())
      return (_sign) ? -(number - this) : number.abs() - this.abs();

    // create copy of minuend
    BigInteger tmp = BigInteger.clone(this);

    // traverse digits of subtrahend
    for (int i = 0; i < number.Cardinality; i++) {
      if (tmp._digits[i] < number._digits[i]) {
        if (tmp._digits[i + 1] != 0) {
          tmp._digits[i + 1]--;
          tmp._digits[i] += 10;
        } else {
          // preceding digit is zero, cannot borrow directly
          int pos = i + 1;
          while (tmp._digits[pos] == 0) pos++;

          // borrow indirectly
          for (int k = pos; k >= i + 1; k--) {
            tmp._digits[k]--;
            tmp._digits[k - 1] += 10;
          }
        }
      }

      // subtract current subtrahend digit from minuend digit
      tmp._digits[i] -= number._digits[i];
    }

    tmp._removeLeadingZeros();
    return tmp;
  }

  BigInteger mul(BigInteger number) {
    // allocate fixed-length array
    List<int> digits = List<int>(this.Cardinality + number.Cardinality);
    int carry = 0;
    for (int i = 0; i < digits.length; i++) {
      digits[i] = carry;

      for (int j = 0; j < number.Cardinality; j++)
        if (i - j >= 0 && i - j < this.Cardinality)
          digits[i] += this._digits[i - j] * number._digits[j];

      carry = digits[i] ~/ 10;
      digits[i] %= 10;
    }

    bool sign = (this.Sign == number.Sign) ? true : false;

    // convert fixed-length array to growable array (necessary for _removeLeadingZeros)
    List<int> digitsGrowable = digits.toList(growable: true);

    BigInteger tmp = new BigInteger._internal(sign, digitsGrowable);
    tmp._removeLeadingZeros();
    return tmp;
  }

  BigInteger div(BigInteger number) {
    StringBuffer sbResult = new StringBuffer();
    BigInteger remainder = new BigInteger.zero();
    BigInteger bAbs = number.abs(); // positive divisor

    int pos = this.Cardinality - 1;
    while (pos >= 0) {
      // append next digit from dividend to temporary divisor
      int len = (remainder.IsNull) ? 1 : remainder.Cardinality + 1;
      List<int> digits = List<int>(len);

      // copy old digits
      for (int k = 0; k < len - 1; k++) digits[k + 1] = remainder._digits[k];

      // fetch digit from dividend
      digits[0] = this._digits[pos];

      remainder = BigInteger._internal(true, digits);

      // divide current dividend with divisor
      int n = 0;
      while (bAbs <= remainder) {
        n++;
        remainder -= bAbs;
      }

      sbResult.write(n.toString());

      // fetch next digit from divisor
      pos--;
    }

    BigInteger result = new BigInteger(sbResult.toString());
    result._sign = (this.Sign == number.Sign) ? true : false;
    result._removeLeadingZeros();
    return result;
  }

  BigInteger mod(BigInteger number) {
    return this - number * (this / number);
  }

  // public (helper) methods
  BigInteger abs() {
    BigInteger tmp = BigInteger.clone(this);
    tmp._sign = true;
    return tmp;
  }

  BigInteger power(int exponent) {
    if (exponent == 0) return BigInteger.One;

    BigInteger result = BigInteger.clone(this);
    if (exponent == 1) return result;

    for (int i = 1; i < exponent; i++) result = result * this;
    if (!this._sign && exponent % 2 == 1) result._sign = this._sign;
    return result;
  }

  // unary '-' operator
  BigInteger operator -() {
    BigInteger tmp = BigInteger.clone(this);
    tmp._sign = !_sign;
    return tmp;
  }

  // binary arithmetic operators
  BigInteger operator +(BigInteger number) => this.add(number);
  BigInteger operator -(BigInteger number) => this.sub(number);
  BigInteger operator *(BigInteger number) => this.mul(number);
  BigInteger operator /(BigInteger number) => this.div(number);
  BigInteger operator %(BigInteger number) => this.mod(number);

  // comparison operators
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is BigInteger)) return false;

    final BigInteger tmp = other;
    if (_digits.length != tmp._digits.length) return false;

    for (int i = 0; i < _digits.length; i++) {
      if (_digits[i] != tmp._digits[i]) return false;
    }

    return true;
  }

  bool operator <(Object other) => (this._compareTo(other) < 0) ? true : false;
  bool operator <=(Object other) =>
      (this._compareTo(other) <= 0) ? true : false;
  bool operator >(Object other) => this < other;
  bool operator >=(Object other) => this <= other;

  @override
  String toString() {
    StringBuffer tmp = StringBuffer();
    if (!_sign) tmp.write('-');

    for (int i = _digits.length - 1; i >= 0; i--) {
      tmp.write(_digits[i]);
      if (i > 0 && i % 3 == 0) {
        tmp.write('.');
      }
    }
    return tmp.toString();
  }

  String toStringFormatted() {
    StringBuffer tmp = StringBuffer();
    if (!_sign) tmp.write('-');

    // append leading spaces, if necessary
    if (this.Cardinality > 3 * _Blocks) {
      if (this.Cardinality % 3 == 1)
        tmp.write((!this._sign) ? " " : "  ");
      else if (this.Cardinality % 3 == 2)
        tmp.write((!this._sign) ? "" : " ");
      else if (this.Cardinality % 3 == 0) tmp.write((!this._sign) ? "\n" : "");
    }

    int linebreak = 0;
    for (int i = _digits.length - 1; i >= 0; i--) {
      tmp.write(_digits[i]);
      if (i > 0 && i % 3 == 0) {
        tmp.write('.');
        linebreak++;
        if (linebreak % _Blocks == 0) tmp.write("\n");
      }
    }
    return tmp.toString();
  }

  // private helper methods
  int _compareTo(BigInteger a) {
    if (this._sign && !a._sign) return 1;
    if (!this._sign && a._sign) return -1;

    int order = 0;
    if (this.Cardinality < a.Cardinality) {
      order = -1;
    } else if (this.Cardinality > a.Cardinality) {
      order = 1;
    } else {
      for (int i = this.Cardinality - 1; i >= 0; i--) {
        if (this._digits[i] < a._digits[i]) {
          order = -1;
          break;
        } else if (this._digits[i] > a._digits[i]) {
          order = 1;
          break;
        }
      }
    }

    return (this._sign) ? order : -order;
  }

  void _removeLeadingZeros() {
    while (_digits.length > 1 && _digits[_digits.length - 1] == 0) {
      _digits.removeLast();
    }
  }
}
