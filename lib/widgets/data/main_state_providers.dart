import 'package:flutter/material.dart';
import 'package:money_manager/types/savedata.dart';
import 'package:provider/provider.dart';

import 'package:money_manager/data/finance.dart';

class MainStateProviders extends StatelessWidget {
  const MainStateProviders(
      {super.key, required this.builder, required this.configModel});

  final ConfigModel configModel;
  final Widget Function(BuildContext, Widget?) builder;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<FinancialModel>(
          create: (context) => FinancialModel(
              context: context, initialItems: configModel.financialMoves)),
      ChangeNotifierProvider<DebtModel>(
          create: (context) =>
              DebtModel(context: context, initialItems: configModel.debtMoves)),
      ChangeNotifierProvider<BorrowModel>(
          create: (context) => BorrowModel(
              context: context, initialItems: configModel.borrowMoves)),
    ], builder: builder);
  }
}
