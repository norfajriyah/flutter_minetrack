import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class PayrollScreen extends StatefulWidget {
  const PayrollScreen({super.key});

  @override
  State<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  DateTime selectedDate = DateTime.now();

  final Map<int, Map<int, Map<String, dynamic>>> payrollData = {
    2025: {
      7: {
        "total": "Rp 9,000,000",
        "deduction": "Rp 500,000",
        "takeHome": "Rp 8,500,000",
        "details": {
          "Base Salary": "Rp 6,000,000",
          "Shift Allowance": "Rp 1,500,000",
          "Overtime": "Rp 1,000,000",
          "Attendance Bonus": "Rp 500,000",
        }
      },
      6: {
        "total": "Rp 8,500,000",
        "deduction": "Rp 700,000",
        "takeHome": "Rp 7,800,000",
        "details": {
          "Base Salary": "Rp 6,000,000",
          "Shift Allowance": "Rp 1,200,000",
          "Overtime": "Rp 1,000,000",
          "Attendance Bonus": "Rp 300,000",
        }
      }
    },
    2024: {
      12: {
        "total": "Rp 7,800,000",
        "deduction": "Rp 300,000",
        "takeHome": "Rp 7,500,000",
        "details": {
          "Base Salary": "Rp 6,000,000",
          "Shift Allowance": "Rp 1,000,000",
          "Overtime": "Rp 500,000",
          "Attendance Bonus": "Rp 300,000",
        }
      }
    }
  };

  @override
  Widget build(BuildContext context) {
    int year = selectedDate.year;
    int month = selectedDate.month;
    final data = payrollData[year]?[month];

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF032D60),
        title: const Text("Payroll",
            style: TextStyle(color: Colors.white, fontSize: 18)),
        leading: BackButton(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month, color: Colors.white),
            onPressed: _pickMonth,
          )
        ],
      ),
      body: data == null
          ? const Center(child: Text("No payroll data available."))
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "${_getMonthName(month)} $year",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildRow("Total Earnings", data["total"]),
                  _buildRow("Deductions", data["deduction"]),
                  _buildRow("Take Home Pay", data["takeHome"],
                      isHighlight: true),
                  const SizedBox(height: 20),
                  const Text("Earning Details",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  for (var entry
                      in (data["details"] as Map<String, String>).entries)
                    _buildRow(entry.key, entry.value),
                  const Spacer(),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF57C00),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Payroll slip downloaded successfully."),
                        ),
                      );
                    },
                    icon: const Icon(Icons.download, color: Colors.white),
                    label: const Text(
                      "Download Pay Slip",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _pickMonth() async {
    final picked = await showMonthPicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024, 1),
      lastDate: DateTime(2025, 12),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget _buildRow(String label, String amount, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: isHighlight
                  ? const TextStyle(fontWeight: FontWeight.bold)
                  : const TextStyle()),
          Text(amount,
              style: isHighlight
                  ? TextStyle(
                      color: Colors.green[800], fontWeight: FontWeight.bold)
                  : const TextStyle()),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month];
  }
}
