import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:money_manager/finance/data/types.dart';

import 'package:money_manager/finance/data/balance.dart';

class BorrowModel extends Model with ChangeNotifier {
  final BuildContext context;
  final List<Move> _items = [];
  @override
  List<Move> get items => _items;
  int get total => items
      .map(((e) => e.balance))
      .fold<int>(0, (previousValue, element) => previousValue + element);

  @override
  void add(Move item) {
    // Add negative balance to balance, add to borrow; then clear out
    Provider.of<BalanceModel>(context, listen: false)
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
    Provider.of<BalanceModel>(context, listen: false).add(
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
