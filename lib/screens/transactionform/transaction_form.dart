import 'package:flutter/material.dart';
import 'package:pocketwallet/models/transaction.dart';

const String VALUE = 'Valor:';
const String SAVE = 'Salvar';
const String INCOME = 'Entrada';
const String EXPENSE = 'Saída';
const String TRANSACAO = 'Nova Transação';

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
}
