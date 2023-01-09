import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:financial_management/finance.dart';
import 'package:financial_management/gui.dart';

class BalanceRoute extends StatefulWidget {
  const BalanceRoute({super.key});

  @override
  State<BalanceRoute> createState() => _BalanceRouteState();
}

class _BalanceRouteState extends State<BalanceRoute> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: ((context, cart, child) {
        List<FinancialMove> cartItems = cart.items.reversed.toList();
        return Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 50),
                // Shows current balance with a nice + or - sign
                child: Text(
                  '${cart.total > 0 ? '+' : ''}${cart.total}${cart.currency}',
                  style: Theme.of(context).textTheme.headline4,
                )),
            // Shows all moves in a nice list
            Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) => InkWell(
                        onTap: () {},
                        child: FinancialMoveWidget(
                          descriptor: cartItems[index].descriptor,
                          balance: cartItems[index].balance,
                          currency: cart.currency,
                        ))))
          ],
        );
      }),
    );
  }
}
