import 'dart:async';
import 'dart:math';

import 'package:flutter_helper_utils/src/exceptions/exceptions.dart';
import 'package:flutter_helper_utils/src/src.dart';

extension NullSafeNumExtensions on num? {
  int? get tryToInt => this?.toInt();

  double? get tryToDouble => this?.toDouble();

  num percentage(num total) {
    if (this != null) {
      return this! >= total ? 100 : max((this! / total) * 100, 0).floor();
    }
    return 0;
  }
}

extension NumExtensions on num {
  /// Returns if the number is positive
  bool get isPositive => this > 0;

  /// Returns if the number is negative
  bool get isNegative => this < 0;

  /// Convert this integer into boolean.
  ///
  /// Returns `true` if this integer is greater than *0*.
  bool get asBool => this > 0;

  /// Returns number of digits in this number
  int get numberOfDigits => toString().length;

  String get removeTrailingZero =>
      toString().replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '');

  double get roundToFiftyOrHundred =>
      this + (50 - ((this % 50) > 0 ? this % 50 : 50));

  double get roundToTenth => (this / 10).ceil() * 10;

  /// Returns tenth of the number
  double get tenth => this / 10;

  /// Returns fourth of the number
  double get fourth => this / 4;

  /// Returns third of the number
  double get third => this / 3;

  /// Returns half of the number
  double get half => this / 2;

  /// convert numbers to greeks
  /// e.g 1000 => 1k
  ///     20000 => 20k
  ///     1000000 => 1M
  String get asGreeks {
    if (this < 1000) {
      return removeTrailingZero;
    } else if (this < 1000000) {
      return '${(this / 1000).removeTrailingZero}K';
    }
    return '${(this / 1000000).removeTrailingZero}M';
  }

  /// Utility to delay some callback (or code execution).
  // TODO(Omar): Add a separated implementation of delay() with the ability
  /// to stop it.
  ///
  /// Sample:
  /// ```
  /// void main() async {
  ///   print('+ wait for 2 seconds');
  ///   await 2.delay();
  ///   print('- 2 seconds completed');
  ///   print('+ callback in 1.2sec');
  ///   1.delay(() => print('- 1.2sec callback called'));
  ///   print('currently running callback 1.2sec');
  /// }
  ///```
  Future<void> delay([FutureOr<dynamic> Function()? callback]) async =>
      Future.delayed(
        Duration(milliseconds: (this * 1000).round()),
        callback,
      );

  Future<void> get daysDelay => Future.delayed(asDays);

  Future<void> get hoursDelay => Future.delayed(asHours);

  Future<void> get minDelay => Future.delayed(asMinutes);

  Future<void> get secDelay => Future.delayed(asSeconds);

  Future<void> get millisecondsDelay => Future.delayed(asMilliseconds);

  /// Easy way to make Durations from numbers.
  ///
  /// Sample:
  /// ```
  /// print(1.seconds + 200.asMilliseconds);
  /// print(1.hours + 30.asMinutes);
  /// print(1.5.asHours);
  ///```
  Duration get asMilliseconds => Duration(microseconds: (this * 1000).round());

  Duration get asSeconds => Duration(milliseconds: (this * 1000).round());

  Duration get asMinutes =>
      Duration(seconds: (this * Duration.secondsPerMinute).round());

  Duration get asHours =>
      Duration(minutes: (this * Duration.minutesPerHour).round());

  Duration get asDays => Duration(hours: (this * Duration.hoursPerDay).round());

  /// Returns a sequence of integer, starting from [this],
  /// increments by [step] and ends at [end]
  Iterable<num> until(int end, {int step = 1}) sync* {
    if (step == 0) {
      // ignore: only_throw_errors
      throw RException.steps();
    }

    var currentNumber = this;

    if (step > 0) {
      while (currentNumber < end) {
        yield currentNumber;
        currentNumber += step;
      }
    } else {
      while (currentNumber > end) {
        yield currentNumber;
        currentNumber += step;
      }
    }
  }
}

extension IntExtensions on int {
  /// Return the min if this number is smaller then minimum
  /// Return the max if this number is bigger the the maximum
  /// Return this number if it's between the range
  int inRangeOf(int min, int max) {
    if (min.isNull || max.isNull) throw Exception('min or max cannot be null');
    if (min > max) throw ArgumentError('min must be smaller the max');

    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  /// Returns the absolute value
  int get absolute => abs();

  /// Return this number time two
  int get doubled => this * 2;

  /// Return this number time three
  int get tripled => this * 3;

  /// Return this number time four
  int get quadrupled => this * 4;

  /// Return squared number
  int get squared => this * this;
}

extension DoubleExtensions on double {
  /// Return the min if this number is smaller then minimum
  /// Return the max if this number is bigger the the maximum
  /// Return this number if it's between the range
  double inRangeOf(double min, double max) {
    if (min.isNull || max.isNull) throw Exception('min or max cannot be null');
    if (min > max) throw ArgumentError('min must be smaller the max');

    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  /// Returns the absolute value
  double get absolute => abs();

  /// Return this number time two
  double get doubled => this * 2;

  /// Return this number time three
  double get tripled => this * 3;

  /// Return this number time four
  double get quadrupled => this * 4;

  /// Return squared number
  double get squared => this * this;
}
