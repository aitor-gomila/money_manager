import 'package:flutter/material.dart';

import 'package:money_manager/widgets/data/future_save_data_read.dart';
import 'package:money_manager/widgets/data/main_state_providers.dart';

import 'package:money_manager/widgets/navigation/main_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureSaveDataRead(
        builder: (configModel) => MainStateProviders(
            configModel: configModel,
            builder: (context, _) => MaterialApp(
                  title: 'Money manager',
                  theme: ThemeData(
                      primarySwatch: Colors.green, useMaterial3: true),
                  home: const MyHomePage(),
                )));
  }
}
