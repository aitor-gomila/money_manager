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

typedef Obj = Map<String, dynamic>;

class ConfigModel {
  final List<Move> financialMoves;
  final List<Move> debtMoves;
  final List<Move> borrowMoves;

  static Obj _moveToObj(Move move) {
    return {"descriptor": move.descriptor, "balance": move.balance};
  }

  static Move _objToMove(Obj obj) {
    return Move(descriptor: obj['descriptor'], balance: obj['balance']);
  }

  Obj toObj() => {
        'financialMoves':
            financialMoves.map<Obj>((e) => _moveToObj(e)).toList(),
        'debtMoves': debtMoves.map<Obj>((e) => _moveToObj(e)).toList(),
        'borrowMoves': borrowMoves.map<Obj>((e) => _moveToObj(e)).toList()
      };

  static ConfigModel fromObj(Obj obj) => ConfigModel(
      financialMoves:
          obj['financialMoves'].map<Move>((e) => _objToMove(e)).toList(),
      debtMoves: obj['debtMoves'].map<Move>((e) => _objToMove(e)).toList(),
      borrowMoves: obj['borrowMoves'].map<Move>((e) => _objToMove(e)).toList());

  ConfigModel(
      {required this.financialMoves,
      required this.debtMoves,
      required this.borrowMoves});
}

class FileSaveData extends SaveData {
  static Obj defaultSaveData =
      ConfigModel(financialMoves: [], borrowMoves: [], debtMoves: []).toObj();
  static String defaultSaveDataString = jsonEncode(defaultSaveData);
  Future<String> getPathToSaveData() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return join(directory.path, "finances.json");
  }

  Future<void> nullCheckSaveFile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "finances.json");
    File file = File(path);
    if (!await file.exists()) {
      await file.writeAsString(defaultSaveDataString);
      return;
    }
    try {
      jsonDecode(await file.readAsString());
    } catch (e) {
      await file.writeAsString(defaultSaveDataString);
    }
  }

  @override
  Future<void> write(ConfigModel settings) async {
    File file = File(await getPathToSaveData());
    await file.writeAsString(jsonEncode(settings.toObj()));
  }

  @override
  Future<ConfigModel> read() async {
    File file = File(await getPathToSaveData());
    String plainText = await file.readAsString();
    await nullCheckSaveFile();
    return ConfigModel.fromObj(jsonDecode(plainText));
  }
}

SaveData saveData = FileSaveData();
