import 'package:money_manager/widgets/data/dialog/dialog_move.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:money_manager/widgets/navigation/routes/balance.dart';
import 'package:money_manager/widgets/navigation/routes/borrow.dart';
import 'package:money_manager/widgets/navigation/routes/debt.dart';

import 'package:money_manager/types/finance.dart';

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
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = [
      const BalanceRoute(),
      const DebtRoute(),
      const BorrowRoute()
    ];
    List<String> dialogTitleOptions = [
      "Add/subtract balance",
      "Debt",
      "Borrow"
    ];
    List<Model> stateOptions = [
      Provider.of<BalanceModel>(context, listen: false),
      Provider.of<DebtModel>(context, listen: false),
      Provider.of<BorrowModel>(context, listen: false),
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text("Financial Moves"),
        ),
        // Floating action button that pops a dialog with many actions (add balance, substract balance, etc.)
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            var provider = stateOptions.elementAt(selectedIndex);
            showMoveDialog(context,
                title: dialogTitleOptions.elementAt(selectedIndex),
                onDone: ({required balance, required descriptor}) {
              Move item = Move(balance: balance, descriptor: descriptor);
              provider.add(item);
            });
          },
          tooltip: 'Make a change',
          child: const Icon(Icons.add),
        ),
        body: widgetOptions.elementAt(selectedIndex),
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
