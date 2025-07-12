import 'package:flutter/material.dart';

class AttrecordScreen extends StatefulWidget {
  const AttrecordScreen({super.key});

  @override
  State<AttrecordScreen> createState() => _AttrecordScreenState();
}

class _AttrecordScreenState extends State<AttrecordScreen> {
  // Dummy data
  final List<Map<String, String>> allAttendanceData = [
    {
      'date': 'Fri, 27 Jun 2025',
      'month': 'June',
      'year': '2025',
      'checkIn': '07.30',
      'checkOut': '18.00',
    },
    {
      'date': 'Thu, 26 Jun 2025',
      'month': 'June',
      'year': '2025',
      'checkIn': '07.45',
      'checkOut': '18.00',
    },
    {
      'date': 'Mon, 22 Jul 2024',
      'month': 'July',
      'year': '2024',
      'checkIn': '07.35',
      'checkOut': '17.55',
    },
  ];

  String? selectedMonth;
  String? selectedYear;

  @override
  Widget build(BuildContext context) {
    // Filtered data
    List<Map<String, String>> filteredData = allAttendanceData.where((item) {
      bool matchMonth = selectedMonth == null || item['month'] == selectedMonth;
      bool matchYear = selectedYear == null || item['year'] == selectedYear;
      return matchMonth && matchYear;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF032D60),
        title: const Text(
          "Attendance Record",
          style: TextStyle(color: Color(0xFFF2F4E8), fontSize: 18),
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Filter dropdowns
              Row(
                children: [
                  const Icon(Icons.filter_list),
                  const SizedBox(width: 8),
                  const Text("Filters",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  // Month Dropdown
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedMonth,
                      hint: const Text('Month'),
                      decoration: _dropdownDecoration(),
                      items: [
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
                        'December',
                      ]
                          .map((month) => DropdownMenuItem(
                              value: month, child: Text(month)))
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selectedMonth = value),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Year Dropdown
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedYear,
                      hint: const Text('Year'),
                      decoration: _dropdownDecoration(),
                      items: ['2024', '2025']
                          .map((year) =>
                              DropdownMenuItem(value: year, child: Text(year)))
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selectedYear = value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // List
              Expanded(
                child: filteredData.isEmpty
                    ? const Center(child: Text("No records found."))
                    : ListView.builder(
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          final item = filteredData[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _buildRecordItem(
                              date: item['date']!,
                              checkIn: item['checkIn']!,
                              checkOut: item['checkOut']!,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _buildRecordItem({
    required String date,
    required String checkIn,
    required String checkOut,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_upward, color: Colors.blue, size: 20),
                  const SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Check In"),
                      Text(checkIn, style: const TextStyle(color: Colors.blue)),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.arrow_downward, color: Colors.red, size: 20),
                  const SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Check Out"),
                      Text(checkOut,
                          style: const TextStyle(color: Colors.blue)),
                    ],
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
