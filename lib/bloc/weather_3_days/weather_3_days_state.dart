part of 'weather_3_days_bloc.dart';

// Реализовано по аналогии с WeatherState
abstract class Weather3DaysState extends Equatable {
  const Weather3DaysState();

  @override
  List<Object?> get props => [];
}

class Weather3DaysInitial extends Weather3DaysState {}
class Weather3DaysLoading extends Weather3DaysState {}

class Weather3DaysLoaded extends Weather3DaysState {
  final ThreeDaysWeatherModel weatherModel;
  const Weather3DaysLoaded(this.weatherModel);
}

class Weather3DaysError extends Weather3DaysState {
  final String? message;
  const Weather3DaysError(this.message);
}