import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:financial_management/finance.dart';

abstract class SaveData {
  Future<void> write(ConfigModel settings);
  Future<ConfigModel> read();
}

class ConfigModel {
  final List<Move> financialMoves;
  final List<Move> debtMoves;
  final List<Move> borrowMoves;
  ConfigModel(
      {required this.financialMoves,
      required this.debtMoves,
      required this.borrowMoves});
}

class FileSaveData extends SaveData {
  Future<String> getPathToSaveData() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return join(directory.path, "finances.json");
  }

  @override
  Future<void> write(ConfigModel settings) async {
    File file = File(await getPathToSaveData());
    file.writeAsString(jsonEncode(settings));
  }

  @override
  Future<ConfigModel> read() async {
    File file = File(await getPathToSaveData());
    return jsonDecode(await file.readAsString());
  }
}

SaveData saveData = FileSaveData();
