import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final DateTime initialLeaveDate = DateTime(2024, 6, 11); // leave pertama
  late final List<DateTime> regularLeaveDates;

  @override
  void initState() {
    super.initState();
    regularLeaveDates = _generateRegularLeaveDates(
      start: initialLeaveDate,
      until: DateTime(2025, 12, 31),
      interval: 70,
    );
  }

  List<DateTime> _generateRegularLeaveDates({
    required DateTime start,
    required DateTime until,
    required int interval,
  }) {
    final List<DateTime> dates = [];
    DateTime current = start;
    while (current.isBefore(until)) {
      dates.add(current);
      current = current.add(Duration(days: interval));
    }
    return dates;
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF032D60),
        title: const Text(
          "Calender",
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
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020),
              lastDay: DateTime.utc(2030),
              focusedDay: _focusedDay,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) =>
                  _selectedDay != null && isSameDay(_selectedDay!, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                markerDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.orange.shade200,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: const TextStyle(color: Colors.red),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (regularLeaveDates.any((d) => isSameDay(d, date))) {
                    return Positioned(
                      bottom: 1,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 24),

            // Legend
            Row(
              children: const [
                SizedBox(width: 12),
                Icon(Icons.stop, color: Colors.red, size: 14),
                SizedBox(width: 6),
                Text('Regular Leave', style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
