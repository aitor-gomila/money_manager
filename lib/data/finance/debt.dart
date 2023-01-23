import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:money_manager/types/finance.dart';

import 'package:money_manager/data/finance/balance.dart';

class DebtModel extends Model with ChangeNotifier {
  final BuildContext context;
  final List<Move> _items = [];
  @override
  List<Move> get items => _items;
  int get total => items
      .map(((e) => e.balance))
      .fold<int>(0, (previousValue, element) => previousValue + element);

  @override
  void add(Move item) {
    _items.add(item);
    notifyListeners();
  }

  void clearUnpaid(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clear(int index) {
    Provider.of<BalanceModel>(context, listen: false).add(_items[index]);
    _items.removeAt(index);
    notifyListeners();
  }

  DebtModel({required initialItems, required this.context}) {
    for (var item in initialItems) {
      _items.add(item);
    }
  }
}
