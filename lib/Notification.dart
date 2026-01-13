import 'package:flutter/material.dart';
import 'package:nss/Api/loginapi.dart';
import 'package:nss/Api/regiapi.dart';

class NotificationApp extends StatefulWidget {
  const NotificationApp({super.key});

  @override
  State<NotificationApp> createState() => _NotificationAppState();
}

class _NotificationAppState extends State<NotificationApp> {
  final Color primaryColor = const Color(0xFFB4694E); // warm brown
  final Color accentColor = const Color(0xFFD08C60); // soft accent

  // Notification list
  List<Map<String, dynamic>> notifications = [];

  Future<void> get_notification() async {
    try {
      final response =
          await dio.get('$url/api/student/getNotification/$regyear');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List data = response.data['notifications'] ?? [];

        setState(() {
          notifications =
              data.map((e) => Map<String, dynamic>.from(e)).toList();
        });
      }
    } catch (e) {
      debugPrint("Notification error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    get_notification();
  }

  String formatDate(String date) {
    final dt = DateTime.parse(date).toLocal();
    return "${dt.day}-${dt.month}-${dt.year}  ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E6), // warm beige
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: notifications.isEmpty
          ? Center(
              child: Text(
                "No Notifications Yet",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.brown.shade600,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(14),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.18),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.notifications,
                        color: primaryColor,
                      ),
                    ),
                    title: Text(
                      "New Notification",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text(
                          notif["message"] ?? "",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.brown.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          formatDate(notif["createdAt"]),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.brown.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
