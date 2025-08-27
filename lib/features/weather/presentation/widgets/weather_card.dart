import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: _getWeatherGradient(weather.description),
        ),
        child: Column(
          children: [
            Text(
              weather.cityName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last updated: ${weather.observationTime}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${weather.temperature.round()}',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  '°C',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Text(
              weather.description,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            Text(
              'Feels like ${weather.feelsLike.round()}°C',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white60,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherInfo('Humidity', '${weather.humidity.round()}%'),
                _buildWeatherInfo('Wind', '${weather.windSpeed} km/h ${weather.windDirection}'),
                _buildWeatherInfo('UV Index', '${weather.uvIndex}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  LinearGradient _getWeatherGradient(String description) {
    final desc = description.toLowerCase();
    
    if (desc.contains('clear') || desc.contains('sunny')) {
      return const LinearGradient(
        colors: [Colors.orange, Colors.deepOrange],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (desc.contains('rain') || desc.contains('drizzle')) {
      return const LinearGradient(
        colors: [Colors.blueGrey, Colors.blue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (desc.contains('cloud')) {
      return const LinearGradient(
        colors: [Colors.grey, Colors.blueGrey],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (desc.contains('snow')) {
      return const LinearGradient(
        colors: [Colors.lightBlue, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return const LinearGradient(
        colors: [Colors.blue, Colors.lightBlueAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }
}
