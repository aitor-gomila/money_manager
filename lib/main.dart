import 'package:flutter/material.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class FinancialMove {
  final String descriptor;
  final int balance;
  const FinancialMove({required this.descriptor, required this.balance});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class DialogItem extends StatelessWidget {
  const DialogItem(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed});

  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 36),
            Flexible(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 16),
                child: Text(text),
              ),
            )
          ]),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final String currency = '€';
  final List<FinancialMove> financialMoves = [
    const FinancialMove(descriptor: "Inicial", balance: 350)
  ];

  int _calculateTotalFinancialMoves() {
    int balance = 0;
    for (var financialMove in financialMoves) {
      balance += financialMove.balance;
    }
    return balance;
  }

  void _introduceNewMove(String descriptor, int balance) {
    setState(() {
      financialMoves
          .add(FinancialMove(descriptor: descriptor, balance: balance));
    });
  }

  String _getSignToInteger(int value) {
    if (value > 0) return '+';
    if (value < 0) return '-';
    return '';
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
    int totalBalanceDisplayNumber = _calculateTotalFinancialMoves();
    String totalBalanceFormat =
        '${_getSignToInteger(totalBalanceDisplayNumber)}$totalBalanceDisplayNumber$currency';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Financial Moves"),
      ),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 50),
            child: Text(
              totalBalanceFormat,
              style: Theme.of(context).textTheme.headline4,
            )),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: financialMoves.length,
          itemBuilder: (context, index) {
            FinancialMove move = financialMoves[index];
            return Row(
              children: [
                Text(move.descriptor),
                Text('${_getSignToInteger(move.balance)}${move.balance}€')
              ],
            );
          },
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _showMoveDialog,
        tooltip: 'Make a change',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
