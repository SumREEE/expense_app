import 'package:flutter/material.dart';
import 'home_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _balanceController = TextEditingController();

  void _submitBalance() {
    final enteredBalance = double.tryParse(_balanceController.text) ?? 0;
    if (enteredBalance <= 0) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => HomeScreen(startingBalance: enteredBalance),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('กรอกยอดเงินเริ่มต้น')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'ยอดเงินเริ่มต้น',
                prefixText: '฿',
              ),
              controller: _balanceController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitBalance,
              child: const Text('เริ่มใช้งานแอพ'),
            ),
          ],
        ),
      ),
    );
  }
}
