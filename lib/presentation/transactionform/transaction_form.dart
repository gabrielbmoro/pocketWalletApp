import 'package:flutter/material.dart';
import 'package:pocketwallet/database/dao/transaction_dao.dart';
import 'package:pocketwallet/models/expense.dart';
import 'package:pocketwallet/models/income.dart';
import 'package:pocketwallet/models/transaction.dart';
import 'package:pocketwallet/presentation/transactionform/expense_options.dart';
import 'package:pocketwallet/util/currency.dart';
import 'package:pocketwallet/util/date.dart';
import '../strings.dart';

class NewTransaction extends StatefulWidget {
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  TextEditingController _valueController = TextEditingController();
  TextEditingController _sourceController = TextEditingController();
  TransactionType _type = TransactionType.INCOME;
  final _expenseOptionsStateKey = new GlobalKey<ExpenseOptionsState>();
  PocketWalletTransactionDao _transactionDao = PocketWalletTransactionDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TRANSACAO),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(
                  signed: false,
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: VALUE,
                ),
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: const Text(INCOME),
                      leading: Radio(
                        value: TransactionType.INCOME,
                        groupValue: _type,
                        onChanged: (TransactionType value) {
                          setState(() {
                            _type = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text(EXPENSE),
                      leading: Radio(
                        value: TransactionType.EXPENSE,
                        groupValue: _type,
                        onChanged: (TransactionType value) {
                          setState(() {
                            _type = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              _buildPanelAccordingToTransactionType(),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                  onPressed: () => {submitForm()},
                  child: Text(SAVE),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submitForm() {
    double value = convertTextToValue(_valueController.value.text);
    int month = currentMonth();
    int year = currentYear();

    PocketWalletTransaction _transaction;

    if (value != null) {
      if (_type == TransactionType.INCOME) {
        _transaction = Income(
          source: _sourceController.value.text,
          value: value,
          month: month,
          year: year,
        );
      } else if (_type == TransactionType.EXPENSE) {
        _transaction = Expense(
          expenseType: _expenseOptionsStateKey.currentState.expenseType,
          value: value,
          month: month,
          year: year,
        );
      }

      if (_transaction != null) {
        _transactionDao
            .save(_transaction)
            .then((result) => {Navigator.pop(context, result)});
      }
    }
  }

  Widget _buildPanelAccordingToTransactionType() {
    switch (_type) {
      case TransactionType.EXPENSE:
        return ExpenseOptions(
          key: _expenseOptionsStateKey,
        );
      case TransactionType.INCOME:
        return TextField(
          controller: _sourceController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: SOURCE,
          ),
          style: TextStyle(
            fontSize: 24,
          ),
        );
    }
    return Text('');
  }
}
