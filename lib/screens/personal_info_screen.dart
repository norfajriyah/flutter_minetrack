import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Norfajriyah');
  final TextEditingController _emailController =
      TextEditingController(text: 'nrmikasa@gmail.com');
  final TextEditingController _phoneController =
      TextEditingController(text: '081234567890');
  final TextEditingController _addressController =
      TextEditingController(text: 'Jakarta Selatan');
  final TextEditingController _contractController =
      TextEditingController(text: 'Contract');
  final TextEditingController _positionController =
      TextEditingController(text: 'System Developer');

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime(2003, 6, 8);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF032D60),
        title: const Text(
          "Personal Informations",
          style: TextStyle(color: Color(0xFFF2F4E8), fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _buildLabel("Full Name"),
            _buildInputField(
                icon: Icons.person_outline, controller: _nameController),
            _buildLabel("Date Of Birth"),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: _buildInputField(
                  icon: Icons.calendar_today,
                  controller: TextEditingController(
                    text: selectedDate != null
                        ? DateFormat('dd MMMM yyyy').format(selectedDate!)
                        : '',
                  ),
                ),
              ),
            ),
            _buildLabel("Email"),
            _buildInputField(
                icon: Icons.email_outlined, controller: _emailController),
            _buildLabel("No. Telephone"),
            _buildInputField(icon: Icons.phone, controller: _phoneController),
            _buildLabel("Alamat"),
            _buildInputField(icon: Icons.home, controller: _addressController),
            _buildInputField(
                icon: Icons.work_outline, controller: _contractController),
            _buildInputField(
                icon: Icons.bookmark_outline, controller: _positionController),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF57C00),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Saved successfully!')),
                );
              },
              child: const Text("Save",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        readOnly: icon == Icons.calendar_today,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
