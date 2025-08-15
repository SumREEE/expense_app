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
      backgroundColor: const Color.fromARGB(255, 51, 39, 60),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'EXPENSE APP',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF36950),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // ---------- TextField ใน Card ----------
              SizedBox(
                width: 400,
                child: Card(
                  color: Colors.white,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(150)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      style: const TextStyle(
                          color: Color.fromARGB(255, 51, 39, 60),
                          fontSize: 20,
                          ),
                      decoration: InputDecoration(
                        labelText: 'ยอดเงินเริ่มต้น',
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 51, 39, 60)),
                        prefixText: '฿ ',
                        prefixStyle: const TextStyle(
                            color: Color.fromARGB(255, 51, 39, 60),
                            fontSize: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(150),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 51, 39, 60),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(150),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 90, 90, 90),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(150),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 90, 90, 90),
                            width: 2,
                          ),
                        ),
                      ),
                      controller: _balanceController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ---------- ปุ่มเริ่มใช้งาน ----------
              SizedBox(
                width: 400, 
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: _submitBalance,
                  label: const Text(
                    'เริ่มใช้งานแอพ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 46, 191, 156),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(150),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
