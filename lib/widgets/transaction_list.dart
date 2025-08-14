import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###'); // คั่นหลักพัน

    return transactions.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.receipt_long, size: 80, color: Colors.grey[400]),
                const SizedBox(height: 20),
                const Text(
                  'ยังไม่มีรายการ',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tx = transactions[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  title: Text(
                    tx.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  subtitle: Text(
                    '${DateFormat('dd/MM/yyyy HH:mm').format(tx.date)}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    '${formatter.format(tx.amount)} บาท',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: tx.isIncome ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              );
            },
          );
  }
}
