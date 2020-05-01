import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dao/transaction_dao.dart';

final dataBaseVersion = 1;
final dataBaseName = 'pocketwallet.db';

Future<Database> createDatabase() async {
  final String path = join(await getDatabasesPath(), dataBaseName);
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(PocketWalletTransactionDao.tableSql);
    },
    version: dataBaseVersion,
    onDowngrade: onDatabaseDowngradeDelete,
  );
}
