import 'package:flutter/material.dart';

const String currency = '€';

class Move {
  final String descriptor;
  final int balance;
  const Move({required this.descriptor, required this.balance});
}

int calculateTotalFinancialMoves(List<Move> movesList) {
  int balance = 0;
  for (var move in movesList) {
    balance += move.balance;
  }
  return balance;
}

class Model extends ChangeNotifier {
  /// Internal, private state of the cart
  final List<Move> _items = [];

  /// An unmodifiable view of the items in the cart
  List<Move> get items => _items;

  /// The current total price of all items
  int get total => calculateTotalFinancialMoves(items);

  void remove(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  /// Adds [item] to cart
  void add(Move item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
