import 'package:flutter/material.dart';

import 'package:money_manager/savedata/types.dart';
import 'package:money_manager/savedata/savedata.dart';

class FutureSaveDataRead extends StatelessWidget {
  FutureSaveDataRead({super.key, required this.builder});

  Widget Function(ConfigModel) builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ConfigModel>(
        future: saveData.read(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return builder(snapshot.data!);
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
