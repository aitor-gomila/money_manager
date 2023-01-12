import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:financial_management/finance.dart';
import 'package:financial_management/gui.dart';

class DebtRoute extends StatefulWidget {
  const DebtRoute({super.key});

  @override
  State<DebtRoute> createState() => _DebtRouteState();
}

class _DebtRouteState extends State<DebtRoute> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Model>(
      builder: (context, cart, child) {
        List<Move> debtItems = cart.debtItems.reversed.toList();
        return Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 50),
                // Shows current balance with a nice + or - sign
                child: Text(
                  '${cart.debtTotal > 0 ? '+' : ''}${cart.debtTotal}$currency',
                  style: Theme.of(context).textTheme.headline4,
                )),
            // Shows all moves in a nice list
            Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: debtItems.length,
                    itemBuilder: (context, index) => InkWell(
                        onTap: () {},
                        child: FinancialMoveWidget(
                          descriptor: debtItems[index].descriptor,
                          balance: debtItems[index].balance,
                          currency: currency,
                        ))))
          ],
        );
      },
    );
  }
}
