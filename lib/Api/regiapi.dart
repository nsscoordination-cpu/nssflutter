import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nss/Login.dart';

final Dio dio = Dio();
 String url = ""; // <-- ADD YOUR BASE URL HERE
Future<void> Registerapi({
  required String firstname,
  required String department,
  required String dateofbirth,
  required String Gender,
  required String height,
  required String Weight,
  required String Address,
  required String phoneno,
  required String Email,
  required String Blood,
  required String interest,
  required String RegisterYear,
  required String Password,
  required File Image,
  required BuildContext context,
}) async {
  try {
    FormData formData = FormData.fromMap({
      "name": firstname,
      "className": department,
      "dob": dateofbirth,
      "sex": Gender,
      "height": height,
      "weight": Weight,
      "address": Address,
      "phone": phoneno,
      "email": Email,
      "blood": Blood,
      "interests": interest,
      "regYear": RegisterYear,
      "password": Password,
      "Image": await MultipartFile.fromFile(
        Image.path,
        filename: Image.path.split('/').last,
      ),
    });

    Response response = await dio.post(
      "$url/api/Student/register",
      data: formData,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration completed successfully')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  } on DioException catch (e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final message = e.response!.data["message"] ?? "";

      /// ✅ Email already exists
      if (statusCode == 409) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email already exists")),
        );
      }
      /// ❌ Validation errors
      else if (statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.isNotEmpty ? message : "Invalid data")),
        );
      }
      /// ❌ Other server errors
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration failed. Try again")),
        );
      }
    } else {
      /// ❌ No internet / server unreachable
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Network error. Please check connection")),
      );
    }
  } catch (e) {
    print("Register error: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Something went wrong")),
    );
  }
}
