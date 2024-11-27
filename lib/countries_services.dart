
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
Future<List<dynamic>>  fetchCountries() async{
  try{
    final response = await http.get(Uri.parse("https://restcountries.com/v3.1/all?fields=name,region"));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception("Failed to load countries");
    }
  }catch(e){
    debugPrint("Error $e");
    throw Exception("Failed to load countries $e");
  }
}