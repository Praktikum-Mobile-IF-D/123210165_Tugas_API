import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class DetailPage extends StatelessWidget {
  final String locationName;
  final Map<String, dynamic> weatherData;

  DetailPage(this.locationName, this.weatherData);

  @override
  Widget build(BuildContext context) {
    final currentWeather = weatherData;
    final weatherMain = currentWeather['main'];
    final weatherDescription = currentWeather['weather'][0]['description'];
    final temp = weatherMain['temp'];
    final feelsLike = weatherMain['feels_like'];
    final humidity = weatherMain['humidity'];
    final windSpeed = currentWeather['wind']['speed'];

    IconData weatherIcon;
    switch (currentWeather['weather'][0]['main'].toLowerCase()) {
      case 'clear':
        weatherIcon = WeatherIcons.day_sunny;
        break;
      case 'clouds':
        weatherIcon = WeatherIcons.cloudy;
        break;
      case 'rain':
        weatherIcon = WeatherIcons.rain;
        break;
      case 'thunderstorm':
        weatherIcon = WeatherIcons.thunderstorm;
        break;
      case 'snow':
        weatherIcon = WeatherIcons.snow;
        break;
      default:
        weatherIcon = WeatherIcons.day_sunny_overcast;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cuaca di $locationName'),
        backgroundColor: Colors
            .blueGrey[700], // Warna yang lebih gelap untuk kesan profesional
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              weatherIcon,
              size: 100,
              color: Colors.orange, // Warna cerah untuk ikon utama
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4, // Beri efek bayangan
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Sudut melengkung
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kondisi Cuaca',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8), // Jarak antar elemen
                    Text(
                      'Deskripsi: $weatherDescription',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Suhu: $temp°C',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Terasa seperti: $feelsLike°C',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.water_drop, size: 24, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          'Kelembapan: $humidity%',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.air, size: 24, color: Colors.green),
                        SizedBox(width: 8),
                        Text(
                          'Kecepatan angin: $windSpeed m/s',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
