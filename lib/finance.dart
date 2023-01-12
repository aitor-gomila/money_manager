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

  /// Adds [item] to cart
  void add(Move item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  final List<Move> _debtItems = [];
  List<Move> get debtItems => _debtItems;
  int get debtTotal => calculateTotalFinancialMoves(debtItems);

  void debtAdd(Move item) {
    _debtItems.add(item);
    notifyListeners();
  }

  void debtClear(int index) {
    _items.add(_debtItems[index]);
    _debtItems.removeAt(index);
    notifyListeners();
  }

  final List<Move> _borrowItems = [];
  List<Move> get borrowItems => _borrowItems;
  int get borrowTotal => calculateTotalFinancialMoves(borrowItems);

  void borrowAdd(Move item) {
    // Add negative balance to balance, add to borrow; then clear out
    _items.add(Move(descriptor: item.descriptor, balance: -item.balance));
    _borrowItems.add(item);
    notifyListeners();
  }

  void borrowClear(int index) {
    Move borrowItem = _borrowItems[index];
    _items.add(
        Move(descriptor: borrowItem.descriptor, balance: borrowItem.balance));
    _borrowItems.removeAt(index);
    notifyListeners();
  }
}
