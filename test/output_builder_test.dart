import 'package:flutter_test/flutter_test.dart';
import 'package:on_the_fly/core/output_builder.dart';
import 'package:on_the_fly/shared/app.dart';

import 'test_helpers.dart';

void main() {
  initConsts();
  group("OutputBuilder Tests", () {
    test("1", () => print(OutputPathBuilder.defaultInstance.process(r"{{$time}}")));
    test(
        "Proper separation and formatting 1",
        () => expect(
            OutputPathBuilder.defaultInstance
                .process(r"{{$time}}.{{$time}}")
                .split(".")
                .length,
            2));
    test(
        "Random String partitioning",
        () => expect(
            OutputPathBuilder.defaultInstance.process(r"{{$random_string 3}}").length,
            3));
    test(
        "Random String partitioning",
        () => expect(
            OutputPathBuilder.defaultInstance
                .process(r"{{$random_string 3400}} hello world{{$random_string 238}}")
                .length,
            " hello world".length + 3400 + 238)); // im too lazy to calculate by hand
    test("Failed Custom Data Blocks", () {
      expect(
          atLeastReturnSomething(() =>
              OutputPathBuilder.defaultInstance.putObj("test_message", "TEST_MESSAGE")),
          throwsA("Unused template key test_message, which is not present in Mapper!"));
    });
    test("Force Custom Data Blocks", () {
      OutputPathBuilder.defaultInstance.forcePutObj("test_message", "TEST_MESSAGE");
      expect(OutputPathBuilder.defaultInstance.process("Hello {{test_message}}"),
          "Hello TEST_MESSAGE");
      OutputPathBuilder.defaultInstance.clean();
    });
    test("Check all foreigns cleared", () {
      expect(OutputPathBuilder.defaultInstance.containsForeignObjs(), false);
    });
    test("Random Number", () {
      expect(
          int.tryParse(OutputPathBuilder.defaultInstance.process(r"{{$random_num 30}}")),
          isNot(null));
    });
  });
}
