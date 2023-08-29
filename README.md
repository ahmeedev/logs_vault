# Logs Vault

>Logs Vault is a Flutter package that simplifies logging and storage of application logs into a database. It provides an efficient and customizable solution for managing logs while ensuring data integrity and security.

## Features

- 💙 **Made for Flutter**. Easy to use, no config, no boilerplate
- 🚀 **Highly scalable** The sky is the limit (pun intended)
- 🦄 **Open source**. Everything is open source and free forever!

## How to Use

In your main() function, initialize the Isar database. You need to pass the relevant schemas (LogSchema and LogsVaultSchema) to the Isar.open function. You can also specify the directory where the database files will be stored.

~~~dart
late final Isar isar;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    [
      LogSchema,
      LogsVaultSchema,
    ],
    directory: dir.path,
  );
}
~~~

After initializing the Isar database, you should call the initLogVault function from the "logs_vault" library. This function initializes the logging system using the provided Isar instance and enables database storage for logs

~~~dart
Future<void> main() async {
  // ...
  initLogVault(isarObj: isar, useDB: true);
  runApp(const MyApp());
}
~~~

That's it! You've successfully integrated the "logs_vault" library into your Flutter application. Your app is now ready to log messages and store them in the Isar database using the features provided by the library.

You can store and show logs by using the following method:

~~~dart

logVault.info("Hello World!");
logVault.fine("Hello World!");
logVault.shout("Hello World!");
logVault.warning("Hello World!");
.
.
.

~~~

You can export logs by using the following method:

~~~dart

exportLogVault(isarObj: isar,fileLocation:"yourLocation\vault.txt");

~~~

Here is the exported log file
<img src="https://raw.githubusercontent.com/ahmeedev/logs_vault/main/image.png">

## Thank You For Reading this far :)
