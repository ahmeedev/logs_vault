import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:logging/logging.dart' as logging;

import '../schemes/logs_vault.dart';

/// A class to provide logging support for your application. set [useDB] to true if you want to store logs in local storage.

var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 1,
      errorMethodCount: 0,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: false),
);

var loggerWithError = Logger(
  printer: PrettyPrinter(
      methodCount: 12,
      errorMethodCount: 20,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: false),
);

class MyLogger {
  final log = logging.Logger('logs_vault');
  late final Isar isar;

  MyLogger({
    required Isar isarObj,
    bool useDB = false,
  }) {
    logging.Logger.root.level = logging.Level.ALL;
    if (useDB) {
      _registeredWithDB();
    } else {
      _registeredWithoutDB();
    }
    isar = isarObj;
  }

  void _registeredWithoutDB() {
    logging.Logger.root.onRecord.listen((record) async {
      _setLogger(record);
    });
  }

  _registeredWithDB() {
    logging.Logger.root.onRecord.listen((record) async {
      _setLogger(record);

      final log = Log();
      log.message = record.message;
      log.level = record.level.toString();
      log.dateTime = record.time;

      final logCollection = LogsVault();
      logCollection.id = _getCurrentDate();
      logCollection.logs.add(log);

      await isar.writeTxn(() async {
        await isar.logs.put(log);
        await isar.logsVaults.put(logCollection);
        await logCollection.logs.save();
      });
    });
  }

  _setLogger(logging.LogRecord record) {
    if (record.level == logging.Level.SHOUT) {
      loggerWithError.e(
        record.message,
        error: record.error,
        stackTrace: record.stackTrace,
        time: DateTime.now(),
      );
    } else if (record.level == logging.Level.WARNING) {
      logger.w(
        record.message,
      );
    } else if (record.level == logging.Level.INFO) {
      logger.i(
        record.message,
      );
    } else {
      logger.t(
        record.message,
      );
    }
  }

  String _getCurrentDate() {
    final date = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
