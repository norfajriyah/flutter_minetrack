import 'package:flutter/material.dart';

class CheckInScreen extends StatelessWidget {
  const CheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4E8),
      body: Column(
        children: [
          // 🔳 Simulasi Map Area
          Container(
            height: 350,
            width: double.infinity,
            color: Colors.grey[300],
            child: const Icon(Icons.map, size: 100, color: Colors.grey),
          ),

          // ✅ Popup Success Box
          Transform.translate(
            offset: const Offset(0, -50),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F4E8),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(3, 5),
                  ),
                ],
              ),
              child: Column(
                children: const [
                  Icon(Icons.check_circle_outline,
                      color: Colors.black, size: 48),
                  SizedBox(height: 12),
                  Text(
                    "Success",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 📍 Location Area
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 36),
              decoration: const BoxDecoration(
                color: Color(0xFFF2F4E8),
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Current Location",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(Icons.location_on, color: Colors.red),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "7JM6+R6P, Jl. Batulicin – Pelaihari, Karang Indah, Kec. Angsana, Kabupaten Tanah Bumbu, Kalimantan Selatan 72275",
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('You have checked in successfully!'),
                            duration: Duration(milliseconds: 1200),
                          ),
                        );
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          Navigator.pop(context); // Kembali ke Home
                        });
                      },
                      child: const Text(
                        'Check In',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
