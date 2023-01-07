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
