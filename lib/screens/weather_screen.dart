import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex_test/bloc/weather/weather_bloc.dart';
import 'package:friflex_test/screens/start_screen.dart';
import 'package:friflex_test/screens/three_days_weather_screen.dart';

// WeatherScreen принимает название города и передает его дальше в State
class WeatherScreen extends StatefulWidget {
  final String cityName;

  const WeatherScreen({ required this.cityName });

  @override
  State<WeatherScreen> createState() => _WeatherScreenState(cityName);
}

class _WeatherScreenState extends State<WeatherScreen> {
  // Создаем переменные, которые будут присвоены позже в конструкторе
  late String _cityName;
  late WeatherBloc _weatherBloc;

  // В конструкторе инициализруем WeatherBloc и сохраняем его экземпляр в переменную
  // И сохраняем название города в cityName 
  _WeatherScreenState(String cityName) {
    _weatherBloc = WeatherBloc(cityName);
    _cityName = cityName;

    // Вызываем событие GetWeather, которое запустит запрос на получение погоды
    _weatherBloc.add(GetWeather());
  }

  // Событие левой кнопки NavigationBar, которое вернет нас на экран ввода города
  void _onPressedLeading() {
    // Перекидываем на первый экран и очищаем стэк навигатора
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => const StartScreen()),
      (r) => false,
    );
  }

  // Событие правой кнопки NavigationBar, которое перекинет нас на экран со списком погоды на 3 дня
  void _onPressedTrailing() {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => ThreeDaysWeatherScreen(cityName: _cityName)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Используем блок-провайдер для работы с WeatherBloc
    return BlocProvider<WeatherBloc>(
      create: (context) => _weatherBloc,
      child: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          // Отслеживаем текущий state, в случае, если state является WeatherError, показываем Alert с ошибкой и кнопкой для возврата на первый экран
          if (state is WeatherError) {
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text(state.message ?? 'Ошибка'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('OK'),
                      // При нажатии на кнопку очищаем стэк экранов и перекидываем пользователя на первый экран
                      onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(builder: (context) => const StartScreen()),
                        (r) => false,
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
        // Используем BlocBuilder для передачи state в _buildWeather
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: _buildWeather
        ),
      )
    );
  }

  Widget _buildWeather(BuildContext context, WeatherState state) {
    // Если state является WeatherLoaded, то в нем хранится свойство weatherModel, в котором сохранены данные о погоде
    final mainData = state is WeatherLoaded ? state.weatherModel.main : null;
    final windData = state is WeatherLoaded ? state.weatherModel.wind : null;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false, // Отключаем переход между экранами при помощи жестов
        middle: Text('Погода ${_cityName.toUpperCase()}'), // Указываем в заголовке текущий город
        leading: CupertinoNavigationBarBackButton(onPressed: _onPressedLeading), // Левая кнопка
        trailing: CupertinoButton( // Правая кнопка
          padding: const EdgeInsets.only(bottom: 0, right: 10),
          child: const Icon(CupertinoIcons.calendar),
          onPressed: _onPressedTrailing,
        ),
      ),

      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              // Показываем крыпным шрифтом температуру погоды или прочерк
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 5, bottom: 15),
                child: Text(
                  '${mainData?.temp ?? '—'}°', 
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w600,
                    color: CupertinoColors.systemIndigo,
                  )
                ),
              ),

              // Показываем значения влажности или прочерк
              Row(
                // По горизонтале прибиваем элементы к краям
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Центрируем элементы по вертикали
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  const Text(
                    'Влажность',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      color: CupertinoColors.black,
                    ),
                  ),

                  Text(
                    '${mainData?.humidity ?? '—'}%',
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 34,
                      color: CupertinoColors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 2),

              // Реализовано аналогично с предыдущим Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  const Text(
                    'Скорость ветра',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      color: CupertinoColors.black,
                    ),
                  ),

                  Text(
                    '${windData?.speed ?? '—'}м/с',
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 34,
                      color: CupertinoColors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      )
    );
  }
}
