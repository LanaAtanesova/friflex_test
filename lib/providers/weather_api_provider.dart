import 'package:dio/dio.dart';
import 'package:friflex_test/models/weather_model.dart';

// Провайдер данных погоды из API
// Используем Dio, т.к. это мощный и гибкий HTTP клиент для Dart, с большим запасом функций
class WeatherApiProvider {
  final Dio _dio = Dio();
  final _apiKey = '5f9e67cf9a15001744f3c7d3cc72f1fe';
  final _units = 'metric';
  late final String _url;

  WeatherApiProvider() {
    // Собираем и сохраняем url для запросов к API
    _url = 'https://api.openweathermap.org/data/2.5/weather?appid=$_apiKey&units=$_units';
  }

  // Запрашиваем данные о погоде и возвращаем WeatherModel
  Future<WeatherModel> fetchWeatherForCity(String cityName) async {
    try {
      // Запрашиваем данные из API и в случае успеха форматируем их из JSON в WeatherModel
      Response response = await _dio.get('$_url&q=$cityName');
      return WeatherModel.fromJson(response.data);
    } catch (error, stacktrace) {
      // ignore: avoid_print
      print('Exception occured: $error stackTrace: $stacktrace');

      // При ошибке, записываем 'Ошибка получения данных' в WeatherModel.error
      return WeatherModel.withError('Ошибка получения данных');
    }
  }
}