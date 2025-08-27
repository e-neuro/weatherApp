import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/features/weather/presentation/provider/weather_provider.dart';
import 'package:riverpod_practice/features/weather/presentation/widgets/city_selector.dart';
import 'package:riverpod_practice/features/weather/presentation/widgets/weather_card.dart';


class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTime = ref.watch(currentTimeProvider);
    final weatherData = ref.watch(weatherDataProvider);
    final selectedCity = ref.watch(selectedCityProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Dashboard'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // StreamProvider: Current time updating in real-time
          currentTime.when(
            data: (time) => Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  time,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            loading: () => const CircularProgressIndicator.adaptive(),
            error: (_, __) => const SizedBox(),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CitySelector(),
              
              // FutureProvider: Weather data with AsyncValue.when()
              weatherData.when(
                data: (weather) => WeatherCard(weather: weather),
                loading: () => const Card(
                  margin: EdgeInsets.all(16),
                  child: Padding(
                    padding: EdgeInsets.all(64),
                    child: Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator.adaptive(),
                          SizedBox(height: 16),
                          Text('Loading weather data...'),
                        ],
                      ),
                    ),
                  ),
                ),
                error: (error, stack) => Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error loading weather data',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            error.toString(),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              ref.invalidate(weatherDataProvider);
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              // Add to favorites button
              Padding(
                padding: const EdgeInsets.all(16),
                child: Consumer(
                  builder: (context, ref, child) {
                    final favoriteCitiesNotifier = ref.read(favoriteCitiesProvider.notifier);
                    final isFavorite = favoriteCitiesNotifier.isFavorite(selectedCity);
                    
                    return ElevatedButton.icon(
                      onPressed: () {
                        if (isFavorite) {
                          favoriteCitiesNotifier.removeCity(selectedCity);
                        } else {
                          favoriteCitiesNotifier.addCity(selectedCity);
                        }
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                      ),
                      label: Text(
                        isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isFavorite ? Colors.red : Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
