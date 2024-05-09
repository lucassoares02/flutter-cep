import 'dart:convert';

import 'package:cep/cep_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchCepRepository {
  getCepRequest(String code) async {
    try {
      final response = await http.get(Uri.parse("https://viacep.com.br/ws/$code/json/"));
      print(response.body);
      final json = jsonDecode(response.body);
      return CepModel.fromJson(json);
    } catch (e) {
      debugPrint("Get Cep Request (SearchRepository) Error: $e");
    }
  }
}
