class FinancialMove {
  final String descriptor;
  final int balance;
  const FinancialMove({required this.descriptor, required this.balance});
}

int calculateTotalFinancialMoves(List<FinancialMove> financialMovesList) {
  int balance = 0;
  for (var financialMove in financialMovesList) {
    balance += financialMove.balance;
  }
  return balance;
}
