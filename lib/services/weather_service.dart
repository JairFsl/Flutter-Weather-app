import "dart:convert";

import "package:geocoding/geocoding.dart";
import "package:geolocator/geolocator.dart";
import "package:http/http.dart" as http;
import "../models/weather_model.dart";

class WeatherService {
  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse("$BASE_URL?q=$cityName&appid=$apiKey&units=metric"));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Erro ao carregar informações do clima");
    }
  }

  Future<String> getCurrentyCity() async {
    // Permissão de uso de Localização do Usuário
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Pega a posição atual do Usuário
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Converte a posição atual do Usuário em uma lista de Placemarks
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    // Pega o nome da cidade do Primeiro Placemark
    String? city = placemarks[0].locality;

    return city ?? "";
  }
}
