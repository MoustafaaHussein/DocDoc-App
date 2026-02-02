import 'package:flutter_test/flutter_test.dart';

import 'counter.dart';

void main() {
  test("Counter should increment", () {
    Counter counter = Counter();
    counter.increment();
    expect(counter.count, 1);
  });
}
