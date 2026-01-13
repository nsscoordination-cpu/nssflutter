import 'package:flutter/material.dart';
import 'package:nss/Api/loginapi.dart';
import 'package:nss/Api/regiapi.dart';
import 'package:nss/ParticipatedEvent.dart';

class ReportViewPage extends StatefulWidget {
  const ReportViewPage({super.key});

  @override
  State<ReportViewPage> createState() => _ReportViewPageState();
}

class _ReportViewPageState extends State<ReportViewPage> {
  final Color primaryColor = const Color(0xFFB4694E);
  final Color accentColor = const Color(0xFF8D4A2F);

  List<dynamic> complaints = [];
  bool isLoading = true;

  final TextEditingController feedbackController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getComplaints();
  }

  Future<void> getComplaints() async {
    try {
      final response =
          await dio.get('$url/api/student/complaints/$Loginid');

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          complaints = response.data['complaints'] ?? [];
          isLoading = false;
        });
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
  }

  void showFeedbackDialog(int index) {
    feedbackController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFFFF4E6),
        title: const Text(
          "Submit Feedback",
          style: TextStyle(color: Color(0xFFB4694E)),
        ),
        content: TextField(
          controller: feedbackController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: "Enter your feedback...",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Color(0xFF6D4C41)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
            ),
            onPressed: () {
              setState(() {
                complaints[index]['feedback'] =
                    feedbackController.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Feedback submitted")),
              );
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6EFEA),
      appBar: AppBar(
        title: const Text("Reports & Replies"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFB4694E),
              ),
            )
          : complaints.isEmpty
              ? const Center(
                  child: Text(
                    "No complaints found",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6D4C41),
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: complaints.length,
                  itemBuilder: (context, index) {
                    return buildComplaintCard(
                      complaints[index],
                      index,
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: accentColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Participatedevent(),
            ),
          );
        },
      ),
    );
  }

  Widget buildComplaintCard(dynamic complaint, int index) {
    final eventName = complaint['eventId'] != null
        ? complaint['eventId']['name'] ?? 'Unknown Event'
        : 'Unknown Event';

    final hasReply = complaint['replay'] != null &&
        complaint['replay'].toString().isNotEmpty;

    return Card(
      elevation: 6,
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              children: [
                Expanded(
                  child: Text(
                    eventName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: hasReply
                        ? Colors.green.withOpacity(0.15)
                        : Colors.orange.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    hasReply ? "Replied" : "Pending",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: hasReply
                          ? Colors.green
                          : Colors.orange,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// DATE
            Row(
              children: const [
                Icon(
                  Icons.calendar_month,
                  size: 16,
                  color: Color(0xFF6D4C41),
                ),
                SizedBox(width: 6),
              ],
            ),
            Text(
              complaint['date'] ?? "N/A",
              style: const TextStyle(color: Color(0xFF6D4C41)),
            ),

            const SizedBox(height: 14),

            /// COMPLAINT
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4E6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Complaint",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB4694E),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    complaint['complaint'] ?? "No complaint",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF6D4C41),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            /// ADMIN REPLY
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: hasReply
                    ? Colors.green.withOpacity(0.08)
                    : Colors.red.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Admin Reply",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB4694E),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    hasReply
                        ? complaint['replay']
                        : "No reply yet",
                    style: TextStyle(
                      fontSize: 15,
                      color: hasReply
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            if (complaint['feedback'] != null &&
                complaint['feedback']
                    .toString()
                    .isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE8D6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Your Feedback: ${complaint['feedback']}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6D4C41),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
