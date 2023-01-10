import 'package:flutter/material.dart';

// All types are the same and are based on the type 'Move',
// their only purpose is to differenciate them when it is needed
// Financial moves are immutable; borrow and debt can be cleared out
abstract class Move {
  final String descriptor;
  final int balance;
  const Move({required this.descriptor, required this.balance});
}

class FinancialMove extends Move {
  const FinancialMove({descriptor, balance})
      : super(descriptor: descriptor, balance: balance);
}

// Debt and borrow are not the same; Debt is when someone owes you money;
// Borrow is when you give money to someone and need to make sure it comes back
// borrow is also useful if you want to spend a certain amount of money but
// make sure it comes back.

class DebtMove extends Move {
  const DebtMove({descriptor, balance})
      : super(descriptor: descriptor, balance: balance);
}

class BorrowMove extends Move {
  const BorrowMove({descriptor, balance})
      : super(descriptor: descriptor, balance: balance);
}

int calculateTotalFinancialMoves(List<Move> financialMovesList) {
  int balance = 0;
  for (var financialMove in financialMovesList) {
    balance += financialMove.balance;
  }
  return balance;
}

class FinancialModel extends ChangeNotifier {
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

class DebtModel extends ChangeNotifier {
  final String currency = '€';

  /// Internal, private state of the cart
  final List<DebtMove> _items = [];

  /// An unmodifiable view of the items in the cart
  List<DebtMove> get items => _items;

  /// The current total price of all items
  int get total => calculateTotalFinancialMoves(items);

  void remove(int index) {
    _items.removeAt(index);
  }

  /// Adds [item] to cart
  void add(DebtMove item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}

class BorrowModel extends ChangeNotifier {
  final String currency = '€';

  /// Internal, private state of the cart
  final List<FinancialMove> _items = [];

  /// An unmodifiable view of the items in the cart
  List<FinancialMove> get items => _items;

  /// The current total price of all items
  int get total => calculateTotalFinancialMoves(items);

  void remove(int index) {
    _items.removeAt(index);
  }

  /// Adds [item] to cart
  void add(FinancialMove item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
