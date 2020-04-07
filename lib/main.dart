import 'package:flutter/material.dart';
import 'package:pocketwallet/database/dao/transaction_dao.dart';
import 'models/expense.dart';
import 'models/expense_type.dart';
import 'models/income.dart';
import 'presentation/home/home_page.dart';
import 'presentation/strings.dart';

void main() => runApp(WalletPocketApp());

class WalletPocketApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    PocketWalletTransactionDao transactionDao = PocketWalletTransactionDao();
    transactionDao.findAll().then((value) => {
          if (value.length == 0)
            {
              transactionDao
                  .save(
                    Expense(
                      expenseType: ExpenseType.GYM,
                      value: 240.0,
                      month: 2,
                      year: 20,
                    ),
                  )
                  .then((onValue) => {
                        transactionDao.save(
                          Expense(
                            expenseType: ExpenseType.TRANSPORT,
                            value: 120.0,
                            month: 2,
                            year: 20,
                          ),
                        )
                      })
                  .then((onValue) {
                transactionDao
                    .save(
                      Income(
                        source: 'aisdjij',
                        value: 120.0,
                        month: 1,
                        year: 20,
                      ),
                    )
                    .then((onValue) => {
                          transactionDao.save(
                            Income(
                              source: 'aisdjij',
                              value: 120.0,
                              month: 1,
                              year: 20,
                            ),
                          )
                        });
              })
            }
        });
    return MaterialApp(
      title: APP_NAME,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
