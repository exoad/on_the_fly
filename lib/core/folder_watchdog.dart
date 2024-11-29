import 'dart:collection';

final class FolderRegistry {
  final LinkedHashMap<
      String,
      DoubleLinkedQueue<
          ({
            bool Function() canRun,
            void Function() payload
          })>> listeners = LinkedHashMap<String,
      DoubleLinkedQueue<({bool Function() canRun, void Function() payload})>>();

  FolderRegistry._();

  static final FolderRegistry i = FolderRegistry._();

  void register(String path,{required bool Function() canRun, required void Function() payload}) {
    
  }
}
