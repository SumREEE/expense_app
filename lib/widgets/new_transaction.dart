import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function(String, double, bool) addTx;

  const NewTransaction({super.key, required this.addTx});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isIncome = true;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text) ?? 0;

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, _isIncome);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'ชื่อรายการ'),
              controller: _titleController,
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: 'จำนวนเงิน', prefixText: '฿ '),
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('รายรับ'),
                Switch(
                  value: _isIncome,
                  activeColor: Colors.green,
                  activeTrackColor: Colors.green[200],
                  inactiveThumbColor: Colors.red,
                  inactiveTrackColor: Colors.red[200],
                  onChanged: (val) {
                    setState(() {
                      _isIncome = val;
                    });
                  },
                ),
                const Text('รายจ่าย'),
              ],
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text('เพิ่มรายการ'),
            ),
          ],
        ),
      ),
    );
  }
}
