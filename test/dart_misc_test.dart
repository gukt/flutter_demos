import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('', () {
    var numbers = [1, 2, 3];
    for (final item in numbers) {
      debugPrint('$item');
    }
  });
}
