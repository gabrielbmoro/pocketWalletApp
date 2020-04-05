// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:pocketwallet/database/dao/transaction_dao.dart';
import 'package:pocketwallet/models/transaction.dart';
import 'package:pocketwallet/screens/home/transactions/transactions_list.dart';
import 'walletreport/wallet_report.dart';

const String HOME_PAGE_TITLE = 'Carteira de Bolso';

class HomePage extends StatelessWidget {

  PocketWalletTransactionDao _transactionDao = PocketWalletTransactionDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HOME_PAGE_TITLE),
      ),
      body: FutureBuilder<List<PocketWalletTransaction>>(
          initialData: List(),
          future: _transactionDao.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Carregando'),
                  ],
                ));
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<PocketWalletTransaction> transactions = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      WalletReport(transactions),
                      TransactionsList(transactions),
                    ],
                  ),
                );
            }
            return Text('Ocorreu algum problema desconhecido');
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {},
      ),
    );
  }
}
