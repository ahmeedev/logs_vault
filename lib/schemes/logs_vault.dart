import 'package:isar/isar.dart';

part 'logs_vault.g.dart';

@collection
@Name("logs_vault")
class LogsVault {
  String? id;

  Id get isarId => fastHash(id!);
  final logs = IsarLinks<Log>();
}

@collection
@Name("logs")
class Log {
  Id? id = Isar.autoIncrement;

  String? message;
  String? level;
  DateTime? dateTime;
}

/// FNV-1a 64bit hash algorithm optimized for Dart Strings
int fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}
