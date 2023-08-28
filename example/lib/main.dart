import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:logs_vault/logs_vault.dart';
import 'package:logs_vault/schemes/logs_vault.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  // Add these following two schemas in isar [LogSchema, LogsVaultSchema,]
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [
      LogSchema,
      LogsVaultSchema,
    ],
    directory: dir.path,
  );

  initLogVault(isarObj: isar, useDB: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logs Vault Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Log Vault Example'),
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                logVault.info("Hello World!");
              },
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Hello World'),
              )),
        ),
      ),
    );
  }
}
