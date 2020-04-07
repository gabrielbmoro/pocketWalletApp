import 'package:flutter/material.dart';
import 'package:pocketwallet/models/transaction.dart';
import 'package:pocketwallet/util/currency.dart';

class TransactionCard extends StatelessWidget {
  final PocketWalletTransaction _item;

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
    return Icon(_item.icon(), color: _item.color());
  }
}
