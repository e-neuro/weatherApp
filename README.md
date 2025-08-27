# Weather App

A simple weather application built with Flutter and Riverpod.

## Features

- **City Selection:** Choose from a predefined list of cities to view weather information.
- **Real-time Clock:** The app bar displays the current time, updating every second.
- **Current Weather:** Shows the current temperature, weather condition, humidity, and wind speed for the selected city.
- **Favorite Cities:** Add or remove cities from a favorites list.
- **Error Handling:** Displays an error message if the weather data fails to load, with an option to retry.

## State Management

This project uses the [Riverpod](https://riverpod.dev/) package for state management, demonstrating the use of various providers:

- **`StreamProvider`:** For the real-time clock.
- **`FutureProvider`:** For fetching weather data from an API.
- **`StateProvider`:** For managing the selected city.
- **`StateNotifierProvider`:** For managing the list of favorite cities.

## Dependencies

- `flutter_riverpod`
- `http`
- `intl`
- `uuid`

## How to Run

1.  Clone the repository.
2.  Install dependencies: `flutter pub get`
3.  Run the app: `flutter run`