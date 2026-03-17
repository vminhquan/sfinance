import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pin_provider.dart';
import 'home_screen.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String _inputPin = "";

  void _handleKeyPress(String value) {
    if (_inputPin.length < 4) {
      setState(() {
        _inputPin += value;
      });
    }

    if (_inputPin.length == 4) {
      final pinProvider = Provider.of<PinProvider>(context, listen: false);
      
      // Nếu chưa có PIN thì cài làm PIN mới, nếu có rồi thì kiểm tra
      if (pinProvider.savedPin == null) {
        pinProvider.setPin(_inputPin);
        _navigateToHome();
      } else if (_inputPin == pinProvider.savedPin) {
        _navigateToHome();
      } else {
        // Sai mã PIN
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mã PIN không đúng, vui lòng thử lại!'), backgroundColor: Colors.red),
        );
        setState(() {
          _inputPin = "";
        });
      }
    }
  }

  void _navigateToHome() {
    Provider.of<PinProvider>(context, listen: false).unlock();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pinProvider = Provider.of<PinProvider>(context);
    bool isFirstTime = pinProvider.savedPin == null;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            Text(
              isFirstTime ? "Thiết lập mã PIN 4 số" : "Nhập mã PIN để tiếp tục",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            
            // Hiển thị 4 dấu chấm PIN
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 20, height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index < _inputPin.length ? Colors.blue : Colors.grey[300],
                ),
              )),
            ),
            
            const SizedBox(height: 50),
            
            // Bàn phím số 
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1.2, crossAxisSpacing: 20, mainAxisSpacing: 20,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  if (index == 9) return const SizedBox(); // Ô trống
                  if (index == 10) return _buildKey("0");
                  if (index == 11) return IconButton(
                    onPressed: () => setState(() => _inputPin = ""),
                    icon: const Icon(Icons.backspace_outlined),
                  );
                  return _buildKey("${index + 1}");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKey(String text) {
    return InkWell(
      onTap: () => _handleKeyPress(text),
      borderRadius: BorderRadius.circular(50),
      child: Center(
        child: Text(text, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      ),
    );
  }
}