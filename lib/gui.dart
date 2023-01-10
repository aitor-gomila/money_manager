import 'package:financial_management/finance.dart';
import 'package:flutter/material.dart';

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

class FinancialMoveWidget extends StatelessWidget {
  const FinancialMoveWidget(
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

class MoveDialog extends StatelessWidget {
  const MoveDialog(
      {super.key,
      required this.title,
      required this.cart,
      required this.onMove});

  final String title;
  final FinancialModel cart;
  final Function(String descriptor, int balance) onMove;

  @override
  Widget build(BuildContext context) {
    TextEditingController descriptor = TextEditingController();
    TextEditingController balance = TextEditingController();
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: descriptor,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: balance,
            decoration: const InputDecoration(labelText: 'Balance (+/-)'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text("Move"),
          onPressed: () {
            Navigator.pop(context);
            onMove(descriptor.text, int.parse(balance.text));
          },
        )
      ],
    );
  }
}

void showPromptMoveDialog(BuildContext context, FinancialModel cart,
    String title, Function(String, int) onMove) {
  showDialog<void>(
      context: context,
      builder: (context) => MoveDialog(
            title: title,
            cart: cart,
            onMove: onMove,
          ));
}

void showMoveDialog(BuildContext context, FinancialModel cart) {
  showDialog<void>(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) {
        return SimpleDialog(title: const Text("Make move"), children: [
          DialogItem(
              icon: Icons.account_balance,
              text: "Add/subtract balance",
              onPressed: () {
                Navigator.pop(context);
                showPromptMoveDialog(
                    context,
                    cart,
                    "Add/subtract balance",
                    (descriptor, balance) => cart.add(FinancialMove(
                        descriptor: descriptor, balance: balance)));
              }),
          DialogItem(
              icon: Icons.attach_money,
              text: "Lend balance",
              onPressed: () {
                Navigator.pop(context);
                showPromptMoveDialog(
                    context, cart, "Lend balance", (descriptor, balance) {});
              }),
          DialogItem(
              icon: Icons.person,
              text: "Balance exception",
              onPressed: () {
                Navigator.pop(context);
                showPromptMoveDialog(context, cart, "Balance exception",
                    (descriptor, balance) {});
              }),
        ]);
      });
}
