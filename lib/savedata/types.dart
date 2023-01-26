import 'dart:convert';
import 'package:money_manager/finance/data/types.dart';

abstract class SaveData {
  static Obj defaultSaveData =
      ConfigModel(balanceMoves: [], borrowMoves: [], debtMoves: []).toObj();
  static String defaultSaveDataString = jsonEncode(defaultSaveData);
  Future<void> write(ConfigModel settings);
  Future<ConfigModel> read();
}

typedef Obj = Map<String, dynamic>;

class ConfigModel {
  final List<Move> balanceMoves;
  final List<Move> debtMoves;
  final List<Move> borrowMoves;

  static Obj _moveToObj(Move move) {
    return {"descriptor": move.descriptor, "balance": move.balance};
  }

  static Move _objToMove(Obj obj) {
    return Move(descriptor: obj['descriptor'], balance: obj['balance']);
  }

  Obj toObj() => {
        'balanceMoves': balanceMoves.map<Obj>((e) => _moveToObj(e)).toList(),
        'debtMoves': debtMoves.map<Obj>((e) => _moveToObj(e)).toList(),
        'borrowMoves': borrowMoves.map<Obj>((e) => _moveToObj(e)).toList()
      };

  static ConfigModel fromObj(Obj obj) => ConfigModel(
      balanceMoves:
          obj['balanceMoves'].map<Move>((e) => _objToMove(e)).toList(),
      debtMoves: obj['debtMoves'].map<Move>((e) => _objToMove(e)).toList(),
      borrowMoves: obj['borrowMoves'].map<Move>((e) => _objToMove(e)).toList());

  ConfigModel(
      {required this.balanceMoves,
      required this.debtMoves,
      required this.borrowMoves});
}
