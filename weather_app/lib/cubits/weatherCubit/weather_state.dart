import 'package:weather_app/models/weather_model.dart';

abstract class WeatherState {}

class WeatherInitail extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherSuccess extends WeatherState {
  WeatherSuccess({required this.weatherModel});
  WeatherModel weatherModel;
}

class WeatherFailure extends WeatherState {}
