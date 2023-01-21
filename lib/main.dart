import 'package:money_manager/routes/balance.dart';
import 'package:money_manager/routes/borrow.dart';
import 'package:money_manager/routes/debt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:money_manager/gui.dart';
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
    return FutureBuilder<ConfigModel>(
        future: saveData.read(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MultiProvider(
                providers: [
                  ChangeNotifierProvider<FinancialModel>(
                      create: (context) => FinancialModel(
                          context: context,
                          initialItems: snapshot.data?.financialMoves ?? [])),
                  ChangeNotifierProvider<DebtModel>(
                      create: (context) => DebtModel(
                          context: context,
                          initialItems: snapshot.data?.debtMoves ?? [])),
                  ChangeNotifierProvider<BorrowModel>(
                      create: (context) => BorrowModel(
                          context: context,
                          initialItems: snapshot.data?.borrowMoves ?? [])),
                ],
                builder: (context, child) => MaterialApp(
                      title: 'Financial Moves',
                      theme: ThemeData(
                        primarySwatch: Colors.green,
                      ),
                      home: const MyHomePage(),
                    ));
          } else if (snapshot.hasError) {
            return Center(
                child: Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                snapshot.error.toString(),
              ),
            ));
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  void _onTap(int index) {
    setState(() {
      selectedIndex = index;
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
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance), label: "Balance"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Debt"),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), label: "Borrow")
        ],
        currentIndex: selectedIndex,
        onTap: _onTap,
      ),
    );
  }
}
