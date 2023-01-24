import 'package:money_manager/data/savedata/savedata.dart';
import 'package:money_manager/types/savedata.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:money_manager/widgets/navigation/routes/balance.dart';
import 'package:money_manager/widgets/navigation/routes/borrow.dart';
import 'package:money_manager/widgets/navigation/routes/debt.dart';

import 'package:money_manager/widgets/navigation/main_navigation_bar.dart';

import 'package:money_manager/data/finance/balance.dart';
import 'package:money_manager/data/finance/debt.dart';
import 'package:money_manager/data/finance/borrow.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    setupSaveDataListeners();
  }

  void setupSaveDataListeners() {
    Provider.of<BalanceModel>(context, listen: false)
        .addListener(writeCurrentDataToSaveData);
    Provider.of<DebtModel>(context, listen: false)
        .addListener(writeCurrentDataToSaveData);
    Provider.of<BorrowModel>(context, listen: false)
        .addListener(writeCurrentDataToSaveData);
  }

  void writeCurrentDataToSaveData() {
    var balance = Provider.of<BalanceModel>(context, listen: false);
    var debt = Provider.of<DebtModel>(context, listen: false);
    var borrow = Provider.of<BorrowModel>(context, listen: false);
    var configModel = ConfigModel(
        balanceMoves: balance.items,
        debtMoves: debt.items,
        borrowMoves: borrow.items);
    saveData.write(configModel);
  }

  @override
  Widget build(BuildContext context) {
    List<String> dialogTitleOptions = [
      "Add/subtract balance",
      "Debt",
      "Borrow"
    ];
    List<AppBar> appBarOptions = [
      getBalanceAppBar(),
      getDebtAppBar(),
      getBorrowAppBar()
    ];

    return Scaffold(
        appBar: appBarOptions.elementAt(selectedIndex),
        body: <Widget>[
          const BalanceRoute(),
          const DebtRoute(),
          const BorrowRoute()
        ][selectedIndex],
        bottomNavigationBar: MainNavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ));
  }
}
