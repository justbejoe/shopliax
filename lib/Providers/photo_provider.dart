// lib/providers/photo_provider.dart
import 'dart:convert';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopliax_todo/Data%20Source/datasource.dart';
import 'package:shopliax_todo/Model/photo_model.dart';

final photoListProvider = FutureProvider<List<PhotoModel>>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final storedData = prefs.getString('photos');

  if (storedData != null) {
    final List<dynamic> jsonList = jsonDecode(storedData);
    return jsonList.map((json) => PhotoModel.fromJson(json)).toList();
  } else {
    final photos = await fetchPhotos();
    final List<PhotoModel> first20Photos = photos.take(20).toList();
    final jsonList = first20Photos.map((photo) => photo.toJson()).toList();
    await prefs.setString('photos', jsonEncode(jsonList));
    return first20Photos;
  }
});
