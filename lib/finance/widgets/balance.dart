import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:money_manager/finance/data/types.dart';

import 'package:money_manager/finance/data/balance.dart';

class BalanceRoute extends StatefulWidget {
  const BalanceRoute({super.key});

  @override
  State<BalanceRoute> createState() => _BalanceRouteState();
}

class BalanceMoveWidget extends StatelessWidget {
  const BalanceMoveWidget(
      {super.key,
      required this.descriptor,
      required this.balance,
      required this.currency});

  final String currency;
  final String descriptor;
  final int balance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 50),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(descriptor),
        Text('${balance > 0 ? '+' : ''}$balance$currency')
      ]),
    );
  }
}

class _BalanceRouteState extends State<BalanceRoute> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BalanceModel>(
      builder: (context, cart, child) {
        List<Move> cartItems = cart.items.reversed.toList();
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
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) => BalanceMoveWidget(
                          descriptor: cartItems[index].descriptor,
                          balance: cartItems[index].balance,
                          currency: currency,
                        )))
          ],
        );
      },
    );
  }
}

AppBar Function(VoidCallback) getBalanceAppBar = (onAddButtonPressed) => AppBar(
      title: const Text("Balance"),
      actions: [
        IconButton(
          onPressed: onAddButtonPressed,
          icon: const Icon(Icons.add),
        )
      ],
    );
