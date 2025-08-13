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

  void _addNewTransaction(String txTitle, double txAmount, bool isIncome) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      isIncome: isIncome,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  double get totalIncome {
    double total = 0;
    for (var tx in _userTransactions) {
      if (tx.isIncome) total += tx.amount;
    }
    return total;
  }

  double get totalExpense {
    double total = 0;
    for (var tx in _userTransactions) {
      if (!tx.isIncome) total += tx.amount;
    }
    return total;
  }

  double get balance => _startingBalance + totalIncome - totalExpense;

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(addTx: _addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แอปรายรับรายจ่าย'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 5,
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text('ยอดเงินคงเหลือ'),
                      Text(
                        '฿ ${balance.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('รายรับ'),
                      Text(
                        '฿${totalIncome.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('รายจ่าย'),
                      Text(
                        '฿${totalExpense.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TransactionList(transactions: _userTransactions),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
