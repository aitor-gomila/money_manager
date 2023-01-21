import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:money_manager/finance.dart';

class BorrowRoute extends StatefulWidget {
  const BorrowRoute({super.key});

  @override
  State<BorrowRoute> createState() => _BorrowRouteState();
}

class BorrowMoveWidget extends StatelessWidget {
  const BorrowMoveWidget(
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
        Text('$descriptor · ${balance > 0 ? '+' : ''}$balance$currency'),
      ]),
    );
  }
}

class _BorrowRouteState extends State<BorrowRoute> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BorrowModel>(
      builder: (context, cart, child) {
        List<Move> borrowItems = cart.items.reversed.toList();
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
                        child: BorrowMoveWidget(
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
