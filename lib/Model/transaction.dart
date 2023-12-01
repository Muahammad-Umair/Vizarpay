class Transaction {
  int id;
  String userId;
  String amount;
  String transactionId;
  String type;
  String transactionStatus;
  String createDate;
  String updateDate;
  String isChecked;

  Transaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.transactionId,
    required this.type,
    required this.transactionStatus,
    required this.createDate,
    required this.updateDate,
    required this.isChecked,
  });

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] ?? -1,
      userId: map['user_id'] ?? '',
      amount: map['amount'] ?? "",
      transactionId: map['client_txn_id'] ?? "",
      type: map['via'] ?? '',
      transactionStatus: map['transaction_status'] ?? "",
      createDate: map['created_at'] ?? "",
      updateDate: map['updated_at'] ?? '',
      isChecked: map['is_checked'] ?? "",
    );
  }
}

class AllTransaction {
  int id;
  String balance;
  String descriptions;
  String credit;
  String debit;
  String createDate;
  String updateDate;

  AllTransaction({
    required this.id,
    required this.balance,
    required this.credit,
    required this.debit,
    required this.descriptions,
    required this.createDate,
    required this.updateDate,
  });

  factory AllTransaction.fromMap(Map<String, dynamic> map) {
    return AllTransaction(
      id: map['id'] ?? -1,
      balance: map['balance'] ?? '',
      credit: map['credit'] ?? '',
      debit: map['debit'] ?? "",
      descriptions: map['model'] ?? '',
      createDate: map['created_at'],
      updateDate: map['updated_at'],
    );
  }
}

class HistoryM {
  String amount;
  String transaction;
  String mode;
  String transactionStatus;
  String createDate;
  String updateDate;

  HistoryM({
    required this.amount,
    required this.transaction,
    required this.mode,
    required this.transactionStatus,
    required this.createDate,
    required this.updateDate,
  });

  // Convert DepositHistoryM object to a map
  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'transaction': transaction,
      'mode': mode,
      'transactionStatus': transactionStatus,
      'createDate': createDate,
      'updateDate': updateDate,
    };
  }

  // Create a DepositHistoryM object from a map
  factory HistoryM.fromMap(Map<String, dynamic> map) {
    return HistoryM(
      amount: map['amount'] ?? '',
      transaction: map['transection'] ?? '',
      mode: map['mode'] ?? '',
      transactionStatus: map['status'] ?? '',
      createDate: map['created_at'] ?? '',
      updateDate: map['created_at'] ?? '',
    );
  }
}
