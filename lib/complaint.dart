import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nss/Api/loginapi.dart';
import 'package:nss/Api/regiapi.dart';

class Complaintpage extends StatefulWidget {
  final String? cid;

  const Complaintpage({super.key, required this.cid});

  @override
  State<Complaintpage> createState() => _ComplaintpageState();
}

class _ComplaintpageState extends State<Complaintpage> {
  final TextEditingController _complaintController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _complaintController.dispose();
    super.dispose();
  }

  

  Future<void> complaintApi() async {
    if (!formKey.currentState!.validate()) return;

    try {
      final response = await dio.post(
        '$url/api/student/complaint/$Loginid',
        data: {
          'complaint': _complaintController.text,
          'eventId': widget.cid,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: "Complaint Submitted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        _complaintController.clear();
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
      appBar: AppBar(
        title: const Text("Submit Complaint"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _complaintController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    labelText: 'Complaint',
                    hintText: 'Enter your complaint',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.report_problem_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter your complaint';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: complaintApi,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF253A52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'SUBMIT',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
