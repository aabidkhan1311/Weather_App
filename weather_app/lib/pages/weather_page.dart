import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/weather_service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();

}

class _WeatherPageState extends State<WeatherPage> {
  
  final _weatherService = WeatherService('5326843a8ad0b7fd058e18535173dd4d');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;

      });
    }
      catch (e) {
        print(e);
      }

  }
  // weather animation
  String getWeatherAnimation(String? mainCondition) {
    if(mainCondition == null) return 'assets/sunny.json'; //default to sunny

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';

      case 'rian':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';

      case 'thunderstorm':
        return 'assets/thunder.json';

      case 'clear':
        return 'assets/sunny.json';

      default:
        return 'assets/sunny.json';
    }
  }

  //init state
  @override
  void initState(){
    super.initState();
    
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,



        children: [
          Text(
            _weather?.cityName ?? "loading city..",
            style: TextStyle(color: Colors.yellow[900],fontWeight: FontWeight.bold,
                fontSize: 25),

          ),

          //animation
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
          //temperature
          Text('${_weather?.temperature.round()}°C',
            style: TextStyle(color: Colors.yellow[900], fontWeight: FontWeight.bold,
            fontSize: 35),
          ),

          //weather condition
          Text(_weather?.mainCondition ?? "",
            style: TextStyle(color: Colors.white),
          )
        ] ,
      ),
    )
    );
  }
}