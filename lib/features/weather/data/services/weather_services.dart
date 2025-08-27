import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  static const String baseUrl = 'https://wttr.in';

  Future<WeatherModel> fetchWeather(String cityName) async {
    try {
      final url = '$baseUrl/$cityName?format=j1';
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'User-Agent': 'curl/7.64.1', // wttr.in works better with this header
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherModel.fromWttrJson(data);
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }

  // Additional method to get weather for current location
  Future<WeatherModel> fetchCurrentLocationWeather() async {
    try {
      const url = '$baseUrl/?format=j1';
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'User-Agent': 'curl/7.64.1',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherModel.fromWttrJson(data);
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }
}
