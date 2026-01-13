import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nss/Api/regiapi.dart';
import 'package:nss/Home.dart';


String? Loginid;
String? userid;
String? regyear;



Future<void> Loginapi({
  required String email,
  required String password,
  required BuildContext context,
}) async {
  try {
    Response response = await dio.post(
      '$url/api/login',
      data: {
        'username': email,
        'password': password,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = response.data;

      Loginid = responseData["userid"];
      userid = responseData['fulldetails']["_id"];
      regyear = responseData['fulldetails']["regYear"];

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  } on DioException catch (e) {
    /// ✅ Server responded with error
    if (e.response != null) {
      final statusCode = e.response!.statusCode;

      if (statusCode == 401) {
        // Invalid username or password
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid username or password")),
        );
      } else if (statusCode == 403) {
        // Not verified
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Student is not verified")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login failed. Try again")),
        );
      }
    } else {
      /// ❌ No response (network error)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Network error. Please try again")),
      );
    }
  } catch (e) {
    /// ❌ Any other error
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Something went wrong")),
    );
    print("Login error: $e");
  }
}
