import 'dart:async';
import 'package:flutter/foundation.dart';

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}

// How to use:
// Step 1: Create a debouncer:
// final _debouncer = Debouncer(milliseconds: 500);

// Step 2: Use it:
// onTextChange(String text) {
//   _debouncer.run(() => print(text));
// }