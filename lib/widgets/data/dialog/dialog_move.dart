import 'package:flutter/material.dart';

// TODO: not sure about this

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

void showMoveDialog(BuildContext context,
    {required String title, required OnDoneFunction onDone}) {
  showDialog<void>(
      context: context,
      builder: (context) => MoveDialog(title: title, onDone: onDone));
}
