import 'package:flutter/material.dart';
import 'package:money_manager/types/finance.dart';

class BalanceModel extends Model with ChangeNotifier {
  final BuildContext context;

  /// Internal, private state of the cart
  final List<Move> _items = [];

  /// An unmodifiable view of the items in the cart
  @override
  List<Move> get items => _items;

  /// The current total price of all items
  int get total => items
      .map(((e) => e.balance))
      .fold<int>(0, (previousValue, element) => previousValue + element);

  /// Adds [item] to cart
  @override
  void add(Move item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  BalanceModel({required initialItems, required this.context}) {
    for (var item in initialItems) {
      _items.add(item);
    }
  }
}
