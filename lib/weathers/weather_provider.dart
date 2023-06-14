import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final weatherProvider = FutureProvider.autoDispose.family<Map<String, dynamic>, String>((ref, city) async {
  final url = Uri.parse('http://api.weatherapi.com/v1/current.json?key=ac05b2c218b84ae9889181350231201&q=$city');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final body = response.body;
    final json = jsonDecode(body);
    return json;
  } else {
    throw Exception('Failed to load data');
  }
});

class WeatherProvider extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  WeatherProvider(String city) : super(AsyncValue.loading()) {
    fetchWeather(city);
  }

  Future<void> fetchWeather(String city) async {
    try {
      final url = Uri.parse('http://api.weatherapi.com/v1/current.json?key=ac05b2c218b84ae9889181350231201&q=$city');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        state = AsyncValue.data(json);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      state = AsyncValue.error(error);
    }
  }
}