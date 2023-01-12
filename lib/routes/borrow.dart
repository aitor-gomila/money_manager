import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:financial_management/finance.dart';
import 'package:financial_management/gui.dart';

class BorrowRoute extends StatefulWidget {
  const BorrowRoute({super.key});

  @override
  State<BorrowRoute> createState() => _BorrowRouteState();
}

class _BorrowRouteState extends State<BorrowRoute> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Model>(
      builder: (context, cart, child) {
        List<Move> borrowItems = cart.borrowItems.reversed.toList();
        return Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 50),
                // Shows current balance with a nice + or - sign
                child: Text(
                  '${cart.total > 0 ? '+' : ''}${cart.total}$currency',
                  style: Theme.of(context).textTheme.headline4,
                )),
            // Shows all moves in a nice list
            Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: borrowItems.length,
                    itemBuilder: (context, index) => InkWell(
                        onTap: () {},
                        child: FinancialMoveWidget(
                          descriptor: borrowItems[index].descriptor,
                          balance: borrowItems[index].balance,
                          currency: currency,
                        ))))
          ],
        );
      },
    );
  }
}
