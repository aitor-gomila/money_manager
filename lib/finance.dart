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

class FinancialModel extends ChangeNotifier {
  /// Internal, private state of the cart
  final List<Move> _items = [];

  /// An unmodifiable view of the items in the cart
  List<Move> get items => _items;

  /// The current total price of all items
  int get total => calculateTotalFinancialMoves(items);

  /// Adds [item] to cart
  void add(Move item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}

class DebtModel extends ChangeNotifier {
  final List<Move> _items = [];
  List<Move> get items => _items;
  int get total => calculateTotalFinancialMoves(items);

  void add(Move item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(int index) {
    _items.add(_items[index]);
    _items.removeAt(index);
    notifyListeners();
  }
}

class BorrowModel extends ChangeNotifier {
  final List<Move> _items = [];
  List<Move> get items => _items;
  int get total => calculateTotalFinancialMoves(items);

  void add(Move item) {
    // Add negative balance to balance, add to borrow; then clear out
    _items.add(Move(descriptor: item.descriptor, balance: -item.balance));
    _items.add(item);
    notifyListeners();
  }

  void remove(int index) {
    Move borrowItem = _items[index];
    _items.add(
        Move(descriptor: borrowItem.descriptor, balance: borrowItem.balance));
    _items.removeAt(index);
    notifyListeners();
  }
}
