// TODO: use local currency instead and configuration to change the currency.
const String currency = '€';

class Move {
  final String descriptor;
  final int balance;
  const Move({required this.descriptor, required this.balance});
}
