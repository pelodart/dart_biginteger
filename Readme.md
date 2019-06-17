# Klasse `BigInteger`

Der ganzzahlige Standarddatentyp ``int`` in Dart besitzt die Eigenschaft, dass sein Wertebereich limitiert ist. Für viele Anwendungen ist dies nicht nachteilig, da sich speziell mit den Datentypen ``int`` (oder auch ``num``) ziemlich große Zahlen darstellen lassen. Für manche Anwendungen ist die Verarbeitung von ganzen Zahlen beliebiger Größe jedoch unabdingbar. Wir stellen im Folgenden eine Klasse ``BigInteger`` vor, die eine exakte Arithmetik vorzeichenbehafteter ganzer Zahlen beliebiger Größe zur Verfügung stellt.

Um potentiell beliebig viele Ziffern einer sehr großen Zahl in einem BigInteger-Objekt abzulegen, gibt es mehrere Möglichkeiten wie etwa die Verwendung (generischer) Standardcontainer (Klasse ``List<int>``) oder auch einfach auch nur die Ablage der Ziffern in einer Zeichenkette (Klasse ``String``). In der vorgestellten Lösung zu dieser Aufgabe legen wir ein Array in der Variante *growable* List - also keine *fixed-length* List - zu Grunde.

## Grundgerüst der Klasse `BigInteger`

Unsere Kenntnisse aus der Schulmathematik zur schriftlichen Addition, Multiplikation usw. stellen die Grundlage für die Implementierung der arithmetischen Operatoren in der ``BigInteger``-Klasse dar. Vermutlich sind Ihre Erinnerungen hierzu, wie meine auch, zwischenzeitlich recht verschwommen. In den nachfolgenden Hinweisen finden Sie einen kurzen Auffrischungskurs dieser schulmathematischen Grundlagen vor. Damit kein Missverständnis entsteht: Zum Rechnen mit einzelnen Ziffern der sehr großen Zahlen dürfen Sie die Standardoperatoren von Dart wie ``+`` oder ``*`` natürlich verwenden. In der Klasse ``BigInteger`` sind diese neu zu implementieren, eben um auch mit sehr großen Zahlen exakt arithmetisch rechnen zu können.

Erste Hinweise zur ``BigInteger``-Klasse (Konstruktoren) finden Sie in Tabelle 1 vor:

| Konstruktor | Schnittstelle und Beschreibung |
|:-------------- |-----|
| ``BigInteger.zero`` | ``BigInteger.zero();``<br/> Erzeugt ein ``BigInteger``-Objekt mit dem Wert 0. |
| ``BigInteger`` | ``BigInteger(String s);``<br/> Erzeugt ein ``BigInteger``-Objekt mit Hilfe der Beschreibung einer Zahl in Form einer Zeichenkette. Die Zeichenkette darf optional mit einem Plus- oder Minuszeichen beginnen, um das Vorzeichen der Zahl festzulegen. Danach folgen beliebig viele dezimale Ziffern: <br/> ``BigInteger a ("+11111111111111111111111111111111111111");`` <br/> Mit Ausnahme von Punkten dürfen in der Zeichenkette keine anderen Zeichen enthalten sein. Punkte sind der besseren Lesbarkeit halber in der Zeichenkette zulässig, wie etwa ``"123.456.789"``.|
| ``BigInteger.fromInt`` | ``BigInteger.fromInt(int n);``<br/> Erzeugt ein ``BigInteger``-Objekt zu einem ``int``-Wert ``n``. |
| ``BigInteger.clone`` | ``BigInteger.clone(BigInteger number);``<br/> Erzeugt eine Kopie eines  ``BigInteger``-Objekts - siehe Parameter ``number``. |

Tabelle 1. Konstruktoren der Klasse ``BigInteger``.

Das Vorzeichen, die Anzahl der Ziffern und das Prädikat IsNull werden in der Klasse ``BigInteger`` durch *getter*-Methoden realisiert (Tabelle 2):

| getter | Schnittstelle und Beschreibung |
|:-------------- |---|
| ``Sign``   | ``bool get Sign``<br/> Liefert das Vorzeichen der Zahl zurück, ``true`` entspricht einer positiven Zahl, ``false`` einer negativen. |
| ``Cardinality``   | ``int get Cardinality``<br/> Liefert die Anzahl der Ziffern der Zahl zurück, auch *Stelligkeit* der ganzen Zahl genannt. |
| ``IsNull``   | ``bool get IsNull``<br/> Liefert ``true`` zurück, wenn die Zahl den Wert 0 besitzt, andernfalls ``false``. |

Tabelle 2. *getter*-Methoden der Klasse ``BigInteger``.

## Arithmetische Operatoren der Klasse `BigInteger`

Wir geben nun einige Hinweise zu den Grundrechenarten, wie sie in der Schulmathematik gelehrt werden. Bei der so genannten *schriftlichen Addition* werden die zu addierenden Zahlen rechtsbündig so angeordnet, dass jeweils gleichwertige Ziffern (Einer unter Einer, Zehner unter Zehner usw.) untereinander stehen. Man addiert dann die jeweils untereinander stehenden Ziffern, beginnend mit den Einern. Ergeben die addierten Ziffern eine Zahl größer oder gleich 10, berücksichtigt man den Übertrag bei der Addition der nächsten zwei Ziffern, siehe Abbildung 1:

<img src="assets/Schulmathematik_Addition_02.png" width="100">
Abbildung 1. Schriftliche Addition der Schulmathematik.

Bei der Umsetzung der schriftlichen Addition in ein Programm stellt sich die Frage, in welcher Reihenfolge die einzelnen Ziffern im korrespondierenden Array (``List<int>``-Objekt) des ``BigInteger``-Objekts abgelegt werden. Da die einzelnen Ziffern stellenweise, beginnend mit der niedrigstwertigen Stelle, zu addieren sind, bietet es sich an, die einzelnen Ziffern in umgekehrter Reihenfolge im Array abzuspeichern. Wenn wir das Beispiel aus Abbildung 1 noch einmal betrachten, so würde die Ablage und Verarbeitung der beiden Zahlen 28345 und 7567 in einem ``BigInteger``-Objekt wie in Abbildung 2 aussehen:

<img src="assets/Schulmathematik_Addition_03.png" width="340">
Abbildung 2. Ablage der Ziffern in umgekehrter Reihenfolge.

Die schriftliche Subtraktion funktioniert prinzipiell zunächst einmal so wie die schriftliche Addition. Beginnend mit der niedrigstwertigen Stelle wird Stelle für Stelle die Ziffer des Subtrahenden (untere Ziffer) von der Ziffer des Minuenden (obere Ziffer) abgezogen. Ein Problem entsteht, wenn die obere Ziffer kleiner ist als die dazugehörige untere des Subtrahenden, so dass die Subtraktion der zwei Ziffern nicht durchgeführt werden kann. Hier gibt es mehrere Verfahren zur Lösung des Problems. Wir skizzieren im Folgenden das so genannte *Entbündelungsverfahren*. Subtrahieren mit Entbündeln bedeutet, dass der zu kleine Minuend bei seinem linken Nachbarn eine „Anleihe“ macht. Durch Borgen von der nächsthöheren Stelle wird die Ziffer des Minuenden um 10 erhöht, und zum Zwecke des Ausgleichs die nächsthöherwertige Ziffer des Minuenden um 1 erniedrigt. Auf diese Weise kann man stets erreichen, dass die untenliegende Ziffer von der obenliegenden abgezogen werden kann, wie wir im Beispiel aus Abbildung 3 vorführen:

<img src="assets/Schulmathematik_Subtraktion.png" width="200">
Abbildung 3. Entbündelungsverfahren für Subtraktion.

Die Subtraktion der Einerstelle in Abbildung 3 bereitet keine Probleme, 4 minus 2 ist gleich 2. Die Zehnerstellen lassen sich zunächst nicht abziehen, der Minuend (6) ist zu klein. Er wird darum um 10 erhöht, also gleich 16 gesetzt. Diese 10 wird von der links daneben stehenden Ziffer (8) geliehen und deshalb wird diese um 1 erniedrigt (neuer Wert 7). Nun können die nächsten zwei Subtraktionen (16 minus 9 und 7 minus 5) problemlos durchgeführt werden und man erhält 272 als korrektes Gesamtergebnis der Subtraktion.

*Hinweis*: Einen Sonderfall müssen Sie in Ihrer Implementierung noch beachten, nämlich wenn beim Leihen die korrespondierende Ziffer des Minuenden gleich 0 ist. Von 0 lässt sich bekanntermaßen nichts borgen (ein Wert -1 stellt hier keine Lösung des Problems dar), es muss folglich Stelle für Stelle in Richtung der höherwertigen Stellen solange weitergesucht werden, bis eine erste Ziffer ungleich 0 vorliegt. Nun kann hier der Leihvorgang stattfinden und der geliehene Wert über alle Zwischenstellen nach unten durchgereicht werden. In Abbildung 4 finden Sie ein Beispiel für diese Situation vor. Um 1 von 1000 abziehen zu können, muss zum Leihen drei Stellen nach links gegangen werden:

<img src="assets/Schulmathematik_Subtraktion_02.png" width="240">
Abbildung 4. Entbündelungsverfahren mit Null als linkem Nachbarn.

Damit sind wir bei der Multiplikation angekommen. Das Standardverfahren beruht darin, die erste Zahl mit den einzelnen Ziffern der zweiten Zahl nacheinander, beginnend bei der letzten Stelle, zu multiplizieren. Für jede neue Ziffer wird eine neue Zeile benötigt. Man schreibt jede Multiplikation untereinander und addiert die einzelnen Werte. Wie bei der Addition ist auch bei der Multiplikation ein Überlauf auf die jeweils nächsthöhere Stelle zu übertragen.

Im Gegensatz zum Standardverfahren der Schulmathematik vereinfachen wir das Verfahren dahingehend, dass wir in den einzelnen Zeilen keinerlei Überlauf berücksichtigen. Dies tun wir erst, wenn wir die Zwischenresultate der einzelnen Zeilen Spalte für Spalte, von rechts beginnend, zusammenzählen. Am Beispiel von 98 * 12345 können Sie den Algorithmus in Abbildung 5 nachverfolgen:

<img src="assets/Schulmathematik_Multiplikation.png" width="280">
Abbildung 5. Standardverfahren für schriftliche Multiplikation.

Wir schließen diese Betrachtungen mit der schriftlichen Division ab. Bezüglich der Namensgebung rekapitulieren wir zunächst einmal, dass ein *Dividend* durch einen *Divisor* geteilt wird, das Ergebnis heißt *Quotient*, der in unserem Fall stets ganzzahlig ist und aus diesem Grund in den meisten Fällen noch um einen Rest zu ergänzen ist. Wir beginnen mit der ersten (führenden) Zahl des Dividenden. Ist diese Zahl nicht größer als der Divisor, nehmen wir die nächste Zahl des Dividenden mit hinzu und wiederholen diesen Vorgang solange, bis die auf diese Weise gebildete Zahl größer ist als der Dividend. Nun teilen wir diese Zahl durch den Divisor, das Ergebnis bildet die erste Ziffer des gesuchten Quotienten. Um die Division fortsetzen zu können, multiplizieren wir das Ergebnis mit dem Divisor, und subtrahieren das Produkt von der alten Zahl. Das so erhaltene Ergebnis wird durch „Herunterziehen“ der nächsten Ziffer von oben ergänzt. Dieses Procedere beginnen wir nun wieder von vorne. Der neue Dividend ist das Ergebnis der letzten Subtraktion, ergänzt um die heruntergezogene Ziffer usw.

Das ganze Verfahren wird solange wiederholt, bis alle Stellen des Dividenden nach unten gezogen wurden. Die unterste Zahl stellt den Rest der Division dar, der gesuchte Quotient wurde Ziffer für Ziffer zusammengesetzt. Möglicherweise ist diese textuelle Beschreibung des Divisionsalgorithmus etwas schwer verdaulich, zur Illustration betrachten wir in Abbildung 6 das folgende Beispiel:

<img src="assets/Schulmathematik_Division.png" width="320">
Abbildung 6. Standardverfahren der schriftlichen Division.

Nach diesen Hilfestellungen fassen wir die soeben besprochenen arithmetischen Operatoren für eine Ergänzung der ``BigInteger``-Klasse in Tabelle 3 zusammen:

| Operator | Schnittstelle und Beschreibung |
|:-------------- |---|
| ``operator+``   | ``BigInteger operator+ (BigInteger number);``<br/> Liefert jeweils ein neues BigInteger-Objekt zurück. Der Wert ergibt sich durch das Resultat der mathematischen Operation ``this`` + ``number``. |
| ``operator-``   | ``BigInteger operator- (BigInteger number);``<br/> Liefert jeweils ein neues BigInteger-Objekt zurück. Der Wert ergibt sich durch das Resultat der mathematischen Operation ``this`` - ``number``. |
| ``operator*``   | ``BigInteger operator* (BigInteger number);``<br/> Liefert jeweils ein neues BigInteger-Objekt zurück. Der Wert ergibt sich durch das Resultat der mathematischen Operation ``this`` * ``number``. |
| ``operator/``   | ``BigInteger operator/ (BigInteger number);``<br/> Liefert jeweils ein neues BigInteger-Objekt zurück. Der Wert ergibt sich durch das Resultat der mathematischen Operation ``this`` / ``number``. |
| ``operator%``   | ``BigInteger operator% (BigInteger number);``<br/> Liefert jeweils ein neues BigInteger-Objekt zurück. Der Wert ergibt sich durch das Resultat der mathematischen Operation ``this`` modulo ``number``. |

Tabelle 3. Arithmetische Operatoren der Klasse ``BigInteger``.

## Vergleichsoperatoren der Klasse `BigInteger`

Große Zahlen kann man vergleichen, etwa auf Gleichheit oder auf kleiner(-gleich) und größer(-gleich). Entsprechende Operatoren hierzu sind in Tabelle 4 festgelegt:

| Operator | Schnittstelle und Beschreibung |
|:-------------- |---|
| ``operator==``<br/> ``operator!=`` | ``@override``<br/>``bool operator ==(Object other);``<br/> Vergleicht den Wert zweier BigInteger-Objekte auf Gleichheit. *Hinweis*: Den !=-Operator kann in Dart nicht überladen werden.
| ``operator<``<br/>``operator<=``<br/>``operator>``<br/> ``operator>=``<br/> | ``bool operator <(Object other);``<br/>``bool operator <(Object other);``<br/>``bool operator <(Object other);``<br/>``bool operator <(Object other);``<br/> Umsetzung der mathematischen Relationen kleiner, kleiner-gleich, größer und größer-gleich auf zwei ``BigInteger``-Objeke mittels der binären Operatoren <, <=, > und >=. |

Tabelle 4. Vergleichsoperatoren Operatoren der Klasse ``BigInteger``.

## Hilfsmethoden der Klasse `BigInteger`

Möglicherweise benötigen Sie zur Implementierung der vorangestellten Abschnitte noch die eine oder andere Hilfsmethode. Bei den arithmetischen Operationen können beispielsweise in manchen Situationen im internen ``List<int>``-Objekt eines ``BigInteger``-Objekts führende Nullen entstehen. Im Extremfall kann man dies bei der Subtraktion einer Zahl mit sich selbst beobachten, also etwa 100 - 100. Das Ergebnis sollte dann nicht 000, sondern 0 lauten. Zur Behebung dieser Unschönheit finden Sie in Tabelle 5 die private Hilfsmethode ``_removeLeadingZeros`` vor.

Zur Ausgabe eines ``BigInteger``-Objekts auf der Konsole ist die ``toString``-Methode geeignet zu überschreiben. Um die Lesbarkeit der Zeichenfolge zu steigern, ist nach jeder dritten Ziffer ein Punkt einzufügen, also zum Beispiel "99.999".

| Methode | Schnittstelle und Beschreibung |
|:-------------- |---|
| ``_removeLeadingZeros``   | ``void _removeLeadingZeros();``<br/> Entfernt führende Nullen im internen ``List<int>``-Objekt eines ``BigInteger``-Objekts. |
| ``toString``   | ``@override``<br/>``String toString();``<br/> Darstellung eines ``BigInteger``-Objekts in einer Zeichenkette. |

Tabelle 5. Weitere Elemente der Klasse ``BigInteger``.

## Einige Beispiele

Damit sind am Ende der Vorstellung der Klasse ``BigInteger`` angekommen. Welchen Nutzen können wir aus ihr ziehen? Wir demonstrieren als Beispiel die Fakultätfunktion aus der Mathematik, die jeder Zahl das Produkt aller natürlichen Zahlen kleiner und gleich dieser Zahl zuordnet. Als Notation wird der natürlichen Zahl ein Ausrufezeichen „!“ nachgestellt, also

*n*! = 1 * 2 * 3 * ... * *n*

Beim Berechnen der Fakultät stellen wir fest, dass diese, selbst für vergleichsweise kleine Argumente, schnell einen sehr großen Wert annimmt. Wir können das an einer Methode ``faculty`` in Dart ausprobieren, die wir auf Basis des Datentyps ``int`` definieren:

```dart
int faculty(int n) {
  if (n == 1)
	return 1;
  else
	return n * faculty(n - 1);
}
```

Mit dieser Methode ``faculty`` machen wir die Beobachtung, dass wir nur für Argumente *n* kleiner-gleich 20 ein korrektes Resultat erhalten:

```dart
Faculty of 1: 1
Faculty of 2: 2
Faculty of 3: 6
Faculty of 4: 24
Faculty of 5: 120
Faculty of 6: 720
Faculty of 7: 5040
Faculty of 8: 40320
Faculty of 9: 362880
Faculty of 10: 3628800
Faculty of 11: 39916800
Faculty of 12: 479001600
Faculty of 13: 6227020800
Faculty of 14: 87178291200
Faculty of 15: 1307674368000
Faculty of 16: 20922789888000
Faculty of 17: 355687428096000
Faculty of 18: 6402373705728000
Faculty of 19: 121645100408832000
Faculty of 20: 2432902008176640000
Faculty of 21: -4249290049419214848
Faculty of 22: -1250660718674968576
Faculty of 23: 8128291617894825984
Faculty of 24: -7835185981329244160
Faculty of 25: 7034535277573963776
Faculty of 26: -1569523520172457984
Faculty of 27: -5483646897237262336
Faculty of 28: -5968160532966932480
Faculty of 29: -7055958792655077376
Faculty of 30: -8764578968847253504
...
```

Ab dem Argument *n* = 21 werden die Resultate falsch, wie sich an dem negativen Vorzeichen leicht erkennen lässt. Für die Berechnung haben wir die rekursive Formel der Fakultätfunktion verwendet (Abbildung 7), was aber für die Falschheit der Ergebnisse nicht der Grund ist:

<img src="assets/Faculty.png" width="220">
Abbildung 7. Rekursive Definition der Fakultätfunktion.

Mit den regulären Sprachmitteln von Dart kommen wir jetzt nicht weiter, der Wertebereich des Datentyps ``int`` lässt einfach keine größeren Zahlen zu. Ersetzen wir in der Methode ``faculty`` den Datentyp ``int`` durch ``BigInteger``, so können wir die Fakultät korrekt für beliebig große Argumente berechnen (Methode ``facultyBig``):

```dart
BigInteger facultyBig(BigInteger n) {
  if (n == BigInteger.One) {
	return BigInteger.One;
  } else {
	return n * facultyBig(n - BigInteger.One);
  }
}
```

Mit folgendem Testrahmen sehen die ersten fünfzig Fakultäten so aus:

```dart
void testFaculty(int limit) {
  BigInteger upperLimit = BigInteger.fromInt(limit);
  for (BigInteger n = BigInteger.One; n < upperLimit; n += BigInteger.One) {
    BigInteger f = facultyBig(n);
    print("Faculty of ${n}: ${f.toStringFormatted()}");
  }
}
```

Ausgabe (für *limit* gleich 31):

```
Faculty of 1: 1
Faculty of 2: 2
Faculty of 3: 6
Faculty of 4: 24
Faculty of 5: 120
Faculty of 6: 720
Faculty of 7: 5.040
Faculty of 8: 40.320
Faculty of 9: 362.880
Faculty of 10: 3.628.800
Faculty of 11: 39.916.800
Faculty of 12: 479.001.600
Faculty of 13: 6.227.020.800
Faculty of 14: 87.178.291.200
Faculty of 15: 1.307.674.368.000
Faculty of 16: 20.922.789.888.000
Faculty of 17: 355.687.428.096.000
Faculty of 18: 6.402.373.705.728.000
Faculty of 19: 121.645.100.408.832.000
Faculty of 20: 2.432.902.008.176.640.000
Faculty of 21: 51.090.942.171.709.440.000
Faculty of 22: 1.124.000.727.777.607.680.000
Faculty of 23: 25.852.016.738.884.976.640.000
Faculty of 24: 620.448.401.733.239.439.360.000
Faculty of 25: 15.511.210.043.330.985.984.000.000
Faculty of 26: 403.291.461.126.605.635.584.000.000
Faculty of 27: 10.888.869.450.418.352.160.768.000.000
Faculty of 28: 304.888.344.611.713.860.501.504.000.000
Faculty of 29: 8.841.761.993.739.701.954.543.616.000.000
Faculty of 30: 265.252.859.812.191.058.636.308.480.000.000
Faculty of 31: 8.222.838.654.177.922.817.725.562.880.000.000
Faculty of 32: 263.130.836.933.693.530.167.218.012.160.000.000
Faculty of 33: 8.683.317.618.811.886.495.518.194.401.280.000.000
Faculty of 34: 295.232.799.039.604.140.847.618.609.643.520.000.000
Faculty of 35: 10.333.147.966.386.144.929.666.651.337.523.200.000.000
Faculty of 36: 371.993.326.789.901.217.467.999.448.150.835.200.000.000
Faculty of 37: 13.763.753.091.226.345.046.315.979.581.580.902.400.000.000
Faculty of 38: 523.022.617.466.601.111.760.007.224.100.074.291.200.000.000
Faculty of 39: 20.397.882.081.197.443.358.640.281.739.902.897.356.800.000.000
Faculty of 40: 815.915.283.247.897.734.345.611.269.596.115.894.272.000.000.000
Faculty of 41: 33.452.526.613.163.807.108.170.062.053.440.751.665.152.000.000.000
Faculty of 42: 1.405.006.117.752.879.898.543.142.606.244.511.569.936.384.000.000.000
Faculty of 43: 60.415.263.063.373.835.637.355.132.068.513.997.507.264.512.000.000.000
Faculty of 44: 2.658.271.574.788.448.768.043.625.811.014.615.890.319.638.528.000.000.000
Faculty of 45: 119.622.220.865.480.194.561.963.161.495.657.715.064.383.733.760.000.000.000
Faculty of 46: 5.502.622.159.812.088.949.850.305.428.800.254.892.961.651.752.960.000.000.000
Faculty of 47: 258.623.241.511.168.180.642.964.355.153.611.979.969.197.632.389.120.000.000.000
Faculty of 48: 12.413.915.592.536.072.670.862.289.047.373.375.038.521.486.354.677.760.000.000.000
Faculty of 49: 608.281.864.034.267.560.872.252.163.321.295.376.887.552.831.379.210.240.000.000.000
```

Die Division sollten wir ebenfalls einem intensiven Test unterziehen. Wir betrachten aus diesem Grund Potenzen der Zahl 2, berechnen diese allerdings nicht beginnend mit der 2, sondern in umgekehrter Richtung. Einen sehr großen Startwert (2.475.880.078.570.760.549.798.248.448) habe ich vorab mit Hilfe der Multiplikations-Methode ausgerechnet:

```dart
void testPowerByTwo() {
  BigInteger huge = BigInteger("2.475.880.078.570.760.549.798.248.448");
  while (huge != BigInteger.One) {
    stdout.write('${huge} / 2 = ');
    huge = huge / BigInteger.Two;
    print('${huge}');
  }
}
```

*Ausgabe*:

```dart
2.475.880.078.570.760.549.798.248.448 / 2 = 1.237.940.039.285.380.274.899.124.224
1.237.940.039.285.380.274.899.124.224 / 2 = 618.970.019.642.690.137.449.562.112
618.970.019.642.690.137.449.562.112 / 2 = 309.485.009.821.345.068.724.781.056
309.485.009.821.345.068.724.781.056 / 2 = 154.742.504.910.672.534.362.390.528
154.742.504.910.672.534.362.390.528 / 2 = 77.371.252.455.336.267.181.195.264
77.371.252.455.336.267.181.195.264 / 2 = 38.685.626.227.668.133.590.597.632
38.685.626.227.668.133.590.597.632 / 2 = 19.342.813.113.834.066.795.298.816
19.342.813.113.834.066.795.298.816 / 2 = 9.671.406.556.917.033.397.649.408
9.671.406.556.917.033.397.649.408 / 2 = 4.835.703.278.458.516.698.824.704
4.835.703.278.458.516.698.824.704 / 2 = 2.417.851.639.229.258.349.412.352
2.417.851.639.229.258.349.412.352 / 2 = 1.208.925.819.614.629.174.706.176
1.208.925.819.614.629.174.706.176 / 2 = 604.462.909.807.314.587.353.088
604.462.909.807.314.587.353.088 / 2 = 302.231.454.903.657.293.676.544
302.231.454.903.657.293.676.544 / 2 = 151.115.727.451.828.646.838.272
151.115.727.451.828.646.838.272 / 2 = 75.557.863.725.914.323.419.136
75.557.863.725.914.323.419.136 / 2 = 37.778.931.862.957.161.709.568
37.778.931.862.957.161.709.568 / 2 = 18.889.465.931.478.580.854.784
18.889.465.931.478.580.854.784 / 2 = 9.444.732.965.739.290.427.392
9.444.732.965.739.290.427.392 / 2 = 4.722.366.482.869.645.213.696
4.722.366.482.869.645.213.696 / 2 = 2.361.183.241.434.822.606.848
2.361.183.241.434.822.606.848 / 2 = 1.180.591.620.717.411.303.424
1.180.591.620.717.411.303.424 / 2 = 590.295.810.358.705.651.712
590.295.810.358.705.651.712 / 2 = 295.147.905.179.352.825.856
295.147.905.179.352.825.856 / 2 = 147.573.952.589.676.412.928
147.573.952.589.676.412.928 / 2 = 73.786.976.294.838.206.464
73.786.976.294.838.206.464 / 2 = 36.893.488.147.419.103.232
36.893.488.147.419.103.232 / 2 = 18.446.744.073.709.551.616
18.446.744.073.709.551.616 / 2 = 9.223.372.036.854.775.808
9.223.372.036.854.775.808 / 2 = 4.611.686.018.427.387.904
4.611.686.018.427.387.904 / 2 = 2.305.843.009.213.693.952
2.305.843.009.213.693.952 / 2 = 1.152.921.504.606.846.976
1.152.921.504.606.846.976 / 2 = 576.460.752.303.423.488
576.460.752.303.423.488 / 2 = 288.230.376.151.711.744
288.230.376.151.711.744 / 2 = 144.115.188.075.855.872
144.115.188.075.855.872 / 2 = 72.057.594.037.927.936
72.057.594.037.927.936 / 2 = 36.028.797.018.963.968
36.028.797.018.963.968 / 2 = 18.014.398.509.481.984
18.014.398.509.481.984 / 2 = 9.007.199.254.740.992
9.007.199.254.740.992 / 2 = 4.503.599.627.370.496
4.503.599.627.370.496 / 2 = 2.251.799.813.685.248
2.251.799.813.685.248 / 2 = 1.125.899.906.842.624
1.125.899.906.842.624 / 2 = 562.949.953.421.312
562.949.953.421.312 / 2 = 281.474.976.710.656
281.474.976.710.656 / 2 = 140.737.488.355.328
140.737.488.355.328 / 2 = 70.368.744.177.664
70.368.744.177.664 / 2 = 35.184.372.088.832
35.184.372.088.832 / 2 = 17.592.186.044.416
17.592.186.044.416 / 2 = 8.796.093.022.208
8.796.093.022.208 / 2 = 4.398.046.511.104
4.398.046.511.104 / 2 = 2.199.023.255.552
2.199.023.255.552 / 2 = 1.099.511.627.776
1.099.511.627.776 / 2 = 549.755.813.888
549.755.813.888 / 2 = 274.877.906.944
274.877.906.944 / 2 = 137.438.953.472
137.438.953.472 / 2 = 68.719.476.736
68.719.476.736 / 2 = 34.359.738.368
34.359.738.368 / 2 = 17.179.869.184
17.179.869.184 / 2 = 8.589.934.592
8.589.934.592 / 2 = 4.294.967.296
4.294.967.296 / 2 = 2.147.483.648
2.147.483.648 / 2 = 1.073.741.824
1.073.741.824 / 2 = 536.870.912
536.870.912 / 2 = 268.435.456
268.435.456 / 2 = 134.217.728
134.217.728 / 2 = 67.108.864
67.108.864 / 2 = 33.554.432
33.554.432 / 2 = 16.777.216
16.777.216 / 2 = 8.388.608
8.388.608 / 2 = 4.194.304
4.194.304 / 2 = 2.097.152
2.097.152 / 2 = 1.048.576
1.048.576 / 2 = 524.288
524.288 / 2 = 262.144
262.144 / 2 = 131.072
131.072 / 2 = 65.536
65.536 / 2 = 32.768
32.768 / 2 = 16.384
16.384 / 2 = 8.192
8.192 / 2 = 4.096
4.096 / 2 = 2.048
2.048 / 2 = 1.024
1.024 / 2 = 512
512 / 2 = 256
256 / 2 = 128
128 / 2 = 64
64 / 2 = 32
32 / 2 = 16
16 / 2 = 8
8 / 2 = 4
4 / 2 = 2
2 / 2 = 1
```

Zum Abschluss betrachten wir noch *Mersenne*-Zahlen. Eine *Mersenne*-Zahl ist eine Zahl der Form 2<sup>*n*</sup> - 1. Die Primzahlen unter den *Mersenne*-Zahlen werden *Mersenne*-Primzahlen genannt. Diese können wiederum, wie Sie sich denken können, sehr groß werden. Im Jahre 1963 gelang es dem Mathematiker Donald B. Gillies nachzuweisen, dass für den Exponenten n = 11213 die resultierende *Mersenne*-Zahl prim ist. Sollte es mir gelungen sein, Ihr Interesse an *Mersenne*-Primzahlen zu wecken, dann dürfen Sie zum Abschluss – mit Hilfe der ``BigInteger``-Klasse – einen Blick auf diese Zahl werfen. In der Liste aller bekannten *Mersenne*-Primzahlen rangiert sie an der 23. Stelle. Eine Funktion zum Berechnen dieser Zahl sieht so aus:

```dart
void testMersenne() {
  BigInteger mersenne = BigInteger.Two;
  mersenne = mersenne.power(11213);
  mersenne = mersenne - BigInteger.One;

  print("Mersenne:");
  print("${mersenne.toStringFormatted()}");
  print("Number of Digits: ${mersenne.Cardinality}");
}
```

*Ausgabe*:

```dart
Mersenne:
  2.814.112.013.697.373.133.393.152.975.842.584.191.818.662.382.013.600.787.892.419.349.345.515.
176.682.276.313.810.715.094.745.633.257.074.198.789.308.535.071.537.342.445.016.418.881.801.789.
390.548.709.414.391.857.257.571.565.758.706.478.418.356.747.070.674.633.497.188.053.050.875.416.
821.624.325.680.555.826.071.110.691.946.607.460.873.056.965.360.830.571.590.242.774.934.226.866.
183.966.309.185.433.462.514.537.484.258.655.982.386.235.046.029.227.507.801.410.907.163.348.439.
547.781.093.397.260.096.909.677.091.843.944.555.754.221.115.477.343.760.206.979.650.067.087.884.
993.478.012.977.277.878.532.807.432.236.554.020.931.571.802.310.429.923.167.588.432.457.036.104.
110.850.960.439.769.038.450.365.514.022.349.625.383.665.751.207.169.661.697.352.732.236.111.926.
846.454.751.701.734.527.011.379.148.175.107.820.821.297.628.946.795.631.098.960.767.492.250.494.
834.254.073.334.414.121.627.833.939.461.539.212.528.932.010.726.136.689.293.688.815.665.491.671.
395.174.710.452.663.709.175.753.603.774.156.855.766.515.313.827.613.727.281.696.692.633.529.666.
363.787.286.539.769.941.609.107.777.183.593.336.002.680.124.517.633.451.490.439.598.324.823.836.
457.251.219.406.391.432.635.639.225.604.556.042.396.004.307.799.361.927.379.900.586.400.420.763.
092.320.813.392.262.492.942.076.312.933.268.033.818.471.555.255.820.639.308.889.948.665.570.202.
403.815.856.313.578.949.779.767.046.261.845.327.956.725.767.289.205.262.311.752.014.786.247.813.
331.834.015.084.475.386.760.526.612.217.340.579.721.237.414.485.803.725.355.463.022.009.536.301.
008.145.867.524.704.604.618.862.039.093.555.206.195.328.240.951.895.107.040.793.284.825.095.462.
530.151.872.823.997.171.764.140.663.315.804.309.008.611.942.578.380.931.064.748.991.594.407.476.
328.437.785.848.825.423.921.170.614.938.294.029.483.257.162.979.299.388.940.695.877.375.448.948.
081.108.345.293.394.327.808.452.729.789.834.135.140.193.912.419.661.799.488.795.210.328.238.112.
742.218.700.634.541.149.743.657.287.232.843.426.369.348.804.878.993.471.962.403.393.967.857.676.
150.371.600.196.650.252.168.250.117.793.178.488.012.000.505.422.821.362.550.520.509.209.724.459.
895.852.366.827.477.851.619.190.503.254.853.115.029.403.132.178.989.005.195.751.194.301.340.277.
282.730.390.683.651.120.587.895.060.198.753.121.882.187.788.657.024.007.291.784.186.518.589.977.
788.510.306.743.945.896.108.645.258.766.415.692.825.664.174.470.616.153.305.144.852.273.884.549.
635.059.255.410.606.458.427.323.864.109.506.687.636.314.447.514.269.094.932.953.219.924.212.594.
695.157.655.009.158.521.173.420.923.275.882.063.327.625.408.617.963.032.962.033.572.563.553.604.
056.097.832.111.547.535.908.988.433.816.919.747.615.817.161.606.620.557.307.000.377.194.730.013.
431.815.560.750.159.027.842.164.901.422.544.571.224.546.936.793.234.970.894.954.668.425.436.412.
347.785.376.194.310.030.139.080.568.383.420.772.628.618.722.646.109.707.506.566.928.102.800.033.
961.704.343.991.962.002.059.794.565.527.774.913.883.237.756.792.720.065.543.768.640.792.177.441.
559.278.272.350.823.092.843.683.534.396.679.150.229.676.101.834.243.787.820.420.087.274.028.617.
212.684.576.388.733.605.769.491.224.109.866.592.577.360.666.241.467.280.158.988.605.523.486.345.
880.882.227.855.505.706.309.276.349.415.034.547.677.180.618.296.352.866.263.005.509.222.254.318.
459.768.194.126.727.603.047.460.344.175.581.029.298.320.171.226.355.234.439.676.816.309.919.127.
574.206.334.807.719.021.875.413.891.580.871.529.049.187.829.308.412.133.400.910.419.756.313.021.
540.478.436.604.178.446.757.738.998.632.083.586.207.992.234.085.162.634.375.406.771.169.707.323.
213.988.284.943.779.122.171.985.953.605.897.902.291.781.768.286.548.287.878.180.415.060.635.460.
047.164.104.095.483.777.201.737.468.873.324.068.550.430.695.826.210.304.316.336.385.311.384.093.
490.021.332.372.463.463.373.977.427.405.896.673.827.544.203.128.574.874.581.960.335.232.005.637.
229.319.592.369.288.171.375.276.702.260.450.911.735.069.504.025.016.667.755.214.932.073.643.654.
199.488.477.010.363.909.372.005.757.899.989.580.775.775.126.621.113.057.905.717.449.417.222.016.
070.530.243.916.116.705.990.451.304.256.206.318.289.297.738.303.095.152.430.549.772.239.514.964.
821.601.838.628.861.446.301.936.017.710.546.777.503.109.263.030.994.747.397.618.576.207.373.447.
725.441.427.135.362.428.360.863.669.327.157.635.983.045.447.971.816.718.801.639.869.547.525.146.
305.655.571.843.717.916.875.669.140.320.724.978.568.586.718.527.586.602.439.602.335.283.513.944.
980.064.327.030.278.104.224.144.971.883.680.541.689.784.796.267.391.476.087.696.392.191
Number of Digits: 3376
```