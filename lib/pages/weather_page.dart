import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:online_shpping_app/sercvices/weather_service.dart';
import '../model/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // API key
  final _weatherService = WeatherService('257846e8aa0131c66f469a02e224f5b4');
  Weather? _weather;

  // Fetch weather
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      _weather = await _weatherService.getWeather(cityName);
      setState(() {
        // Remove this line as it is redundant
      });
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  // Weather animation
  String _getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/loading.json';

    switch (mainCondition) {
      case 'Clear':
        return 'assets/sunny.json';
      case 'Clouds':
      case 'Mist':
      case 'Smoke':
      case 'Haze':
        return 'assets/cloudy.json';
      case 'Rain':
      case 'Drizzle':
      case 'Tornado':
      case 'Fog':
      case 'Sand':
      case 'Ash':
      case 'Squall':
      case 'Dust':
        return 'assets/rainy.json';
      case 'Snow':
        return 'assets/snow.json';
      case 'Thunderstorm':
      case 'Thunder':
        return 'assets/thunder.json';
      default:
        return 'assets/loading.json';
    }
  }

  //init state
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
             iconTheme: const IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        centerTitle: true,
        title: const Text(
          'Clima App', style: TextStyle(fontFamily: 'gilroy', fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
        )
      ),
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //city name
              Text(
                _weather?.cityName ?? "loading city name..",
                style: TextStyle(
                    fontSize: 22.0, color: Color.fromARGB(255, 0, 0, 0)),
              ),

              //animation
              Lottie.asset(_getWeatherAnimation(_weather?.mainCondition)),

              //temperature
              Text(
                '${_weather?.temperature.round()}°C',
                style: TextStyle(
                    fontSize: 20.0, color: Color.fromARGB(255, 0, 0, 0)),
              ),
              //weather condition
              Text(
                '${_weather?.mainCondition ?? ""}',
              )
            ]),
      ),
    );
  }
}
