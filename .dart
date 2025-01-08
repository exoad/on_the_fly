// refer: https://github.com/flutter/packages/blob/main/packages/pigeon/example/README.md

@ConfigurePigeon(PigeonOptions(
  dartOut: "lib/base/messages.g.dart",
  dartOptions: DartOptions(),
  cppOptions: CppOptions(namespace: "exoad_onthefly"),
  cppHeaderOut: "windows/runner/messages.g.h",
  cppSourceOut: "windows/runner/messages.g.cpp",
  copyrightHeader: "static/LICENSE_HEADER.txt",
  dartPackageName: "on_the_fly"
))
void main() {

}