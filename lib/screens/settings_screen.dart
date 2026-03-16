import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy trạng thái theme hiện tại
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Giao diện & Hiển thị',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 10),
          
          // Switch chuyển đổi Dark Mode
          Card(
            elevation: 2,
            child: SwitchListTile(
              title: const Text('Chế độ Tối'),
              subtitle: const Text('Thay đổi giao diện sáng/tối'),
              secondary: Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
              value: themeProvider.isDarkMode,
              onChanged: (bool value) {
                // Gọi hàm lưu trạng thái xuống thiết bị
                themeProvider.toggleTheme(value);
              },
            ),
          ),

          const SizedBox(height: 20),
          
          // Nút thông tin ứng dụng 
          Card(
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Thông tin ứng dụng'),
              subtitle: const Text('SFinance v1.0'),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'SFinance',
                  applicationVersion: '1.0.0',
                  applicationIcon: const Icon(Icons.account_balance_wallet, size: 50),
                  children: const [
                    Text('Ứng dụng quản lý tài chính cá nhân.'),
                    Text('Sử dụng: Flutter, Provider, SQLite, SharedPreferences.'),
                  ]
                );
              },
            ),
          )
        ],
      ),
    );
  }
}