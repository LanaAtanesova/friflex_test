import 'package:friflex_test/models/weather_model.dart';

// Результат запроса
// https://api.openweathermap.org/data/2.5/forecast/hourly?q=${cityName}&units=metric&appid=${apiKey}

// Некоторые классы использованы из weather_model, т.к. аналогичны

// Модель получена с помощью https://javiercbk.github.io/json_to_dart

class ThreeDaysWeatherModel {
  City? city;
  List<WeathersList>? list;
  String? cod;
  String? error;
  int? message;
  int? cnt;

  ThreeDaysWeatherModel.withError(this.error);

  ThreeDaysWeatherModel({ this.cod, this.message, this.cnt, this.list, this.city });

  ThreeDaysWeatherModel.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];

    if (json['list'] != null) {
      list = <WeathersList>[];
      json['list'].forEach((v) {
        list!.add(WeathersList.fromJson(v));
      });
    }

    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'cod': cod,
      'message': message,
      'cnt': cnt,
    };

    if (list != null) data['list'] = list!.map((v) => v.toJson()).toList();
    if (city != null) data['city'] = city!.toJson();

    return data;
  }
}

class WeathersList {
  int? dt;
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  int? visibility;
  double? pop;
  Sys? sys;
  String? dtTxt;

  WeathersList({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.sys,
    this.dtTxt,
  });

  WeathersList.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    main = json['main'] != null ? Main.fromJson(json['main']) : null;

    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }

    clouds = json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null;
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
    visibility = json['visibility'];
    pop = json['pop'];
    sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;
    dtTxt = json['dt_txt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'dt': dt,
      'visibility': visibility,
      'pop': pop,
      'dt_txt': dtTxt,
    };

    if (main != null) data['main'] = main!.toJson();
    if (weather != null) data['weather'] = weather!.map((v) => v.toJson()).toList();
    if (clouds != null) data['clouds'] = clouds!.toJson();
    if (wind != null) data['wind'] = wind!.toJson();
    if (sys != null) data['sys'] = sys!.toJson();

    return data;
  }
}

class MainExtended extends Main {
  int? seaLevel;
  int? grndLevel;
  double? tempKf;

  MainExtended({ this.seaLevel, this.grndLevel, this.tempKf });

  MainExtended.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    pressure = json['pressure'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
    humidity = json['humidity'];
    tempKf = json['temp_kf'];
  }

  @override
  Map<String, dynamic> toJson() => ({
    'temp': temp,
    'feels_like': feelsLike,
    'temp_min': tempMin,
    'temp_max': tempMax,
    'pressure': pressure,
    'humidity': humidity,
    'sea_level': seaLevel,
    'grnd_level': grndLevel,
    'temp_kf': tempKf,
  });
}

class Sys {
  String? pod;

  Sys({ this.pod });

  Sys.fromJson(Map<String, dynamic> json) {
    pod = json['pod'];
  }

  Map<String, dynamic> toJson() => ({
    'pod': pod,
  });
}

class City {
  int? id;
  String? name;
  Coord? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
    country = json['country'];
    population = json['population'];
    timezone = json['timezone'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'name': name,
      'country': country,
      'population': population,
      'timezone': timezone,
      'sunrise': sunrise,
      'sunset': sunset,
    };
    
    if (coord != null) data['coord'] = coord!.toJson();
    
    return data;
  }
}

class Coord {
  int? lat;
  double? lon;

  Coord({ this.lat, this.lon });

  Coord.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() => ({
    'lat': lat,
    'lon': lon,
  });
}
