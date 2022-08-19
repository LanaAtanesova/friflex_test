part of 'weather_bloc.dart';

// Создаем абстрактный класс для стейта нашего блока
// Как и в случае с WeatherEvent наследуемся от Equatable
abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

// Создаем классы для различных состояний
// Классы WeatherLoaded и WeatherError принимают данные и ошибку, соответствено
class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weatherModel;
  const WeatherLoaded(this.weatherModel);
}

class WeatherError extends WeatherState {
  final String? message;
  const WeatherError(this.message);
}