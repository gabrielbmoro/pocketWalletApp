import 'package:flutter/material.dart';
import 'package:pocketwallet/screens/models/transaction.dart';
import 'package:pocketwallet/screens/util/currency.dart';

class TransactionsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TransactionsState();
  }
}

class TransactionsState extends State {
  List<Transaction> transactionList = [
    Transaction(
      value: 1000.2,
      type: TransactionType.EXPENSE,
      description: 'description',
    ),
    Transaction(value: 1000.0, type: TransactionType.INCOME),
    Transaction(value: 100.0, type: TransactionType.INCOME),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return TransactionCard(transactionList[index]);
      },
      itemCount: transactionList.length,
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
                _item.description != null
                    ? Text(
                        _item.description,
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

  /*
  * getIconAccordingToTransactionType(),
          Text(convertToCurrencyFormat(_item.value)),
          Text(_item.description==null ? "": _item.description )*/

  Icon getIconAccordingToTransactionType() {
    Icon iconDefined = Icon(Icons.data_usage, color: Colors.transparent);
    switch (_item.type) {
      case TransactionType.INCOME:
        iconDefined = Icon(Icons.transit_enterexit, color: Colors.green);
        break;
      case TransactionType.EXPENSE:
        iconDefined = Icon(Icons.call_missed_outgoing, color: Colors.red);
        break;
      default:
        break;
    }
    return iconDefined;
  }
}
