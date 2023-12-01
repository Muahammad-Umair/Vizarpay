class Dth {
  int id;
  String txId;
  String type;
  String model;
  String number;
  String amount;
  String status;

  Dth({
    required this.id,
    required this.txId,
    required this.type,
    required this.model,
    required this.number,
    required this.amount,
    required this.status,
  });

  factory Dth.fromMap(Map<String, dynamic> map) {
    return Dth(
      id: map['id'] as int,
      txId: map['client_txn_id'] ?? "",
      type: map['via'] ?? "",
      model: map['model'] ?? "",
      number: map['phone_number'] ?? "",
      amount: map['amount'] ?? "",
      status: map['status_message'] ?? '',
    );
  }
}
