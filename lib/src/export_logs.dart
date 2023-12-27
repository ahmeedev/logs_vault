import 'dart:io';

import 'package:isar/isar.dart';
import 'package:logs_vault/schemes/logs_vault.dart';

import 'helpers.dart';

exportLogVault({required Isar isarObj, required String fileLocation}) async {
  List<LogsVault> listOflogsVault =
      await isarObj.collection<LogsVault>().where().findAll();

  late RandomAccessFile file;
  try {
    file = await File(fileLocation).open(mode: FileMode.write);
  } catch (e) {
    // Create and open file, if the file not exist on fileLocation
    await File(fileLocation).create();
    file = await File(fileLocation).open(mode: FileMode.write);
  }

  await file.writeString(
      "${getCurrentDayAndTime(DateTime.now())}  : *************** LogsVault Exported on ${getCurrentDate()} ***************\n\n");

  for (var element in listOflogsVault) {
    await file.writeString(
        "================================================================================================\n");
    await file.writeString("				            Vault ${element.id}\n");

    await file.writeString(
        "================================================================================================\n");

    List<Log> listOfLogs = element.logs.toList();

    for (var element in listOfLogs) {
      await file.writeString(
          "${getCurrentDayAndTime(element.dateTime!)} [${element.level}] : ${element.message}\n");
    }
  }
  await file.close();
}

Stream<String> logVaultStream({
  required Isar isarObj,
}) async* {
  List<LogsVault> listOflogsVault =
      await isarObj.collection<LogsVault>().where().findAll();

  yield "${getCurrentDayAndTime(DateTime.now())}  : *************** LogsVault Exported on ${getCurrentDate()} ***************\n\n";

  for (var element in listOflogsVault) {
    yield "================================================================================================\n";
    yield "				            Vault ${element.id}\n";

    yield "================================================================================================\n";

    List<Log> listOfLogs = element.logs.toList();

    for (var element in listOfLogs) {
      yield "${getCurrentDayAndTime(element.dateTime!)} [${element.level}] : ${element.message}\n";
    }
  }

  yield "End of file";
}
