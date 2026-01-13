import 'package:flutter/material.dart';
import 'package:nss/Api/regiapi.dart';
import 'package:nss/EventImages.dart';

class EventsPage extends StatefulWidget {
  EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final Color primaryColor = const Color(0xFFB4694E);
  final Color accentColor = const Color(0xFF8D4A2F);

  List<dynamic> eventss = [];

  Future<void> get_events() async {
    try {
      final response = await dio.get('$url/api/student/events');
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          eventss = response.data['events'];
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Failed")));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    get_events();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6EFEA),
      appBar: AppBar(
        title: const Text(
          "NSS Events",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        elevation: 4,
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: eventss.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFB4694E),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              itemCount: eventss.length,
              itemBuilder: (context, index) {
                final event = eventss[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Eventimages(eid: event['_id'].toString()),
                      ),
                    );
                  },
                  child: buildEventCard(event, context),
                );
              },
            ),
    );
  }

  Widget buildEventCard(eventss, BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      shadowColor: primaryColor.withOpacity(0.25),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              eventss["name"],
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: accentColor,
                letterSpacing: 0.8,
              ),
            ),

            const SizedBox(height: 14),

            // Date
            Row(
              children: const [
                Icon(
                  Icons.calendar_today,
                  size: 19,
                  color: Color(0xFF6D4C41),
                ),
                SizedBox(width: 8),
              ],
            ),
            Text(
              eventss["date"] ?? "",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 14),

            // Location
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 20,
                  color: Color(0xFF6D4C41),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    eventss["place"] ?? "",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Divider(height: 20, thickness: 1.1, color: Colors.grey.shade300),

            const SizedBox(height: 6),

            // Time row
            Row(
              children: [
                const Icon(
                  Icons.access_time_filled,
                  size: 20,
                  color: Color(0xFF6D4C41),
                ),
                const SizedBox(width: 8),
                Text(
                  "Time : ${eventss["time"] ?? ""}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Eventimages(eid: eventss['_id'].toString()),
                      ),
                    );
                  },
                  child: Text(
                    'Images',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
