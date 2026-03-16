import 'package:flutter/material.dart';
import '../data/database_helper.dart';
import '../models/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];
  bool _isLoading = false;

  List<TransactionModel> get transactions => _transactions;
  bool get isLoading => _isLoading;

  // Tính Tổng Thu Nhập
  double get totalIncome {
    return _transactions
        .where((txn) => txn.type == 'Thu nhập')
        .fold(0.0, (sum, txn) => sum + txn.amount);
  }

  // Tính Tổng Chi Tiêu
  double get totalExpense {
    return _transactions
        .where((txn) => txn.type == 'Chi tiêu')
        .fold(0.0, (sum, txn) => sum + txn.amount);
  }

  // Tính Tổng Số Dư (Thu - Chi)
  double get totalBalance {
    return totalIncome - totalExpense;
  }

  Future<void> loadTransactions() async {
    _isLoading = true;
    notifyListeners();
    
    _transactions = await DatabaseHelper.instance.fetchAll();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel txn) async {
    await DatabaseHelper.instance.insert(txn);
    await loadTransactions();
  }

  Future<void> updateTransaction(TransactionModel txn) async {
    await DatabaseHelper.instance.update(txn);
    await loadTransactions();
  }

  Future<void> deleteTransaction(int id) async {
    await DatabaseHelper.instance.delete(id);
    await loadTransactions();
  }
}