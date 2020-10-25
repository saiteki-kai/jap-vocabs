import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast/utils/sembast_import_export.dart';

class AppDatabase {
  static final AppDatabase _singleton = AppDatabase._();
  static AppDatabase get instance => _singleton;

  Completer<Database> _dbOpenCompleter;
  AppDatabase._();

  static Future<String> get dbPath async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    return join(appDocumentDir.path, 'words.db');
  }

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      await _openDatabase();
    }
    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    final database = await databaseFactoryIo.openDatabase(await dbPath);
    _dbOpenCompleter.complete(database);
  }

  static Future exportDB(File file) async {
    final map = await exportDatabase(await instance.database);
    map['creation_date'] = DateTime.now().millisecondsSinceEpoch;
    final json = jsonEncode(map);
    file.writeAsStringSync(json);
  }

  static Future importDB(File file, callback) async {
    final json = file.readAsStringSync();
    final map = jsonDecode(json);

    final import = await callback(map);

    map.remove('creation_date');

    if (import) {
      await importDatabase(map, databaseFactoryIo, await dbPath);
      instance._dbOpenCompleter = null;
    }
  }
}
