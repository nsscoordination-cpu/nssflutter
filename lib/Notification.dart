import 'package:flutter/material.dart';

class NotificationApp extends StatelessWidget {
  final Color primaryColor = const Color(0xFF1565C0);
  final Color accentColor = const Color(0xFF42A5F5);

  // Dummy notification list as MAP
  final List<Map<String, dynamic>> notifications = [
    {
      "title": "NSS Meeting",
      "message": "Tomorrow at 10 AM in Seminar Hall.",
      "time": "2 hours ago",
      "icon": Icons.notifications
    },
    {
      "title": "Attendance Reminder",
      "message": "Submit today before 6 PM.",
      "time": "1 day ago",
      "icon": Icons.notifications
    },
    {
      "title": "New Event: Clean-up Drive",
      "message": "Join the campus clean-up this Saturday.",
      "time": "3 days ago",
      "icon": Icons.notifications
    },
    {
      "title": "Profile Update",
      "message": "Please update your volunteer details.",
      "time": "1 week ago",
      "icon": Icons.notifications
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Notifications"),
        centerTitle: true,
      ),

      body: notifications.isEmpty
          ? Center(
              child: Text(
                "No Notifications Yet",
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(14),

                    leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        notif["icon"] ?? Icons.notifications,
                        color: accentColor,
                      ),
                    ),

                    title: Text(
                      notif["title"],
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
                          notif["message"],
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          notif["time"],
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[500],
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
