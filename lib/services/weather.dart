import 'package:clima/location.dart';
import 'package:clima/services/networking.dart';

const apikey = '0b438b0386c8a8c55f371efd0281bf02';

class WeatherModel {
  Future GetWeatherDataByCityName(String cityname) async {
    Networking networking = Networking(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$apikey&units=metric');
    var weatherdata = await networking.GetWeatherData();
    return weatherdata;
  }

  Future GetWeatherDataFromCurrentLocation() async {
    Location loc = Location();
    await loc.getCurrentLocation();
    Networking networking = Networking(
        'https://api.openweathermap.org/data/2.5/weather?lat=${loc.latitude}&lon=${loc.longitude}&appid=$apikey&units=metric');

    var weatherdata = await networking.GetWeatherData();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
