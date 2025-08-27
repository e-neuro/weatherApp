import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_practice/features/weather/data/repositories/weather_repository.dart';
import 'package:riverpod_practice/features/weather/data/services/weather_services.dart';
import '../../data/models/weather_model.dart';

// Provider: No API key needed for wttr.in!
final baseUrlProvider = Provider<String>((ref) => 'https://wttr.in');

// StateProvider: Selected city name
final selectedCityProvider = StateProvider<String>((ref) => 'Bangalore');

// Service and Repository providers
final weatherServiceProvider = Provider<WeatherService>((ref) => WeatherService());

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final weatherService = ref.read(weatherServiceProvider);
  return WeatherRepositoryImpl(weatherService);
});

// FutureProvider: Weather data from wttr.in
final weatherDataProvider = FutureProvider<WeatherModel>((ref) async {
  final selectedCity = ref.watch(selectedCityProvider);
  final repository = ref.read(weatherRepositoryProvider);
  return repository.getWeatherByCity(selectedCity);
});

// StreamProvider: Current time updates every second
final currentTimeProvider = StreamProvider<String>((ref) {
  return Stream.periodic(
    const Duration(seconds: 1),
    (_) => DateFormat('hh:mm:ss').format(DateTime.now()),
  );
});

// StateNotifierProvider: Favorite cities list
class FavoriteCitiesNotifier extends StateNotifier<List<String>> {
  FavoriteCitiesNotifier() : super(['Delhi', 'Mumbai', 'Chennai', 'Bangalore', 'Kannur']);

  void addCity(String cityName) {
    if (!state.contains(cityName)) {
      state = [...state, cityName];
    }
  }

  void removeCity(String cityName) {
    state = state.where((city) => city != cityName).toList();
  }

  bool isFavorite(String cityName) {
    return state.contains(cityName);
  }
}

final favoriteCitiesProvider = 
    StateNotifierProvider<FavoriteCitiesNotifier, List<String>>((ref) {
  return FavoriteCitiesNotifier();
});
