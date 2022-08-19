import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friflex_test/bloc/weather/weather_bloc.dart';
import 'package:friflex_test/models/three_days_weather_model.dart';
import 'package:friflex_test/providers/weather_3_days_api_provider.dart';

part 'weather_3_days_event.dart';
part 'weather_3_days_state.dart';

class ThreeDaysNetworkError extends Error {}

// Конструкция аналагична классу WeatherBloc
class Weather3DaysBloc extends Bloc<WeatherEvent, Weather3DaysState> {
  Weather3DaysBloc(String _cityName) : super(Weather3DaysInitial()) {
    final Weather3DaysApiProvider _weatherApiProvider = Weather3DaysApiProvider();

    on<GetWeatherFor3Days>((event, emit) async {
      try {
        emit(Weather3DaysLoading());
        final weather = await _weatherApiProvider.fetchWeatherFor3Days(_cityName);

        emit(Weather3DaysLoaded(weather));
        if (weather.error != null) {
          emit(Weather3DaysError(weather.error));
        }
      } on ThreeDaysNetworkError {
        emit(const Weather3DaysError('Ошибка получения данных'));
      }
    });
  }
}