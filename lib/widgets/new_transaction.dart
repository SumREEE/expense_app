import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function(String, double, bool, String) addTx;

  const NewTransaction({super.key, required this.addTx});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _amountController = TextEditingController();
  final _customCategoryController = TextEditingController();
  bool _isIncome = true;

  final List<String> incomeCategories = [
    'เงินเดือน',
    'งานเสริม',
    'โบนัส',
    'เงินปันผล',
    'ดอกเบี้ย',
    'อื่นๆ',
  ];

  final List<String> expenseCategories = [
    'อาหาร',
    'ค่าเดินทาง',
    'ช้อปปิง',
    'เงินออม',
    'ค่าหมอ',
    'ฟิตเนส',
    'อื่นๆ',
  ];

  String _selectedCategory = 'เงินเดือน';

  void _submitData() {
    final enteredAmount = double.tryParse(_amountController.text) ?? 0;
    String category = _selectedCategory;

    if (_selectedCategory == 'อื่นๆ') {
      if (_customCategoryController.text.isEmpty) return;
      category = _customCategoryController.text;
    }

    if (enteredAmount <= 0) return;

    widget.addTx(
      category,
      enteredAmount,
      _isIncome,
      category,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    List<String> currentCategories =
        _isIncome ? incomeCategories : expenseCategories;

    if (!currentCategories.contains(_selectedCategory)) {
      _selectedCategory = currentCategories[0];
    }

    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ---------- Switch ----------
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
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
                        _selectedCategory =
                            _isIncome ? incomeCategories[0] : expenseCategories[0];
                        _customCategoryController.clear();
                      });
                    },
                  ),
                  const Text('รายจ่าย'),
                ],
              ),
            ),

            // ---------- จำนวนเงิน ----------
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'จำนวนเงิน',
                  prefixText: '฿ ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(80),
                  ),
                ),
                controller: _amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),


            // ---------- Dropdown ----------
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'ประเภท',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                value: _selectedCategory,
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                    if (_selectedCategory != 'อื่นๆ') {
                      _customCategoryController.clear();
                    }
                  });
                },
                items: currentCategories
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),

            // ---------- ถ้าเลือก "อื่นๆ" ให้แสดง TextField ----------
            if (_selectedCategory == 'อื่นๆ')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'ระบุประเภทเอง',
                    border: OutlineInputBorder(),
                  ),
                  controller: _customCategoryController,
                ),
              ),

            const SizedBox(height: 20),

            // ---------- ปุ่มเพิ่มรายการ แบบสี่เหลี่ยม + ไอคอน ----------
            SizedBox(
              height: 55,
              width: double.infinity, // เต็มความกว้าง
              child: ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 46, 191, 156), // สีเหมือน FAB
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(150), // สี่เหลี่ยมโค้งมน
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'เพิ่มรายการ',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
