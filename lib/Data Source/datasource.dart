// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopliax_todo/Model/photo_model.dart';

const String apiUrl = 'https://jsonplaceholder.typicode.com/photos';

Future<List<PhotoModel>> fetchPhotos() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => PhotoModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load photos');
  }
}
