import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nss/Api/loginapi.dart';
import 'package:nss/Api/regiapi.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  int totalDays = 0;
  int presentDays = 0;
  int absentDays = 0;
  double percentage = 0;

  List events = [];

  /// ✅ Dynamic attendance color
  Color get attendanceColor {
    if (percentage < 50) {
      return Colors.red;
    } else if (percentage < 75) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  Future<void> get_Attendence() async {
    try {
      final response =
          await dio.get('$url/api/student/attendance/$Loginid');

      if (response.statusCode == 200) {
        setState(() {
          totalDays = response.data['totalSessions'] ?? 0;
          presentDays = response.data['attended'] ?? 0;
          absentDays = totalDays - presentDays;
          percentage =
              totalDays > 0 ? (presentDays / totalDays) * 100 : 0;

          events = response.data['Events'] ?? [];
        });
      }
    } catch (e) {
      print("Attendance error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    get_Attendence();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              /// HEADER
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: const [
                    Icon(Icons.fact_check,
                        color: Colors.white, size: 28),
                    SizedBox(width: 12),
                    Text(
                      "Attendance",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),

              /// CONTENT
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      /// PROGRESS CIRCLE
                      SizedBox(
                        width: 170,
                        height: 170,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            /// Glow
                            Container(
                              width: 170,
                              height: 170,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        attendanceColor.withOpacity(0.35),
                                    blurRadius: 25,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                            ),

                            /// Center Text
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${percentage.toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: attendanceColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "Attendance",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// SUMMARY CARDS
                      Row(
                        children: [
                          summaryCard("Total", totalDays, Colors.blue),
                          summaryCard(
                              "Present", presentDays, attendanceColor),
                          summaryCard("Absent", absentDays, Colors.red),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// EVENTS TITLE
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Attended Events",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// EVENTS LIST
                      Expanded(
                        child: events.isEmpty
                            ? const Center(
                                child: Text(
                                  "No events found",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54),
                                ),
                              )
                            : ListView.builder(
                                itemCount: events.length,
                                itemBuilder: (context, index) {
                                  final event = events[index];
                                  final date =
                                      DateTime.parse(event['date']);

                                  return Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12),
                                    ),
                                    margin: const EdgeInsets.only(
                                        bottom: 10),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor:
                                            attendanceColor,
                                        child: const Icon(Icons.event,
                                            color: Colors.white),
                                      ),
                                      title: Text(
                                        event['name'],
                                        style: const TextStyle(
                                            fontWeight:
                                                FontWeight.w600),
                                      ),
                                      subtitle: Text(
                                        "${DateFormat('dd MMM yyyy').format(date)} • ${event['place']}",
                                      ),
                                      trailing: Text(
                                        event['time'],
                                        style: const TextStyle(
                                            fontWeight:
                                                FontWeight.bold),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget summaryCard(String title, int value, Color color) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 6),
              Text(
                value.toString(),
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
