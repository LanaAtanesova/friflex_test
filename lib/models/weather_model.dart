// Результат запроса
// https://api.openweathermap.org/data/2.5/weather?q=${cityName}&units=metric&appid=${apiKey}

// Модель получена с помощью https://javiercbk.github.io/json_to_dart

class WeatherModel {
  List<Weather>? weather;
  Main? main;
  Clouds? clouds;
  Coord? coord;
  Wind? wind;
  Sys? sys;
  String? base;
  String? name;
  String? error;
  int? visibility;
  int? dt;
  int? timezone;
  int? id;
  int? cod;

  WeatherModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  WeatherModel.withError(this.error);

  WeatherModel.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;

    if (json['weather'] != null) {
      weather = <Weather>[];

      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }

    base = json['base'];
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    visibility = json['visibility'];
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
    clouds = json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null;
    dt = json['dt'];
    sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (coord != null) data['coord'] = coord!.toJson();
    if (weather != null) data['weather'] = weather!.map((v) => v.toJson()).toList();
    
    data['base'] = base;

    if (main != null) data['main'] = main!.toJson();
    
    data['visibility'] = visibility;
    
    if (wind != null) data['wind'] = wind!.toJson();
    if (clouds != null) data['clouds'] = clouds!.toJson();
    
    data['dt'] = dt;

    if (sys != null) data['sys'] = sys!.toJson();

    data['timezone'] = timezone;
    data['id'] = id;
    data['name'] = name;
    data['cod'] = cod;

    return data;
  }
}

class Coord {
  double? lon;
  double? lat;

  Coord({ this.lon, this.lat });

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon']?.toDouble();
    lat = json['lat']?.toDouble();
  }

  Map<String, dynamic> toJson() => ({
    'lon': lon,
    'lat': lat,
  });
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({ this.id, this.main, this.description, this.icon });

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() => ({
    'id': id,
    'main': main,
    'description': description,
    'icon': icon,
  });
}

class Main {
  int? temp;
  int? feelsLike;
  int? tempMin;
  int? tempMax;
  int? pressure;
  int? humidity;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp']?.round();
    feelsLike = json['feels_like']?.round();
    tempMin = json['temp_min']?.round();
    tempMax = json['temp_max']?.round();
    pressure = json['pressure']?.round();
    humidity = json['humidity']?.round();
  }

  Map<String, dynamic> toJson() => ({
    'temp': temp,
    'feels_like': feelsLike,
    'temp_min': tempMin,
    'temp_max': tempMax,
    'pressure': pressure,
    'humidity': humidity,
  });
}

class Wind {
  double? speed;
  int? deg;
  double? gust;

  Wind({ this.speed, this.deg, this.gust });

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed']?.toDouble();
    deg = json['deg'];
    gust = json['gust'];
  }

  Map<String, dynamic> toJson() => ({
    'speed': speed,
    'deg': deg,
    'gust': gust,
  });
}

class Clouds {
  int? all;

  Clouds({ this.all });

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }

  Map<String, dynamic> toJson() => ({ 'all': all });
}

class Sys {
  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;

  Sys({ this.type, this.id, this.country, this.sunrise, this.sunset });

  Sys.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() => ({
    'type': type,
    'id': id,
    'country': country,
    'sunrise': sunrise,
    'sunset': sunset,
  });
}
