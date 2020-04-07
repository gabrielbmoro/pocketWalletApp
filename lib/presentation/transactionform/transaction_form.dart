import 'package:flutter/material.dart';
import 'package:pocketwallet/models/transaction.dart';
import 'package:pocketwallet/presentation/transactionform/expense_options.dart';
import '../strings.dart';

class NewTransaction extends StatefulWidget {
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  TransactionType _type = TransactionType.INCOME;

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
                  onPressed: () => {},
                  child: Text(SAVE),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPanelAccordingToTransactionType() {
    switch (_type) {
      case TransactionType.EXPENSE:
        return ExpenseOptions();
      case TransactionType.INCOME:
        return TextField(
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
