import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:logs_vault/src/my_logger.dart';

late final Logger logVault;

initLogVault({
  required Isar isarObj,
  bool useDB = false,
}) {
  MyLogger obj = MyLogger(isarObj: isarObj, useDB: useDB);
  logVault = obj.log;
}
