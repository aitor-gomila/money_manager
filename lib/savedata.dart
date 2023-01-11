import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';
import 'package:financial_management/finance.dart';

abstract class ConfigModel {
  List<Move> financialMoves;
  List<Move> debtMove;
  List<Move> borrowMoves;
  ConfigModel(
      {required this.financialMoves,
      required this.debtMove,
      required this.borrowMoves});
}

abstract class SaveData {
  Future<ConfigModel> read();
  void write(ConfigModel saveData);
}

class FileSaveData extends SaveData {
  final String saveDataPath = "";

  @override
  Future<ConfigModel> read() async {
    File file = File(saveDataPath);
    return jsonDecode(await file.readAsString());
  }

  @override
  void write(ConfigModel saveData) {
    File(saveDataPath).writeAsString(jsonEncode(saveData));
  }

  FileSaveData();
}

class WebStorageSaveData extends SaveData {
  @override
  Future<ConfigModel> read() => jsonDecode(html.window.localStorage['config']!);
  @override
  void write(ConfigModel saveData) {
    html.window.localStorage['config'] = jsonEncode(saveData);
  }
}
/*
class GoogleDriveSaveData extends SaveData {
  @override
  Future<ConfigModel> read() {};
  @override
  void write(ConfigModel saveData) {};
}
*/