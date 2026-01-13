import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nss/Api/loginapi.dart';
import 'package:nss/Api/regiapi.dart';

class FeedbackPage extends StatefulWidget {
  String? id;
  FeedbackPage({super.key, required this.id});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  int rating = 0;

  void submitFeedback() {
    if (_formKey.currentState!.validate() && rating > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Feedback submitted successfully")),
      );

      nameController.clear();
      emailController.clear();
      feedbackController.clear();
      setState(() {
        rating = 0;
      });
    } else if (rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a rating")),
      );
    }
  }

  Widget buildStar(int index) {
    return IconButton(
      icon: Icon(
        Icons.star,
        color:
            index <= rating ? const Color(0xFFB4694E) : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          rating = index;
        });
      },
    );
  }

  Future<void> feedbackApi() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final response = await dio.post(
        '$url/api/student/feedback/$Loginid',
        data: {
          'feedback': feedbackController.text,
          'eventId': widget.id,
          'rating': rating,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: "feedback Submitted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        feedbackController.clear();
        Navigator.pop(context);
        setState(() {
          rating = 0;
        });
      } else {
        Fluttertoast.showToast(
          msg: "Complaint sending failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error sending complaint",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      debugPrint('Complaint error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB4694E),
        title: const Text("Feedback"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "We value your feedback",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB4694E),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Rate Us",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFB4694E),
                ),
              ),

              Row(
                children:
                    List.generate(5, (index) => buildStar(index + 1)),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: feedbackController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Your Feedback",
                  labelStyle:
                      const TextStyle(color: Color(0xFFB4694E)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: const Color(0xFFB4694E), width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Enter your feedback" : null,
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFB4694E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    feedbackApi();
                  },
                  child: const Text(
                    "Submit Feedback",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
