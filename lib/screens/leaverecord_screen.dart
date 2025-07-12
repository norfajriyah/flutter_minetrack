import 'package:flutter/material.dart';

class LeaverecordScreen extends StatefulWidget {
  const LeaverecordScreen({super.key});

  @override
  State<LeaverecordScreen> createState() => _LeaverecordScreenState();
}

class _LeaverecordScreenState extends State<LeaverecordScreen> {
  String? selectedStatus;
  int? selectedMonth;
  int? selectedYear;

  final List<Map<String, dynamic>> allLeaves = [
    {
      "type": "Annual Leave",
      "dateRange": "30 Oct - 10 Nov 2024",
      "status": "Approved",
      "statusColor": const Color(0xFF002B5B),
      "requestDate": DateTime(2024, 10, 15)
    },
    {
      "type": "Sick Leave",
      "dateRange": "15 Nov - 18 Nov 2024",
      "status": "Rejected",
      "statusColor": Colors.redAccent,
      "requestDate": DateTime(2024, 11, 13)
    },
    {
      "type": "Sick Leave",
      "dateRange": "25 Nov - 28 Nov 2024",
      "status": "Approved",
      "statusColor": const Color(0xFF002B5B),
      "requestDate": DateTime(2024, 11, 23)
    },
    {
      "type": "Maternity Leave",
      "dateRange": "20 Feb - 20 Apr 2025",
      "status": "Approved",
      "statusColor": const Color(0xFF002B5B),
      "requestDate": DateTime(2025, 1, 15)
    },
    {
      "type": "Sick Leave",
      "dateRange": "01 Jul - 03 Jul 2025",
      "status": "Awaiting",
      "statusColor": const Color.fromARGB(255, 252, 186, 54),
      "requestDate": DateTime(2025, 6, 31)
    },
  ];

  List<Map<String, dynamic>> get filteredLeaves {
    return allLeaves.where((leave) {
      final requestDate = leave['requestDate'] as DateTime;
      final statusMatch =
          selectedStatus == null || leave['status'] == selectedStatus;
      final monthMatch =
          selectedMonth == null || requestDate.month == selectedMonth;
      final yearMatch =
          selectedYear == null || requestDate.year == selectedYear;
      return statusMatch && monthMatch && yearMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D3475),
        title: const Text(
          "Leave History",
          style: TextStyle(color: Color(0xFFF2F4E8), fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filteredLeaves.length,
              itemBuilder: (context, index) {
                final leave = filteredLeaves[index];
                return _buildLeaveCard(
                  type: leave['type'],
                  dateRange: leave['dateRange'],
                  status: leave['status'],
                  statusColor: leave['statusColor'],
                  dateRequest: leave['requestDate'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFFF2F4E8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.filter_alt),
          DropdownButton<String>(
            value: selectedStatus,
            hint: const Text("Status"),
            items: ['Approved', 'Rejected', 'Awaiting'].map((String value) {
              return DropdownMenuItem(value: value, child: Text(value));
            }).toList(),
            onChanged: (value) => setState(() => selectedStatus = value),
          ),
          DropdownButton<int>(
            value: selectedMonth,
            hint: const Text("Month"),
            items: List.generate(12, (i) => i + 1).map((int month) {
              return DropdownMenuItem(value: month, child: Text("$month"));
            }).toList(),
            onChanged: (value) => setState(() => selectedMonth = value),
          ),
          DropdownButton<int>(
            value: selectedYear,
            hint: const Text("Year"),
            items: [2024, 2025, 2026].map((int year) {
              return DropdownMenuItem(value: year, child: Text("$year"));
            }).toList(),
            onChanged: (value) => setState(() => selectedYear = value),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveCard({
    required String type,
    required String dateRange,
    required String status,
    required Color? statusColor,
    required DateTime dateRequest,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(type, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text("For: $dateRange", style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "${dateRequest.day} ${_monthName(dateRequest.month)} ${dateRequest.year}"),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: status == "Approved" ? Colors.white : Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month];
  }
}
