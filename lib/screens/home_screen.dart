import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../widgets/new_transaction.dart';
import '../widgets/transaction_list.dart';

class HomeScreen extends StatefulWidget {
  final double startingBalance;
  const HomeScreen({super.key, required this.startingBalance});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Transaction> _userTransactions = [];

  double get _startingBalance => widget.startingBalance;

  void _addNewTransaction(String txTitle, double txAmount, bool isIncome, String category) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      isIncome: isIncome,
      category: category,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  double get totalIncome {
    return _userTransactions
        .where((tx) => tx.isIncome)
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

  double get totalExpense {
    return _userTransactions
        .where((tx) => !tx.isIncome)
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

  double get balance => _startingBalance + totalIncome - totalExpense;

 void _startAddNewTransaction(BuildContext ctx) {
  showModalBottomSheet(
    context: ctx,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) {
      return Container(
        height: MediaQuery.of(ctx).size.height * 0.45, 
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: NewTransaction(addTx: _addNewTransaction),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 39, 60),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 51, 39, 60),
        title: const Text('EXPENSE APP', style: TextStyle(
          color: Color(0xFFF36950),
          fontWeight: FontWeight.bold)
          ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ---------- Card สรุปยอด ----------
          Card(
            color: const Color.fromARGB(255, 46, 191, 156),
            elevation: 8,
            margin: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // ยอดเงินคงเหลือ
                  Column(
                    children: [
                      const Text('ยอดเงินคงเหลือ', style: TextStyle(color: Colors.white, fontSize: 17)),
                      const SizedBox(height: 5),
                      Text(
                        '${balance.toStringAsFixed(0)} บาท',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  // รายรับ
                  Column(
                    children: [
                      const Text('รายรับ', style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 17,
                        )),
                      const SizedBox(height: 5),
                      Text(
                        '${totalIncome.toStringAsFixed(0)} บาท',
                        style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  // รายจ่าย
                  Column(
                    children: [
                      const Text('รายจ่าย', style: TextStyle(color: Colors.redAccent, fontSize: 17)),
                      const SizedBox(height: 5),
                      Text(
                        '${totalExpense.toStringAsFixed(0)} บาท',
                        style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // ---------- List รายการ ----------
          Expanded(
            child: TransactionList(transactions: _userTransactions),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          backgroundColor: const Color.fromARGB(255, 46, 191, 156),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: const Icon(Icons.add, color: Colors.white, size: 32),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
