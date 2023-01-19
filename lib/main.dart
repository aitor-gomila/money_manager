import 'package:financial_management/routes/balance.dart';
import 'package:financial_management/routes/borrow.dart';
import 'package:financial_management/routes/debt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:financial_management/gui.dart';
import 'package:financial_management/finance.dart';
import 'package:financial_management/savedata.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: saveData.read(),
        builder: (context, snapshot) => MultiProvider(
                providers: [
                  ChangeNotifierProvider<FinancialModel>(
                      create: (_) => FinancialModel(
                          initialItems: snapshot.data?.financialMoves ?? [])),
                  ChangeNotifierProvider<DebtModel>(
                      create: (_) => DebtModel(
                          initialItems: snapshot.data?.debtMoves ?? [])),
                  ChangeNotifierProvider<BorrowModel>(
                      create: (_) => BorrowModel(
                          initialItems: snapshot.data?.borrowMoves ?? [])),
                ],
                builder: (context, child) => MaterialApp(
                      title: 'Financial Moves',
                      theme: ThemeData(
                        primarySwatch: Colors.green,
                      ),
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
  int _selectedIndex = 0;
  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    FinancialModel financialModel =
        Provider.of<FinancialModel>(context, listen: false);
    DebtModel debtModel = Provider.of<DebtModel>(context, listen: false);
    BorrowModel borrowModel = Provider.of<BorrowModel>(context, listen: false);

    saveData.write(ConfigModel(
        financialMoves: financialModel.items,
        debtMoves: debtModel.items,
        borrowMoves: borrowModel.items));

    List<Widget> widgetOptions = [
      const BalanceRoute(),
      const DebtRoute(),
      const BorrowRoute()
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Financial Moves"),
      ),
      // Floating action button that pops a dialog with many actions (add balance, substract balance, etc.)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMoveDialog(context);
        },
        tooltip: 'Make a change',
        child: const Icon(Icons.add),
      ),
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance), label: "Balance"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Debt"),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), label: "Borrow")
        ],
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
    );
  }
}
