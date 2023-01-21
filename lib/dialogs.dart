import 'package:flutter/material.dart';
import 'package:money_manager/finance.dart';
import 'package:provider/provider.dart';

typedef OnDoneFunction = void Function(
    {required String descriptor, required int balance});

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

class MoveDialog extends StatelessWidget {
  const MoveDialog({super.key, required this.title, required this.onDone});

  final String title;
  final OnDoneFunction onDone;

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
            onDone(
                descriptor: descriptor.text, balance: int.parse(balance.text));
          },
        )
      ],
    );
  }
}

void showPromptMoveDialog(BuildContext context,
    {required String title, required OnDoneFunction onDone}) {
  showDialog<void>(
      context: context,
      builder: (context) => MoveDialog(title: title, onDone: onDone));
}

void showMoveDialog(BuildContext context) {
  showDialog<void>(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) {
        return Consumer3<FinancialModel, DebtModel, BorrowModel>(
            builder: (context, financialCart, debtCart, borrowCart, child) {
          return SimpleDialog(title: const Text("Make move"), children: [
            DialogItem(
                icon: Icons.account_balance,
                text: "Add/subtract balance",
                onPressed: () {
                  Navigator.pop(context);
                  showPromptMoveDialog(context,
                      title: "Add/subtract",
                      onDone: (({required balance, required descriptor}) =>
                          financialCart.add(
                              Move(balance: balance, descriptor: descriptor))));
                }),
            DialogItem(
                icon: Icons.person,
                text: "Debt",
                onPressed: () {
                  Navigator.pop(context);
                  showPromptMoveDialog(context,
                      title: "Debt",
                      onDone: (({required balance, required descriptor}) =>
                          debtCart.add(
                              Move(balance: balance, descriptor: descriptor))));
                }),
            DialogItem(
                icon: Icons.attach_money,
                text: "Borrow",
                onPressed: () {
                  Navigator.pop(context);
                  showPromptMoveDialog(context,
                      title: "Borrow",
                      onDone: (({required balance, required descriptor}) =>
                          borrowCart.add(
                              Move(balance: balance, descriptor: descriptor))));
                }),
          ]);
        });
      });
}