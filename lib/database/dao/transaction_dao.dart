import 'package:pocketwallet/database/app_database.dart';
import 'package:pocketwallet/database/dao/dao.dart';
import 'package:pocketwallet/models/expense.dart';
import 'package:pocketwallet/models/expense_type.dart';
import 'package:pocketwallet/models/income.dart';
import 'package:pocketwallet/models/transaction.dart';
import 'package:sqflite/sqflite.dart';

class PocketWalletTransactionDao extends Dao<PocketWalletTransaction> {
  static const String _tableName = 'transactions';
  static const String _id = 'id';
  static const String _expenseType = 'expenseType';
  static const String _source = 'source';
  static const String _value = 'value';
  static const String _month = 'month';
  static const String _year = 'year';
  static const String _transactionType = 'transactionType';

  static const int transactionExpenseType = 1;
  static const int transactionIncomeType = 2;

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_expenseType INTEGER, '
      '$_source TEXT,'
      '$_transactionType INTEGER,'
      '$_month INTEGER,'
      '$_year INTEGER,'
      '$_value REAL)';

  @override
  Map<String, dynamic> toMap(PocketWalletTransaction transaction) {
    final Map<String, dynamic> transactionMap = Map();
    if (transaction is Income) {
      transactionMap[_transactionType] = transactionIncomeType;
      transactionMap[_source] = transaction.source;
    } else if (transaction is Expense) {
      transactionMap[_transactionType] = transactionExpenseType;
      transactionMap[_expenseType] = transaction.expenseType.code;
    }
    transactionMap[_value] = transaction.value;
    transactionMap[_month] = transaction.month;
    transactionMap[_year] = transaction.year;
    return transactionMap;
  }

  @override
  List<PocketWalletTransaction> toList(List<Map<String, dynamic>> result) {
    final List<PocketWalletTransaction> transactions = List();
    for (Map<String, dynamic> row in result) {
      int transactionType = row[_transactionType];
      double value = row[_value];
      int month = row[_month];
      int year = row[_year];

      if (transactionType == transactionIncomeType) {
        transactions.add(
          Income(
            source: row[_source],
            value: value,
            month: month,
            year: year,
          ),
        );
      } else if (transactionType == transactionExpenseType) {
        transactions.add(
          Expense(
            expenseType: getExpenseType(row[_expenseType]),
            value: value,
            month: month,
            year: year,
          )
        );
      }
    }
    return transactions;
  }

  @override
  Future<List<PocketWalletTransaction>> findAll() async {
    final Database database = await createDatabase();
    final List<Map<String, dynamic>> result = await database.query(_tableName);
    return toList(result);
  }

  @override
  Future<int> save(PocketWalletTransaction model) async {
    final Database database = await createDatabase();
    return database.insert(_tableName, toMap(model));
  }
}
