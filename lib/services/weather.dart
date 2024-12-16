import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/networking.dart';

const apiKey = '';
const myUrl = 'http://api.openweathermap.org/geo/1.0/reverse';

class WeatherModel {
  Future<dynamic> getWeatherData() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    // NetworkHelper networkHelper = NetworkHelper(
    //     '$myUrl?lat=${position.latitude}&lon=${position.longitude}&limit={limit}&appid=$apiKey&units=metric');
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/3.0/onecall/timemachine?lat=${position.latitude}&lon=${position.longitude}&dt={time}&appid=2a14a4be9b695f06fb2be8048e9e585f');
    var weatherData = await networkHelper.getData();

    return weatherData;
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
