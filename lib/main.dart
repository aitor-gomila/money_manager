import 'package:money_manager/widgets/dialogs.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:money_manager/routes/balance.dart';
import 'package:money_manager/routes/borrow.dart';
import 'package:money_manager/routes/debt.dart';

import 'package:money_manager/types/savedata.dart';
import 'package:money_manager/types/finance.dart';

import 'package:money_manager/widgets/future_save_data_read.dart';
import 'package:money_manager/widgets/main_navigation_bar.dart';
import 'package:money_manager/widgets/main_state_providers.dart';

import 'package:money_manager/finance.dart';
import 'package:money_manager/savedata.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureSaveDataRead(
        builder: (configModel) => MainStateProviders(
            configModel: configModel,
            builder: (context, _) => MaterialApp(
                  title: 'Money manager',
                  theme: ThemeData(
                      primarySwatch: Colors.green, useMaterial3: true),
                  home: const MyHomePage(),
                )));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    FinancialModel financialModel =
        Provider.of<FinancialModel>(context, listen: false);
    DebtModel debtModel = Provider.of<DebtModel>(context, listen: false);
    BorrowModel borrowModel = Provider.of<BorrowModel>(context, listen: false);
    // TODO: not too sure about this
    saveData.write(ConfigModel(
        financialMoves: financialModel.items,
        debtMoves: debtModel.items,
        borrowMoves: borrowModel.items));

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
      Provider.of<FinancialModel>(context, listen: false),
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
