// Copyright 2016 Google Inc. Use of this source code is governed by an
// MIT-style license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import '../exception.dart';
import '../visitor/interface/value.dart';
import '../value.dart';

// TODO(nweiz): track original representation.
// TODO(nweiz): support an alpha channel.
class SassColor extends Value {
  final int red;
  final int green;
  final int blue;
  final double alpha;

  SassColor.rgb(this.red, this.green, this.blue, [double alpha])
      : alpha = alpha ?? 1.0;

  /*=T*/ accept/*<T>*/(ValueVisitor/*<T>*/ visitor) => visitor.visitColor(this);

  SassColor assertColor([String name]) => this;

  SassColor change({int red, int green, int blue, double alpha}) =>
      new SassColor.rgb(red ?? this.red, green ?? this.green, blue ?? this.blue,
          alpha ?? this.alpha);

  Value plus(Value other) {
    if (other is! SassNumber && other is! SassColor) return super.plus(other);
    throw new InternalException('Undefined operation "$this + $other".');
  }

  Value minus(Value other) {
    if (other is! SassNumber && other is! SassColor) return super.minus(other);
    throw new InternalException('Undefined operation "$this - $other".');
  }

  Value dividedBy(Value other) {
    if (other is! SassNumber && other is! SassColor) {
      return super.dividedBy(other);
    }
    throw new InternalException('Undefined operation "$this / $other".');
  }

  Value modulo(Value other) =>
      throw new InternalException('Undefined operation "$this % $other".');

  bool operator ==(other) =>
      other is SassColor &&
      other.red == red &&
      other.green == green &&
      other.blue == blue;

  int get hashCode => red.hashCode ^ green.hashCode ^ blue.hashCode;
}
