import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final BuildContext context;

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

  FinancialModel({required initialItems, required this.context}) {
    for (var item in initialItems) {
      _items.add(item);
    }
  }
}

class DebtModel extends ChangeNotifier {
  final BuildContext context;
  final List<Move> _items = [];
  List<Move> get items => _items;
  int get total => calculateTotalFinancialMoves(items);

  void add(Move item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(int index) {
    _items.add(_items[index]);
    Provider.of<FinancialModel>(context, listen: false)._items.removeAt(index);
    notifyListeners();
  }

  DebtModel({required initialItems, required this.context}) {
    for (var item in initialItems) {
      _items.add(item);
    }
  }
}

class BorrowModel extends ChangeNotifier {
  final BuildContext context;
  final List<Move> _items = [];
  List<Move> get items => _items;
  int get total => calculateTotalFinancialMoves(items);

  void add(Move item) {
    // Add negative balance to balance, add to borrow; then clear out
    _items.add(Move(descriptor: item.descriptor, balance: -item.balance));
    Provider.of<FinancialModel>(context, listen: false).items.add(item);
    notifyListeners();
  }

  void remove(int index) {
    Move borrowItem = _items[index];
    _items.add(
        Move(descriptor: borrowItem.descriptor, balance: borrowItem.balance));
    Provider.of<FinancialModel>(context, listen: false)._items.removeAt(index);
    notifyListeners();
  }

  BorrowModel({required initialItems, required this.context}) {
    for (var item in initialItems) {
      _items.add(item);
    }
  }
}
