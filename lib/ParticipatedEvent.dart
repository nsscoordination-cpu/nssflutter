import 'package:flutter/material.dart';
import 'package:nss/Api/loginapi.dart';
import 'package:nss/Api/regiapi.dart';
import 'package:nss/Feedback.dart';
import 'package:nss/complaint.dart';

class Participatedevent extends StatefulWidget {
  const Participatedevent({super.key});

  @override
  State<Participatedevent> createState() => _ParticipatedeventState();
}

class _ParticipatedeventState extends State<Participatedevent> {
  List<dynamic> participatedEvents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getEvents();
  }

  Future<void> getEvents() async {
    try {
      final response = await dio.get(
        '$url/api/student/events/present/$Loginid',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          participatedEvents = response.data['Events'];
          isLoading = false;
        });
      } else {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to fetch events")),
        );
      }
    } catch (e) {
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Something went wrong")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6EFEA),
      appBar: AppBar(
        title: const Text("Participated Events"),
        centerTitle: true,
        backgroundColor: const Color(0xFFB4694E),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFB4694E),
              ),
            )
          : participatedEvents.isEmpty
              ? const Center(
                  child: Text(
                    "No participated events found",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                )
              : ListView.builder(
                  itemCount: participatedEvents.length,
                  itemBuilder: (context, index) {
                    final event = participatedEvents[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      elevation: 4,
                      color: Colors.white,
                      shadowColor:
                          const Color(0xFFB4694E).withOpacity(0.25),
                      child: ListTile(
                        leading: const Icon(
                          Icons.event,
                          color: Color(0xFF8D4A2F),
                        ),
                        title: Text(
                          event['name'] ?? "No name",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8D4A2F),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "📍 Place: ${event['place'] ?? 'N/A'}",
                                style: const TextStyle(
                                  color: Color(0xFF6D4C41),
                                ),
                              ),
                              Text(
                                "⏰ Time: ${event['time'] ?? 'N/A'}",
                                style: const TextStyle(
                                  color: Color(0xFF6D4C41),
                                ),
                              ),
                              Text(
                                "📅 Date: ${event['date'] != null ? event['date'].toString().substring(0, 10) : 'N/A'}",
                                style: const TextStyle(
                                  color: Color(0xFF6D4C41),
                                ),
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Complaintpage(
                                                cid: event['_id'],
                                              ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Complaint',
                                      style: TextStyle(
                                        color: Color(0xFFB4694E),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FeedbackPage(
                                                id: event['_id'],
                                              ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Feedback',
                                      style: TextStyle(
                                        color: Color(0xFFB4694E),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
