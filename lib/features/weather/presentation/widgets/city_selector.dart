import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/features/weather/presentation/provider/weather_provider.dart';

class CitySelector extends ConsumerStatefulWidget {
  const CitySelector({super.key});

  @override
  ConsumerState<CitySelector> createState() => _CitySelectorState();
}

class _CitySelectorState extends ConsumerState<CitySelector> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCity = ref.watch(selectedCityProvider);
    final favoriteCities = ref.watch(favoriteCitiesProvider);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Weather Location',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter city name (e.g., London, Paris, Tokyo)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.my_location),
                  onPressed: () {
                    // Get weather for current location
                    ref.read(selectedCityProvider.notifier).state = 'Bangalore';
                    _controller.clear();
                  },
                  tooltip: 'Use current location',
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  value.toLowerCase();
                  ref.read(selectedCityProvider.notifier).state = value;
                  _controller.clear();
                }
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Quick Select',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: favoriteCities.map((city) {
                final isSelected = city == selectedCity;
                return GestureDetector(
                  onTap: () {
                    ref.read(selectedCityProvider.notifier).state = city;
                  },
                  child: Chip(
                    label: Text(city),
                    backgroundColor: isSelected
                        ? Colors.blue
                        : Colors.grey[200],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () {
                      ref
                          .read(favoriteCitiesProvider.notifier)
                          .removeCity(city);
                    },
                  ),
                );
              }).toList(),
            ),
            if (selectedCity.isNotEmpty &&
                !favoriteCities.contains(selectedCity))
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextButton.icon(
                  onPressed: () {
                    ref
                        .read(favoriteCitiesProvider.notifier)
                        .addCity(selectedCity);
                  },
                  icon: const Icon(Icons.add),
                  label: Text('Add "$selectedCity" to favorites'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
