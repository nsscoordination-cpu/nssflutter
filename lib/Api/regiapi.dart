import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nss/Login.dart';

final Dio dio = Dio();
final String url = "http://192.168.1.142:8000"; // <-- ADD YOUR BASE URL HERE

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

      // Upload image
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  } catch (e) {
    print("Error: $e");
  }
}
