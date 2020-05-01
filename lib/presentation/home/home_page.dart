// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:pocketwallet/database/dao/transaction_dao.dart';
import 'package:pocketwallet/models/transaction.dart';
import 'package:pocketwallet/presentation/home/transactions/transactions_list.dart';
import 'package:pocketwallet/presentation/transactionform/transaction_form.dart';
import '../strings.dart';
import 'walletreport/wallet_report.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PocketWalletTransactionDao _transactionDao = PocketWalletTransactionDao();
  final _reportKey = new GlobalKey<WalletReportState>();

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
                return _loadingWidget();
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                return _bodyWidget(snapshot.data);
            }
            return Text(ERROR_MESSAGE);
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
          _addNewTransactionEvent(context),
        },
      ),
    );
  }

  void _addNewTransactionEvent(BuildContext context) {
    if (_reportKey.currentState != null)
      _reportKey.currentState.stopAnimation();
    _callNewTransactionScreen(context);
  }

  void _callNewTransactionScreen(BuildContext context) async {
    final int newElementId = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewTransaction(),
      ),
    );
    if (newElementId != null) {
      setState(() {});
    }
  }

  Widget _bodyWidget(List<PocketWalletTransaction> transactions) {
    if (transactions.isEmpty) {
      return _emptyState();
    } else {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            WalletReport(_reportKey, transactions),
            TransactionsList(transactions),
          ],
        ),
      );
    }
  }

  Widget _emptyState() {
    return Center(child: Text(THERE_IS_NO_DATA));
  }

  Widget _loadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(LOADING),
      ],
    ));
  }
}
