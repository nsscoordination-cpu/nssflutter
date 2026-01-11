import 'package:flutter/material.dart';
import 'package:nss/Api/loginapi.dart';
import 'package:nss/Api/regiapi.dart';

class PerfomancePage extends StatefulWidget {
  const PerfomancePage({super.key});

  @override
  State<PerfomancePage> createState() => _PerfomancePageState();
}

class _PerfomancePageState extends State<PerfomancePage> {
  Map<String, dynamic>? performance;
  bool isLoading = true;

  Future<void> getPerformance() async {
    try {
      final response =
          await dio.get('$url/api/student/getperformance/$userid');

      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          performance = response.data['performance'];
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Performance error: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    getPerformance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Performance'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : performance == null
              ? const Center(child: Text('No performance data found'))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoCard(
                        title: 'Participation Level',
                        value: performance!['participationLevel'],
                        icon: Icons.star,
                        color: Colors.blue,
                      ),
                      _infoCard(
                        title: 'Attendance',
                        value: '${performance!['attendance']}%',
                        icon: Icons.calendar_today,
                        color: Colors.green,
                      ),
                      _infoCard(
                        title: 'Remarks',
                        value: performance!['remarks'],
                        icon: Icons.notes,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
    );
  }

  /// 🔹 Reusable Card Widget
  Widget _infoCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
