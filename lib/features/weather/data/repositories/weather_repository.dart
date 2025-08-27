import 'package:riverpod_practice/features/weather/data/services/weather_services.dart';

import '../models/weather_model.dart';

abstract class WeatherRepository {
  Future<WeatherModel> getWeatherByCity(String cityName);
}

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherService _weatherService;

  WeatherRepositoryImpl(this._weatherService);

  @override
  Future<WeatherModel> getWeatherByCity(String cityName) async {
    try {
      return await _weatherService.fetchWeather(cityName);
    } catch (e) {
      throw Exception('Failed to get weather data: $e');
    }
  }
}
