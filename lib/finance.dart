import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:money_manager/types/finance.dart';

class FinancialModel extends ChangeNotifier {
  final BuildContext context;

  /// Internal, private state of the cart
  final List<Move> _items = [];

  /// An unmodifiable view of the items in the cart
  List<Move> get items => _items;

  /// The current total price of all items
  int get total => items
      .map(((e) => e.balance))
      .fold<int>(0, (previousValue, element) => previousValue + element);

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
  int get total => items
      .map(((e) => e.balance))
      .fold<int>(0, (previousValue, element) => previousValue + element);

  void add(Move item) {
    _items.add(item);
    notifyListeners();
  }

  void clearUnpaid(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clear(int index) {
    Provider.of<FinancialModel>(context, listen: false).add(_items[index]);
    _items.removeAt(index);
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
  int get total => items
      .map(((e) => e.balance))
      .fold<int>(0, (previousValue, element) => previousValue + element);

  void add(Move item) {
    // Add negative balance to balance, add to borrow; then clear out
    Provider.of<FinancialModel>(context, listen: false)
        .add(Move(descriptor: item.descriptor, balance: -item.balance));
    _items.add(item);
    notifyListeners();
  }

  void clearUnpaid(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clear(int index) {
    Move borrowItem = _items[index];
    Provider.of<FinancialModel>(context, listen: false).add(
        Move(descriptor: borrowItem.descriptor, balance: borrowItem.balance));
    _items.removeAt(index);
    notifyListeners();
  }

  BorrowModel({required initialItems, required this.context}) {
    for (var item in initialItems) {
      _items.add(item);
    }
  }
}
