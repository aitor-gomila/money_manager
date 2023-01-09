import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      title: 'Financial Moves',
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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CartModel(),
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Financial Moves"),
            ),
            // Floating action button that pops a dialog with many actions (add balance, substract balance, etc.)
            floatingActionButton:
                Consumer<CartModel>(builder: (context, cart, child) {
              return FloatingActionButton(
                onPressed: () {
                  showMoveDialog(context, cart);
                },
                tooltip: 'Make a change',
                child: const Icon(Icons.add),
              );
            }),
            body: Consumer<CartModel>(
              builder: (context, cart, child) {
                List<FinancialMove> cartItems = cart.items.reversed.toList();
                return Column(children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 50),
                      // Shows current balance with a nice + or - sign
                      child: Text(
                        '${cart.total}${cart.currency}',
                        style: Theme.of(context).textTheme.headline4,
                      )),
                  // Shows all moves in a nice list
                  Expanded(
                      child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      FinancialMove item = cartItems[index];
                      return FinancialMoveWidget(
                        descriptor: item.descriptor,
                        balance: item.balance.toString(),
                      );
                    },
                  )),
                ]);
              },
            )));
  }
}
