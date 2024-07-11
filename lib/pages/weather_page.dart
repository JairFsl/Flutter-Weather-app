import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:weather_app/models/weather_model.dart";
import "package:weather_app/services/weather_service.dart";

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // API KEY
  final _weatherService = WeatherService("3f6657eb15c6c0c82b499949f4fc3ff9");
  Weather? _weather;

  // Requisição do clima
  _getWeather() async {
    // Pega a cidade atual do Usuário
    String cityName = await _weatherService.getCurrentyCity();

    // Pega o clima da cidade atual do Usuário
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // Animações
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return "assets/sunny.json";
    }

    switch (mainCondition.toLowerCase()) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "assets/cloud.json";

      case "rain":
      case "drizzle":
      case "shower rain":
        return "assets/rain.json";
      case "thunderstorm":
        return "aseets/heavy_rain.json";
      case "clear":
        return "assets/sunny.json";
      default:
        return "assets/sunny.json";
    }
  }

  // Inicialização do State
  @override
  void initState() {
    super.initState();
    _getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 212, 212, 212),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        size: 40,
                        color: Colors.black,
                      ),
                      Text(_weather?.cityName ?? "",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ],
                  ),
                  // CIDADE

                  // ANIMAÇÃO
                  Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

                  // TEMPERATURA
                  Text(
                    "${_weather?.temperature.round()}°C",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )));
  }
}
