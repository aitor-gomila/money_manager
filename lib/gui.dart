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
      {super.key, required this.descriptor, required this.balance});

  final String descriptor;
  final String balance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 50),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(descriptor), Text(balance)]),
    );
  }
}

class MoveDialog extends StatelessWidget {
  const MoveDialog({super.key, required this.title, required this.cart});

  final String title;
  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    TextEditingController descriptor = TextEditingController();
    TextEditingController balance = TextEditingController();
    return AlertDialog(
      title: Text(title),
      content: Column(
        children: [
          TextField(
            controller: descriptor,
          ),
          TextField(
            controller: balance,
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
            cart.add(FinancialMove(
                descriptor: descriptor.value.toString(),
                balance: int.parse(balance.value.toString())));
          },
        )
      ],
    );
  }
}

void showPromptMoveDialog(BuildContext context, String title, CartModel cart) {
  showDialog<void>(
      context: context,
      builder: (context) => MoveDialog(
            title: title,
            cart: cart,
          ));
}

void showMoveDialog(BuildContext context, CartModel cart) {
  showDialog<void>(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) {
        return SimpleDialog(title: const Text("Make move"), children: [
          DialogItem(
              icon: Icons.account_balance,
              text: "Add balance",
              onPressed: () {
                Navigator.pop(context);
                showPromptMoveDialog(context, "Add balance", cart);
              }),
          DialogItem(
              icon: Icons.shopping_cart,
              text: "Subtract balance",
              onPressed: () {
                Navigator.pop(context);
                showPromptMoveDialog(context, "Subtract balance", cart);
              }),
          DialogItem(
              icon: Icons.person,
              text: "Lend balance",
              onPressed: () {
                Navigator.pop(context);
                showPromptMoveDialog(context, "Lend balance", cart);
              }),
          DialogItem(
              icon: Icons.attach_money,
              text: "Borrow balance",
              onPressed: () {
                Navigator.pop(context);
                showPromptMoveDialog(context, "Borrow balance", cart);
              }),
        ]);
      });
}
