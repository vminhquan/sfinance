class TransactionModel {
  int? id;
  String title;
  double amount;
  String date;
  String type; // 'Thu nhập' hoặc 'Chi tiêu'

  TransactionModel({this.id, required this.title, required this.amount, required this.date, required this.type});

  // Chuyển Map từ DB sang Model
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      date: map['date'],
      type: map['type'],
    );
  }

  // Chuyển Model thành Map để lưu vào DB
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'amount': amount, 'date': date, 'type': type};
  }
}