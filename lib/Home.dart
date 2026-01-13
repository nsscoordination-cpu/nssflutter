// import 'package:flutter/material.dart';
// import 'package:nss/Attendence.dart';
// import 'package:nss/Events.dart';
// import 'package:nss/Login.dart';
// import 'package:nss/Notification.dart';
// import 'package:nss/Profile.dart';
// import 'package:nss/Report.dart';
// import 'package:nss/StudentPerformance.dart';

// class HomePage extends StatelessWidget {
//   HomePage({super.key});

//   final Color bgColor = const Color(0xFFF2F4F7);
//   final Color primaryColor = const Color(0xFF2563EB); // Blue
//   final Color accentColor = const Color(0xFF10B981); // Green
//   final Color cardColor = Colors.white;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bgColor,

//       /// APP BAR
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         iconTheme: const IconThemeData(color: Colors.black87),
//         centerTitle: false,
//         title: const Text(
//           "NSS Dashboard",
//           style: TextStyle(
//             color: Colors.black87,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications_none),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => NotificationApp(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),

//       /// DRAWER
//       drawer: Drawer(
//         child: Column(
//           children: [
//             UserAccountsDrawerHeader(
//               decoration: BoxDecoration(color: primaryColor),
//               currentAccountPicture: const CircleAvatar(
//                 backgroundColor: Colors.white,
//                 child: Icon(Icons.person, size: 40, color: Colors.black),
//               ),
//               accountName: const Text(
//                 "NSS Student",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               accountEmail: const Text("student@nss.org"),
//             ),
//             drawerItem(Icons.home, "Home", () {
//               Navigator.pop(context);
//             }),
//             drawerItem(Icons.settings, "Settings", () {}),
//             const Divider(),
//             drawerItem(Icons.logout, "Logout", () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginPage()),
//               );
//             }),
//           ],
//         ),
//       ),

//       /// BODY
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// HERO CARD
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: primaryColor,
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text(
//                     "Welcome 👋",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 6),
//                   Text(
//                     "Manage your NSS activities easily",
//                     style: TextStyle(color: Colors.white70),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 30),

//             /// SECTION TITLE
//             const Text(
//               "Dashboard",
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 16),

//             /// GRID
//             GridView.count(
//               crossAxisCount: 2,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               crossAxisSpacing: 16,
//               mainAxisSpacing: 16,
//               children: [
//                 dashboardCard(
//                   icon: Icons.person,
//                   title: "Profile",
//                   color: primaryColor,
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (_) => ProfilePage()));
//                   },
//                 ),
//                 dashboardCard(
//                   icon: Icons.access_time,
//                   title: "Attendance",
//                   color: accentColor,
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (_) => AttendancePage()));
//                   },
//                 ),
//                 dashboardCard(
//                   icon: Icons.event,
//                   title: "Events",
//                   color: Colors.orange,
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (_) => EventsPage()));
//                   },
//                 ),
//                 dashboardCard(
//                   icon: Icons.bar_chart,
//                   title: "Reports",
//                   color: Colors.purple,
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (_) => ReportViewPage()));
//                   },
//                 ),
//                 dashboardCard(
//                   icon: Icons.trending_up,
//                   title: "Performance",
//                   color: Colors.teal,
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (_) => PerfomancePage()));
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// DASHBOARD CARD
//   Widget dashboardCard({
//     required IconData icon,
//     required String title,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         decoration: BoxDecoration(
//           color: cardColor,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 10,
//               offset: Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.15),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(icon, size: 30, color: color),
//             ),
//             const SizedBox(height: 14),
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// DRAWER ITEM
//   static Widget drawerItem(
//       IconData icon, String title, VoidCallback onTap) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Text(title),
//       onTap: onTap,
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:nss/Api/loginapi.dart';
import 'package:nss/Api/regiapi.dart';
import 'package:nss/Attendence.dart';
import 'package:nss/Events.dart';
import 'package:nss/Login.dart';
import 'package:nss/Notification.dart';
import 'package:nss/Profile.dart';
import 'package:nss/Report.dart';
import 'package:nss/StudentPerformance.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  /// DRAWER ITEM
  static Widget drawerItem(
      IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.brown),
      title: Text(title, style: const TextStyle(color: Colors.brown)),
      onTap: onTap,
    );
  }
}

class _HomePageState extends State<HomePage> {
List<dynamic>dp=[];

  Future<void> get_dp() async {
    try {
      final response = await dio.get('$url/api/student/profile/$Loginid');
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          dp = response.data['profile'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_dp();
  }

  // Background color remains warm
  final Color bgColor = const Color(0xFFFFF4E6);

  // Clean gradient for square cards
  final Gradient cardGradient = const LinearGradient(
    colors: [Color(0xFFFFF7F0), Color(0xFFFFE8D6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      /// APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        iconTheme: const IconThemeData(color: Colors.brown),
        centerTitle: true,
        title: const Text(
          "NSS Dashboard",
          style: TextStyle(
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.brown),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NotificationApp()),
              );
            },
          ),
        ],
      ),

      /// DRAWER
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFB4694E), Color(0xFFFFA54F)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                    backgroundImage:  NetworkImage(
                  '$url/uploads/students/${dp[0]['photo']}',
                ),
                   
                  ),
                  SizedBox(height: 14),
                  Text(
                    "NSS Student",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            // HomePage.drawerItem(Icons.home_outlined, "Home", () {
            //   Navigator.pop(context);
            // }),
            // HomePage.drawerItem(Icons.settings_outlined, "Settings", () {}),
            // const Divider(color: Colors.brown),
            HomePage.drawerItem(Icons.logout, "Logout", () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
              );
            }),
          ],
        ),
      ),

      /// BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// WELCOME CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFB4694E), Color(0xFFFFA54F)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.3),
                    blurRadius: 14,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFF3E0)), // Soft cream
                  ),
                  SizedBox(height: 6),
                  Text(
                    "NSS Student Dashboard",
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFFFE0B2)), // Light warm brown
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// QUICK ACTIONS TEXT
            const Text(
              "Quick Actions",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown),
            ),

            const SizedBox(height: 16),

            /// CLEAN SQUARE CARDS
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                cleanCard(
                  icon: Icons.person_outline,
                  title: "Profile",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ProfilePage()));
                  },
                ),
                cleanCard(
                  icon: Icons.access_time_outlined,
                  title: "Attendance",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AttendancePage()));
                  },
                ),
                cleanCard(
                  icon: Icons.event_outlined,
                  title: "Events",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => EventsPage()));
                  },
                ),
                cleanCard(
                  icon: Icons.bar_chart_outlined,
                  title: "Reports",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ReportViewPage()));
                  },
                ),
                cleanCard(
                  icon: Icons.trending_up,
                  title: "Performance",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => PerfomancePage()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// CLEAN CARD DESIGN
  Widget cleanCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          gradient: cardGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.brown, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.brown,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
