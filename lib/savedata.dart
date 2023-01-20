import 'dart:convert';
import 'package:money_manager/finance.dart';
import 'package:money_manager/savedata/native.dart'
    if (dart.library.html) 'package:money_manager/savedata/web.dart';

abstract class SaveData {
  static Obj defaultSaveData =
      ConfigModel(financialMoves: [], borrowMoves: [], debtMoves: []).toObj();
  static String defaultSaveDataString = jsonEncode(defaultSaveData);
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

SaveData saveData = PlatformSaveData();
