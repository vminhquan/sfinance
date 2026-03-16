import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/transaction_model.dart';
import '../providers/transaction_provider.dart';
import 'add_edit_screen.dart';

class DetailScreen extends StatelessWidget {
  final TransactionModel transaction;

  const DetailScreen({super.key, required this.transaction});

  // HÀM BẮT BUỘC: Hiển thị hộp thoại xác nhận trước khi xóa
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận xóa', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Bạn có chắc chắn muốn xóa không?'), // Đúng y nguyên câu lệnh yêu cầu của đề bài
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(), // Đóng hộp thoại
            child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              // Gọi hàm xóa từ Provider
              Provider.of<TransactionProvider>(context, listen: false).deleteTransaction(transaction.id!);
              Navigator.of(ctx).pop(); // Đóng hộp thoại
              Navigator.of(context).pop(); // Quay về màn hình danh sách
              
              // Hiện thông báo (SnackBar) báo xóa thành công
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã xóa giao dịch thành công!')),
              );
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    final isIncome = transaction.type == 'Thu nhập';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết giao dịch'),
        actions: [
          // Nút Sửa (Điều hướng sang AddEditScreen với dữ liệu có sẵn)
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditScreen(transaction: transaction),
                ),
              );
            },
          ),
          // Nút Xóa
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _showDeleteDialog(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hiển thị Loại giao dịch bằng Icon to
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: isIncome ? Colors.green[100] : Colors.red[100],
                    child: Icon(
                      isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                      color: isIncome ? Colors.green : Colors.red,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    transaction.type,
                    style: TextStyle(fontSize: 20, color: isIncome ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(height: 40, thickness: 2),
            
            // Các trường thông tin chi tiết
            ListTile(
              leading: const Icon(Icons.title),
              title: const Text('Tên giao dịch', style: TextStyle(color: Colors.grey)),
              subtitle: Text(transaction.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Số tiền', style: TextStyle(color: Colors.grey)),
              subtitle: Text(currencyFormat.format(transaction.amount), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Ngày thực hiện', style: TextStyle(color: Colors.grey)),
              subtitle: Text(transaction.date, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}