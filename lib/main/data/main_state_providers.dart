import 'package:flutter/material.dart';
import 'package:money_manager/savedata/types.dart';
import 'package:provider/provider.dart';

import 'package:money_manager/finance/data/balance.dart';
import 'package:money_manager/finance/data/debt.dart';
import 'package:money_manager/finance/data/borrow.dart';

class MainStateProviders extends StatelessWidget {
  const MainStateProviders(
      {super.key, required this.builder, required this.configModel});

  final ConfigModel configModel;
  final Widget Function(BuildContext, Widget?) builder;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<BalanceModel>(
          create: (context) => BalanceModel(
              context: context, initialItems: configModel.balanceMoves)),
      ChangeNotifierProvider<DebtModel>(
          create: (context) =>
              DebtModel(context: context, initialItems: configModel.debtMoves)),
      ChangeNotifierProvider<BorrowModel>(
          create: (context) => BorrowModel(
              context: context, initialItems: configModel.borrowMoves)),
    ], builder: builder);
  }
}
