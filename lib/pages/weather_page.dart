import "package:flutter/material.dart";
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
            backgroundColor: Colors.blue,
            body: Center(
              child: Column(
                children: [
                  // CIDADE
                  Text(_weather?.cityName ?? ""),

                  // TEMPERATURA
                  Text("${_weather?.temperature.round()}°C"),
                ],
              ),
            )));
  }
}
