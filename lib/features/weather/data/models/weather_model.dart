class WeatherModel {
  final String cityName;
  final double temperature;
  final String description;
  final double feelsLike;
  final double humidity;
  final double windSpeed;
  final String windDirection;
  final int uvIndex;
  final String observationTime;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.windDirection,
    required this.uvIndex,
    required this.observationTime,
  });

  factory WeatherModel.fromWttrJson(Map<String, dynamic> json) {
    final currentCondition = json['current_condition'][0];
    final nearestArea = json['nearest_area'][0];
    
    return WeatherModel(
      cityName: nearestArea['areaName'][0]['value'],
      temperature: double.parse(currentCondition['temp_C']),
      description: currentCondition['weatherDesc'][0]['value'],
      feelsLike: double.parse(currentCondition['FeelsLikeC']),
      humidity: double.parse(currentCondition['humidity']),
      windSpeed: double.parse(currentCondition['windspeedKmph']),
      windDirection: currentCondition['winddir16Point'],
      uvIndex: int.parse(currentCondition['uvIndex']),
      observationTime: currentCondition['observation_time'],
    );
  }
}
