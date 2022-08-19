import 'package:flutter/cupertino.dart';
import 'package:friflex_test/constants/shared_preferences.dart';
import 'package:friflex_test/screens/start_screen.dart';
import 'package:friflex_test/screens/weather_screen.dart';
import 'package:friflex_test/widgets/preloader.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

// Создаем корневой Statefull виджет MyApp
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences? prefs;
  String? _cityName;
  bool loading = true;

  // Ожидаем инициализации SharedPreferences 
  // и после этого проверяем наличие сохраненного в нем города
  // записываем его в _cityname и записываем в loading false
  @override
  void initState() {
    initializePreference().whenComplete(() {
      setState(() {
        _cityName = prefs?.getString(cityNameKey);
        loading = false;
      });
    });

    super.initState();
  }

  // Создаем метод для инициализации SharedPreferences
  Future<void> initializePreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Пока loading = false показываем Preloader
  @override
  Widget build(context) {
    if (loading) return const Preloader();

    return _buildApp();
  }

  Widget _buildApp() {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      // Если в _cityname есть сохраненный город - отображаем WeaherScreen и передаем туда значение
      // Если же нет - отображаем StartScreen (экран с вводом города)
      home: _cityName is String ? WeatherScreen(cityName: _cityName as String) : const StartScreen(),
    );
  }
}
