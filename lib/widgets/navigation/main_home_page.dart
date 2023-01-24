import 'package:money_manager/data/savedata/savedata.dart';
import 'package:money_manager/types/savedata.dart';
import 'package:money_manager/widgets/data/dialog/dialog_move.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:money_manager/widgets/navigation/routes/balance.dart';
import 'package:money_manager/widgets/navigation/routes/borrow.dart';
import 'package:money_manager/widgets/navigation/routes/debt.dart';

import 'package:money_manager/types/finance.dart';

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
    List<NavigationDestination> navigationOptions = [
      const NavigationDestination(
          icon: Icon(Icons.account_balance), label: "Balance"),
      const NavigationDestination(icon: Icon(Icons.person), label: "Debt"),
      const NavigationDestination(
          icon: Icon(Icons.attach_money), label: "Borrow"),
    ];
    List<AppBar> appBarOptions = [
      getBalanceAppBar(() => showMoveDialog(context,
          title: "Balance",
          onDone: ({required balance, required descriptor}) =>
              Provider.of<BalanceModel>(context, listen: false)
                  .add(Move(descriptor: descriptor, balance: balance)))),
      getDebtAppBar(() => showMoveDialog(context,
          title: "Debt",
          onDone: ({required balance, required descriptor}) =>
              Provider.of<DebtModel>(context, listen: false)
                  .add(Move(descriptor: descriptor, balance: balance)))),
      getBorrowAppBar(() => showMoveDialog(context,
          title: "Borrow",
          onDone: ({required balance, required descriptor}) =>
              Provider.of<BorrowModel>(context, listen: false)
                  .add(Move(descriptor: descriptor, balance: balance))))
    ];

    return Scaffold(
        appBar: appBarOptions.elementAt(selectedIndex),
        body: <Widget>[
          const BalanceRoute(),
          const DebtRoute(),
          const BorrowRoute()
        ][selectedIndex],
        bottomNavigationBar: NavigationBar(
          destinations: navigationOptions,
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ));
  }
}
