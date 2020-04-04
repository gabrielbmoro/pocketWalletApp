import 'package:flutter/material.dart';
import 'package:pocketwallet/screens/models/expense.dart';
import 'package:pocketwallet/screens/models/expense_type.dart';
import 'package:pocketwallet/screens/models/income.dart';
import 'package:pocketwallet/screens/models/transaction.dart';
import 'package:pocketwallet/screens/util/currency.dart';

class TransactionsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TransactionsState();
  }
}

//String source, double value, int month, int year
class TransactionsState extends State {

  List<Transaction> _transactionList = [
    Expense(ExpenseType.GYM, 120.0, 1, 20),
    Income('aisdjij', 120.0, 1, 20),
    Expense(ExpenseType.TRANSPORT, 120.0, 1, 20),
    Income('aisdjij', 120.0, 1, 20),
    Income('aisdjij', 120.0, 1, 20),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return TransactionCard(_transactionList[index]);
      },
      itemCount: _transactionList.length,
    );
  }
}

class TransactionCard extends StatelessWidget {
  final Transaction _item;

  TransactionCard(this._item);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  convertToCurrencyFormat(_item.value),
                  textScaleFactor: 1.6,
                ),
                _item.description() != null
                    ? Text(
                        _item.description(),
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: getIconAccordingToTransactionType(),
          ),
        ],
      ),
    );
  }

  Icon getIconAccordingToTransactionType() {
    return Icon(_item.icon(), color:  _item.color());
  }
}
