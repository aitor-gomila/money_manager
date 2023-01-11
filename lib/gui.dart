import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:financial_management/finance.dart';

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
  const MoveDialog({super.key, required this.title, required this.cart});

  final String title;
  final Model cart;

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
          child: const Text("Confirm"),
          onPressed: () {
            Navigator.pop(context);
            cart.add(Move(
                balance: int.parse(balance.text), descriptor: descriptor.text));
          },
        )
      ],
    );
  }
}

void showPromptMoveDialog(BuildContext context, String title, Model cart) {
  showDialog<void>(
      context: context,
      builder: (context) => MoveDialog(title: title, cart: cart));
}

void showMoveDialog(BuildContext context) {
  showDialog<void>(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) {
        return SimpleDialog(title: const Text("Make move"), children: [
          Consumer<FinancialModel>(builder: (context, cart, child) {
            return DialogItem(
                icon: Icons.account_balance,
                text: "Add/subtract balance",
                onPressed: () {
                  Navigator.pop(context);
                  showPromptMoveDialog(context, "Add/subtract", cart);
                });
          }),
          Consumer<DebtModel>(
            builder: ((context, cart, child) {
              return DialogItem(
                  icon: Icons.person,
                  text: "Debt",
                  onPressed: () {
                    Navigator.pop(context);
                    showPromptMoveDialog(context, "Debt", cart);
                  });
            }),
          ),
          Consumer<BorrowModel>(builder: ((context, cart, child) {
            return DialogItem(
                icon: Icons.attach_money,
                text: "Borrow",
                onPressed: () {
                  Navigator.pop(context);
                  showPromptMoveDialog(context, "Borrow", cart);
                });
          }))
        ]);
      });
}
