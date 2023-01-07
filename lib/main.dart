import 'package:flutter/material.dart';
import 'package:financial_management/finance.dart';
import 'package:financial_management/gui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String currency = '€';
  final List<FinancialMove> financialMoves = [];

  void _introduceNewMove(String descriptor, int balance) {
    setState(() {
      financialMoves
          .add(FinancialMove(descriptor: descriptor, balance: balance));
    });
  }

  void _showMoveDialog() {
    showDialog<void>(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return SimpleDialog(title: const Text("Pick move"), children: [
            DialogItem(
                icon: Icons.account_balance,
                text: "Add balance",
                onPressed: () {}),
            DialogItem(
                icon: Icons.shopping_cart,
                text: "Subtract balance",
                onPressed: () {}),
            DialogItem(
                icon: Icons.person, text: "Lend balance", onPressed: () {}),
            DialogItem(
                icon: Icons.attach_money,
                text: "Borrow balance",
                onPressed: () {}),
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    int totalBalanceDisplayNumber =
        calculateTotalFinancialMoves(financialMoves);
    String totalBalanceFormat =
        '${totalBalanceDisplayNumber > 0 ? '+' : ''}$totalBalanceDisplayNumber$currency';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Financial Moves"),
      ),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 50),
            // Shows current balance with a nice + or - sign
            child: Text(
              totalBalanceFormat,
              style: Theme.of(context).textTheme.headline4,
            )),
        // Shows all moves in a nice list
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: financialMoves.length,
          itemBuilder: (context, index) {
            FinancialMove financialMove =
                financialMoves.reversed.toList()[index];
            return FinancialMoveWidget(
              descriptor: financialMove.descriptor,
              balance: financialMove.balance.toString(),
            );
          },
        )
      ]),
      // Floating action button that pops a dialog with many actions (add balance, substract balance, etc.)
      floatingActionButton: FloatingActionButton(
        onPressed: _showMoveDialog,
        tooltip: 'Make a change',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
