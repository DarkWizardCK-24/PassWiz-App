import 'dart:math' as math;

import 'package:flutter/material.dart';

class PasswordEntropy {
  // Precomputed log(2) for efficiency
  static const double _log2 = 0.6931471805599453; // math.log(2)

  // Time conversion constants (seconds)
  static const double _secondsInMinute = 60.0;
  static const double _secondsInHour = 3600.0; // 60 * 60
  static const double _secondsInDay = 86400.0; // 60 * 60 * 24
  static const double _secondsInWeek = 604800.0; // 60 * 60 * 24 * 7
  static const double _secondsInYear = 31536000.0; // 60 * 60 * 24 * 365
  static const double _secondsInDecade = 315360000.0; // 60 * 60 * 24 * 365 * 10
  static const double _secondsInCentury = 3153600000.0; // 60 * 60 * 24 * 365 * 100

  static double calculateEntropy(String password) {
    if (password.isEmpty) return 0.0;

    // Character type flags and pool size
    int poolSize = 0;
    bool hasLower = false, hasUpper = false, hasDigit = false, hasSpecial = false, hasExtended = false;

    // Frequency map for repetition adjustment
    final charFrequency = <int, int>{};

    // Single-pass character analysis using character codes
    for (int code in password.runes) {
      charFrequency[code] = (charFrequency[code] ?? 0) + 1;
      if (code >= 97 && code <= 122) { // a-z
        hasLower = true;
      } else if (code >= 65 && code <= 90) { // A-Z
        hasUpper = true;
      } else if (code >= 48 && code <= 57) { // 0-9
        hasDigit = true;
      } else if ('!@#\$%^&*(),.?":{}|<>[]-_=`~;'.contains(String.fromCharCode(code))) {
        hasSpecial = true;
      } else if ('£€¥©®™'.contains(String.fromCharCode(code))) {
        hasExtended = true;
      }
    }

    // Calculate pool size
    if (hasLower) poolSize += 26;
    if (hasUpper) poolSize += 26;
    if (hasDigit) poolSize += 10;
    if (hasSpecial) poolSize += 32;
    if (hasExtended) poolSize += 6;

    // Adjust for repetition
    double repetitionFactor = charFrequency.length / password.length;
    if (repetitionFactor < 1.0) {
      poolSize = (poolSize * repetitionFactor).round();
    }

    // Entropy = length * log2(poolSize)
    return poolSize > 0 ? password.length * (math.log(poolSize) / _log2) : 0.0;
  }

  static Map<String, dynamic> getStrengthInfo(double entropy) {
    // Calculate crack time in seconds (10 billion guesses/s)
    const double guessesPerSecond = 1e10;
    double seconds = math.pow(2, entropy) / guessesPerSecond;

    // Format crack time
    String crackTime;
    bool isApproximate = false;

    if (seconds < _secondsInMinute) {
      crackTime = '${seconds.toStringAsFixed(2)} seconds';
    } else if (seconds < _secondsInHour) {
      crackTime = '${(seconds / _secondsInMinute).toStringAsFixed(2)} mins';
    } else if (seconds < _secondsInDay) {
      crackTime = '${(seconds / _secondsInHour).toStringAsFixed(2)} hours';
    } else if (seconds < _secondsInWeek) {
      crackTime = '${(seconds / _secondsInDay).toStringAsFixed(2)} days';
    } else if (seconds < _secondsInYear) {
      crackTime = '${(seconds / _secondsInWeek).toStringAsFixed(2)} weeks';
    } else if (seconds < _secondsInDecade) {
      crackTime = 'approx ${(seconds / _secondsInYear).toStringAsFixed(2)} years';
      isApproximate = true;
    } else if (seconds < _secondsInCentury) {
      crackTime = 'approx ${(seconds / _secondsInDecade).toStringAsFixed(2)} decades';
      isApproximate = true;
    } else {
      crackTime = 'approx ${(seconds / _secondsInCentury).toStringAsFixed(2)} centuries';
      isApproximate = true;
    }

    // Strength classification based on entropy table
    if (entropy < 28) {
      return {
        'strength': 'Very Weak',
        'crackTime': crackTime,
        'isApproximate': isApproximate,
        'color': Colors.red,
      };
    } else if (entropy < 36) {
      return {
        'strength': 'Weak',
        'crackTime': crackTime,
        'isApproximate': isApproximate,
        'color': Colors.orange,
      };
    } else if (entropy < 60) {
      return {
        'strength': 'Reasonable',
        'crackTime': crackTime,
        'isApproximate': isApproximate,
        'color': Colors.yellow,
      };
    } else if (entropy < 80) {
      return {
        'strength': 'Strong',
        'crackTime': crackTime,
        'isApproximate': isApproximate,
        'color': Colors.green,
      };
    } else if (entropy < 100) {
      return {
        'strength': 'Very Strong',
        'crackTime': crackTime,
        'isApproximate': isApproximate,
        'color': Colors.blue,
      };
    } else {
      return {
        'strength': 'Extremely Strong',
        'crackTime': crackTime,
        'isApproximate': isApproximate,
        'color': Colors.teal,
      };
    }
  }

  static Map<String, bool> checkConditions(String password) {
    return {
      'lowercase': RegExp(r'[a-z]').hasMatch(password),
      'uppercase': RegExp(r'[A-Z]').hasMatch(password),
      'digit': RegExp(r'[0-9]').hasMatch(password),
      'special': RegExp(r'[!@#$%^&*(),.?":{}|<>[\]\-_=`~;]').hasMatch(password),
      'extended': RegExp(r'[£€¥©®™]').hasMatch(password),
    };
  }
}