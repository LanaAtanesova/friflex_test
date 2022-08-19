part of 'weather_bloc.dart';

// Создаем абстрактный класс для событий
// Наследуемся от абстрактного класса Equatable для проверки равенства без переопределения оператора "==" и сравнения по hashCode
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

// Создаем события для вызова запроса на получение погоды
class GetWeather extends WeatherEvent {}
