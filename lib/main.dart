import 'package:financial_management/routes/balance.dart';
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => FinancialModel()),
          ChangeNotifierProvider(create: (context) => BorrowModel()),
          ChangeNotifierProvider(create: (context) => DebtModel()),
        ],
        builder: (context, child) => MaterialApp(
              title: 'Financial Moves',
              theme: ThemeData(
                primarySwatch: Colors.green,
              ),
              home: const MyHomePage(),
            ));
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
    List<Widget> widgetOptions = [
      const BalanceRoute(),
      const Center(child: Text("Debt")),
      const Center(
        child: Text("Borrow"),
      )
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
