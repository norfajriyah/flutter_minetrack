import 'package:flutter/material.dart';
import 'package:flutter_minetrack/screens/leaverecord_screen.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  String? selectedLeaveType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4E8),
      appBar: AppBar(
          backgroundColor: const Color(0xFF032D60),
          title: const Text(
            "Request Leave",
            style: TextStyle(color: Color(0xFFF2F4E8), fontSize: 18),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _buildDropdownField("Leave Type"),
            const SizedBox(height: 16),
            _buildDateField("From", fromDateController),
            const SizedBox(height: 16),
            _buildDateField("To", toDateController),
            const SizedBox(height: 16),
            _buildReasonField(),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF57C00),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                // TODO: Add submit action
              },
              child: const Text("Submit",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 32),
            _buildLeaveHistoryHeader(),
            const SizedBox(height: 16),
            _buildLeaveCard(
              type: "Maternity Leave",
              date: "For: 20 Feb - 20 Apr 2025",
              status: "Approved",
              statusColor: const Color(0xFF032D60),
              dateRequest: "15 Jan 2025",
            ),
            const SizedBox(height: 12),
            _buildLeaveCard(
              type: "Sick Leave",
              date: "For: 31 Jun - 02 Jul 2025",
              status: "Awaiting",
              statusColor: const Color.fromARGB(255, 252, 186, 54),
              dateRequest: "31 Jun 2025",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(border: InputBorder.none),
        hint: Text(hint),
        value: selectedLeaveType,
        items: ["Sick", "Maternity", "Annual"].map((type) {
          return DropdownMenuItem(
            value: type,
            child: Text(type),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedLeaveType = value;
          });
        },
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        suffixIcon: const Icon(Icons.calendar_today),
        hintText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          setState(() {
            controller.text =
                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
          });
        }
      },
    );
  }

  Widget _buildReasonField() {
    return TextFormField(
      controller: reasonController,
      maxLines: 3,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: "Reason",
        prefixIcon: const Icon(Icons.checklist),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildLeaveHistoryHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Leave History",
            style: TextStyle(fontWeight: FontWeight.bold)),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LeaverecordScreen()),
            );
          },
          child: const Text('View All',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              )),
        ),
      ],
    );
  }

  Widget _buildLeaveCard({
    required String type,
    required String date,
    required String status,
    required Color statusColor,
    required String dateRequest,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(type, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(date, style: TextStyle(color: Colors.grey[700])),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dateRequest),
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
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
