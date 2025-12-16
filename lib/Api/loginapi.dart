import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nss/Api/regiapi.dart';
import 'package:nss/Home.dart';


String? Loginid;
Future<void> Loginapi({required String email,required String password, context})async {
  try{
    Response response = await dio.post('$url/api/login',data:{
      'username':email,
      "password":password
    });
    if (response.statusCode ==200 || response.statusCode == 201) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
      var responseData = response.data;
      Loginid = responseData["userid"];
      print(responseData);}
 
     else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("login failed")));
     }
  
    } catch (e) {
      print('Login error: $e');
      ScaffoldMessenger.of(context,).showSnackBar(const SnackBar(content: Text('Student Is not verified')));

    }
}