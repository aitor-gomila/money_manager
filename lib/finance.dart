import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class FinancialMove {
  final String descriptor;
  final int balance;
  const FinancialMove({required this.descriptor, required this.balance});
}

int calculateTotalFinancialMoves(List<FinancialMove> financialMovesList) {
  int balance = 0;
  for (var financialMove in financialMovesList) {
    balance += financialMove.balance;
  }
  return balance;
}

class CartModel extends ChangeNotifier {
  final String currency = '€';

  /// Internal, private state of the cart
  final List<FinancialMove> _items = [];

  /// An unmodifiable view of the items in the cart
  List<FinancialMove> get items => _items;

  /// The current total price of all items
  int get total => calculateTotalFinancialMoves(items);

  /// Adds [item] to cart
  void add(FinancialMove item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
