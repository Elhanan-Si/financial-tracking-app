import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

/// Opens encrypted native database using SQLite/SQLCipher and the secure key
QueryExecutor openEncryptedConnection({
  required String encryptionKey,
  String dbName = 'financial_tracking.db',
  bool inMemory = false,
}) {
  if (inMemory) {
    return NativeDatabase.memory(
      setup: (rawDb) {
        if (encryptionKey.isNotEmpty) {
          rawDb.execute("PRAGMA key = '$encryptionKey';");
        }
      },
    );
  }

  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, dbName));

    // Ensure sqlite3 is properly initialized on Android
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    return NativeDatabase(
      file,
      setup: (rawDb) {
        if (encryptionKey.isNotEmpty) {
          rawDb.execute("PRAGMA key = '$encryptionKey';");
        }
      },
    );
  });
}
