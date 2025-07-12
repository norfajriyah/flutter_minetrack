import 'package:flutter/material.dart';
import 'package:flutter_minetrack/screens/home_screen.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5E9),
      body: Column(
        children: [
          // 🔶 Header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 24),
            decoration: const BoxDecoration(
              color: Color(0xFF0D3475),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, Norfajriyah',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          'PT. Karunia Fajr Abadi XYZ',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Recap Box
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Monthly Attendance Recap',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          _StatusIcon(
                              icon: Icons.fact_check_outlined,
                              color: Colors.blue,
                              count: 28,
                              label: "Present"),
                          _StatusIcon(
                              icon: Icons.close,
                              color: Colors.red,
                              count: 1,
                              label: "Absent"),
                          _StatusIcon(
                              icon: Icons.access_time,
                              color: Colors.orange,
                              count: 5,
                              label: "Late"),
                          _StatusIcon(
                              icon: Icons.check_circle_outline,
                              color: Colors.blueAccent,
                              count: 2,
                              label: "Early Left"),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.how_to_reg, color: Colors.green),
                    SizedBox(width: 8),
                    Text(
                      'Attendance',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Mon, 30 Jun 2025',
                  style: TextStyle(color: Colors.black54),
                )
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Record Check In/Out
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _RecordBox(
                  label: "Check In",
                  time: "07.30",
                  color: Colors.blue,
                  icon: Icons.access_time,
                ),
                _RecordBox(
                  label: "Check Out",
                  time: "18.00",
                  color: Colors.red,
                  icon: Icons.access_time,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            "Work time remaining",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Circular Progress (Dummy)
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: CircularProgressIndicator(
                  value: 0.85,
                  strokeWidth: 12,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xFFF57C00)),
                  backgroundColor: Colors.grey.shade300,
                ),
              ),
              const Text(
                "01:20",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final int count;
  final String label;

  const _StatusIcon(
      {required this.icon,
      required this.color,
      required this.count,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Icon(icon, size: 32, color: color),
            Positioned(
              right: -2,
              top: -2,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.orange,
                child: Text(
                  "$count",
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 6),
        Text(label),
      ],
    );
  }
}

class _RecordBox extends StatelessWidget {
  final String label;
  final String time;
  final Color color;
  final IconData icon;

  const _RecordBox({
    required this.label,
    required this.time,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, offset: Offset(2, 4), blurRadius: 8)
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            time,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
