import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex_test/bloc/weather_3_days/weather_3_days_bloc.dart';
import 'package:friflex_test/constants/weekdays.dart';
import 'package:intl/intl.dart';

class ThreeDaysWeatherScreen extends StatefulWidget {
  final String cityName;

  const ThreeDaysWeatherScreen({ required this.cityName });

  @override
  State<ThreeDaysWeatherScreen> createState() => _ThreeDaysWeatherScreenState(cityName);
}

class _ThreeDaysWeatherScreenState extends State<ThreeDaysWeatherScreen> {
  late String _cityName;
  late Weather3DaysBloc _weatherBloc;

  _ThreeDaysWeatherScreenState(String cityName) {
    _weatherBloc = Weather3DaysBloc(cityName);
    _cityName = cityName;

    // Вызываем событие GetWeatherFor3Days, которое запустит запрос получения погоды за 3 дня
    _weatherBloc.add(GetWeatherFor3Days());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<Weather3DaysBloc>(
      create: (context) => _weatherBloc,
      child: BlocListener<Weather3DaysBloc, Weather3DaysState>(
        listener: (context, state) {
          if (state is Weather3DaysError) {
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text(state.message ?? 'Ошибка'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('OK'),
                      // При нажатии на кнопку "ОК" возвращаемся на второй экран
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                );
              },
            );
          }
        },
        // Используем BlocBuilder для передачи state в _buildThreeDaysWeather
        child: BlocBuilder<Weather3DaysBloc, Weather3DaysState>(
          builder: _buildThreeDaysWeather
        ),
      ),
    );
  }

  Widget _buildThreeDaysWeather(BuildContext context, Weather3DaysState state) {
    // Если данные погоды загружены, то сохраняем список погоды за 3 дня в listWeathers
    final listWeathers = state is Weather3DaysLoaded ? state.weatherModel.list : null;

    // Сортируем массив с погодой по возрастанию температуры
    listWeathers?.sort((a, b) {
      if (a.main?.temp == null) return 1;
      if (b.main?.temp == null) return -1;

      return a.main!.temp!.compareTo(b.main!.temp!);
    });
    
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('3 дня ${_cityName.toUpperCase()}'), // Записываем название города в заголовок
      ),
      child: Container(
        // Добавляем паддинги вокруг списка
        padding: const EdgeInsetsDirectional.only(start: 10, end: 10, top: 20),
        // Используем ListView.separated, чтобы добавить разделитель между элементами списка
        child: ListView.separated(
          // Передаем количество элементов списка для корректной работы itemBuilder
          itemCount: listWeathers?.length ?? 0,
          // Добавляем разделитель
          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20),
          // Прописываем itemBuilder, который будет рендерить данные погоды для каждого элемента списка по его индексу
          itemBuilder: (BuildContext context, int index) {
            // Получаем текущий элемент списка погоды
            final weather = listWeathers?[index];

            // Переводим timestamp в формат дня недели и с помощью константы weekdays руссифицируем значение
            final DateTime? date = (
              weather?.dt != null
                ? DateTime.fromMillisecondsSinceEpoch((weather?.dt as int) * 1000)
                : null
            );
            final String? formatedDate =
              date != null ? DateFormat.E().format(date).toLowerCase() : null;
            final String? dateOnRussian = formatedDate != null ? weekdays[formatedDate] : null;

            return Container(
              height: 100,
              padding: const EdgeInsetsDirectional.all(8),
              decoration: BoxDecoration( // Устанавливаем цвет и закругление элемента списка
                borderRadius: BorderRadius.circular(10),
                color: CupertinoColors.extraLightBackgroundGray,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dateOnRussian ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )
                  ),

                  // Выводим данные о погоде или прочерки, в случае их отсутствия
                  Column(
                    children: [
                      Text(
                        '${weather?.main?.temp?.round().toString() ?? '—'}°',
                        style: const TextStyle(
                          fontSize: 32,
                          color: CupertinoColors.activeBlue
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text('${weather?.main?.humidity?.toString() ?? '—'}%'),
                      Text('${weather?.wind?.speed?.round().toString() ?? '—'} м/с'),
                    ],
                  ),
                ],
              )
            );
          },
        ),
      )
    );
  }
}
