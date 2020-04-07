import 'package:flutter/material.dart';
import 'package:pocketwallet/models/transaction.dart';
import 'transaction_card.dart';

class TransactionsList extends StatefulWidget {
  List<PocketWalletTransaction> _transactions;

  TransactionsList(this._transactions);

  @override
  State<StatefulWidget> createState() {
    return TransactionsState(_transactions);
  }
}

//String source, double value, int month, int year
class TransactionsState extends State<TransactionsList> {
  List<PocketWalletTransaction> _transactions;

  TransactionsState(this._transactions);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return TransactionCard(_transactions[index]);
      },
      itemCount: _transactions.length,
    );
  }
}
