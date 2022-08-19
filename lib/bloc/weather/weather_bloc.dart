import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friflex_test/models/weather_model.dart';
import 'package:friflex_test/providers/weather_api_provider.dart';

// Файлы weaher_event.dart и weather_state.dart являются частью реализациии weather_bloc
part 'weather_event.dart';
part 'weather_state.dart';

class NetworkError extends Error {}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(String _cityName) : super(WeatherInitial()) {
    final WeatherApiProvider _weatherApiProvider = WeatherApiProvider();

    // Обработчик события GetWeahter
    on<GetWeather>((event, emit) async {
      try {
        // Вызываем состояние WeatherLoading пока происходит получение данных
        emit(WeatherLoading());
        final weather = await _weatherApiProvider.fetchWeatherForCity(_cityName);

        // Когда данные получены, вызываем состояние WheatherLoaded и передаем в него эти данные
        emit(WeatherLoaded(weather));
        
        // Если запрос выполнился с ошибкой, то вызываем состояние WeatherError и передаем туда строку 'Ошибка получения данных'
        if (weather.error != null) {
          emit(const WeatherError('Ошибка получения данных'));
        }
      } on NetworkError {
        // При ошибке сети действуем аналагично с ошибкой API (выше)
        emit(const WeatherError('Ошибка получения данных'));
      }
    });
  }
}
