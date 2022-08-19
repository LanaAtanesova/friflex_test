import 'package:flutter/cupertino.dart';
import 'package:friflex_test/constants/shared_preferences.dart';
import 'package:friflex_test/screens/weather_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Экран с вводом названия города
class StartScreen extends StatefulWidget {
  const StartScreen({ Key? key }) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  String? _cityName;
  SharedPreferences? prefs;

  // Инициализируем SharedPreferences при первом рендеринге
  @override
  void initState() {
    initializePreference();
    super.initState();
  }

 // Создаем метод для инициализации SharedPreferences
  Future<void> initializePreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Метод, который записывает значение из инпута в _cityName
  void onChangedCityName(String value) => _cityName = value;

  // Вызывается при нажатии на кнопку "Подтвердить"
  void onConfirm() async {
    if (_cityName is String && _cityName!.length >= 3) {
      // Если _cityName задан и его длина больше 2 символов, записываем его значение в prefs под ключом city_name
      prefs?.setString(cityNameKey, _cityName as String);

      // Переходим на экран WeatherScreen и передаем туда название города
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => WeatherScreen(cityName: _cityName as String)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Введите город'),
        transitionBetweenRoutes: false,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Center(

          // Помещаем все элементы в колонку и центрируем по вертикали
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: const [
                  Text(
                    'Введите город, который вас интересует',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 4,),

                  // Создаем текст и стилизуем в нем название городов
                  Text.rich(
                    TextSpan(
                      style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                      children: [
                        TextSpan(text: 'Например, '),
                        TextSpan(
                          text: 'Tbilisi',
                          style: TextStyle(color: CupertinoColors.activeBlue)
                        ),
                        TextSpan(text: ' или '),
                        TextSpan(
                          text: 'Москва',
                          style: TextStyle(color: CupertinoColors.activeBlue)
                        ),
                      ]
                    )
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Создаем текстовое поле с автофокусировкой при переходе на экран
              CupertinoTextField(
                placeholder: 'Название города',
                autofocus: true,
                onChanged: onChangedCityName,
              ),

              const SizedBox(height: 40),

              CupertinoButton(
                child: const Text('Подтвердить'),
                onPressed: onConfirm,
              ),
            ],
          )
        ),
      )
    );
  }
}