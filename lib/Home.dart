import 'package:flutter/material.dart';
import 'package:nss/Attendence.dart';
import 'package:nss/Events.dart';
import 'package:nss/Login.dart';
import 'package:nss/Notification.dart';
import 'package:nss/Profile.dart';
import 'package:nss/Report.dart';
import 'package:nss/StudentPerformance.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final Color primaryColor = const Color(0xFF1F2A44); // Navy
  final Color accentColor = const Color(0xFF2BB0A6); // Teal
  final Color bgColor = const Color(0xFFF4F6F8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      /// APP BAR
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white, // MENU ICON COLOR
        ),
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1F2A44),
                Color(0xFF2C3E66),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationApp()),
                    );
                  },
                ),

                /// NOTIFICATION BADGE
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: accentColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      "3",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),

      /// DRAWER
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person,
                        size: 40, color: Color(0xFF1F2A44)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Welcome",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            drawerItem(Icons.home_outlined, "Home", primaryColor, () {
              Navigator.pop(context);
            }),
            drawerItem(
                Icons.settings_outlined, "Settings", primaryColor, () {}),
            drawerItem(Icons.logout, "Logout", Colors.redAccent, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            }),
          ],
        ),
      ),

      /// BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// WELCOME CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "NSS Student Dashboard",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            /// QUICK ACTIONS
            const Text(
              "Quick Actions",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),

            const SizedBox(height: 16),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                featureCard(Icons.person_outline, "Profile", accentColor,
                    onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ProfilePage()));
                }),
                featureCard(Icons.access_time_outlined, "Attendance",
                    accentColor, onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => AttendancePage()));
                }),
                featureCard(Icons.event_outlined, "Events", accentColor,
                    onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => EventsPage()));
                }),
                featureCard(Icons.bar_chart_outlined, "Reports", accentColor,
                    onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ReportViewPage()));
                }),
                featureCard(Icons.accessibility_new_sharp, "Perfomance", accentColor,
                    onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => PerfomancePage()));
                }),
                
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// FEATURE CARD
  Widget featureCard(
    IconData icon,
    String title,
    Color accentColor, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 28, color: accentColor),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  /// DRAWER ITEM
  static Widget drawerItem(
      IconData icon, String title, Color color, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      onTap: onTap,
    );
  }
}
