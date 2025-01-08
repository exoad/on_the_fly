@ConfigurePigeon(PigeonOptions(
  dartOut: "lib/base/messages.g.dart",
  dartOptions: DartOptions(),
  cppOptions: CppOptions(namespace: "exoad_onthefly"),
  cppHeaderOut: "windows/runner/messages.g.h",
  cppSourceOut: "windows/runner/messages.g.cpp",
  dartPackageName: "on_the_fly"
))
void main() {
  
}