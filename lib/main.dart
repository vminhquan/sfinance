import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'providers/transaction_provider.dart';
import 'providers/theme_provider.dart';

import 'providers/pin_provider.dart';
import 'screens/pin_screen.dart';

void main() async {
  // 1. Đảm bảo Flutter đã sẵn sàng kết nối với macOS trước khi gọi Database
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Khởi tạo cầu nối Database cho macOS
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // 3. Khởi chạy App
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider()..loadTransactions()),
        ChangeNotifierProvider(create: (_) => PinProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'SFINANCE - QUẢN LÍ TÀI CHÍNH CÁ NHÂN',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const PinScreen(),
    );
  }
}