import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:friflex_test/models/three_days_weather_model.dart';

// Аналогично WeatherApiProvider, только используем фейковые данные из weather_for_3_days.json, т.к. запрос к openweather api для получения погоды на три дня имеется только в платной подписке
class Weather3DaysApiProvider {
  final Dio _dio = Dio();
  final _apiKey = '5f9e67cf9a15001744f3c7d3cc72f1fe';
  final _units = 'metric';
  late final String _url;

  Weather3DaysApiProvider() {
    _url = 'https://api.openweathermap.org/data/2.5/forecast/hourly?appid=$_apiKey&units=$_units';
  }

  Future<ThreeDaysWeatherModel> fetchWeatherFor3Days(String cityName) async {
    try {
      // Получаем значение из файла в формате строки и парсим в JSON
      final String response = await rootBundle.loadString('lib/assets/json/weather_for_3_days.json');

      return ThreeDaysWeatherModel.fromJson(json.decode(response));
    } catch (error, stacktrace) {
      // ignore: avoid_print
      print('Exception occured: $error stackTrace: $stacktrace');
      return ThreeDaysWeatherModel.withError('Ошибка получения данных');
    }
  }
}