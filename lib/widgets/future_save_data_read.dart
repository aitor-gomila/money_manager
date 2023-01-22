import 'package:flutter/material.dart';

import 'package:money_manager/types/savedata.dart';
import 'package:money_manager/savedata.dart';

class FutureSaveDataRead extends StatelessWidget {
  FutureSaveDataRead({super.key, required this.builder});

  Widget Function(ConfigModel) builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ConfigModel>(
        future: saveData.read(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // TODO: i'm pretty sure this situation can't happen but better code is needed
            // this one will overwrite all data the user has if something weird happens
            return builder(snapshot.data ?? emptyConfigModel());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
