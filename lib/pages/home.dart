import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugasapi/pages/profile.dart';
import 'dart:convert';
import 'detail.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> locations = [
    {'name': 'Jakarta', 'lat': -6.2088, 'lon': 106.8456},
    {'name': 'Bandung', 'lat': -6.9175, 'lon': 107.6191},
    {'name': 'Surabaya', 'lat': -7.2575, 'lon': 112.7521},
    {'name': 'Semarang', 'lat': -6.9667, 'lon': 110.4167},
    {'name': 'Yogyakarta', 'lat': -7.7956, 'lon': 110.3695},
    {'name': 'Medan', 'lat': 3.5952, 'lon': 98.6722}, // Sumatera
    {'name': 'Palembang', 'lat': -2.9761, 'lon': 104.7754}, // Sumatera
    {'name': 'Pekanbaru', 'lat': 0.5333, 'lon': 101.45}, // Sumatera
    {'name': 'Pontianak', 'lat': -0.0277, 'lon': 109.3425}, // Kalimantan
    {'name': 'Samarinda', 'lat': -0.5021, 'lon': 117.1536}, // Kalimantan
    {'name': 'Makassar', 'lat': -5.1473, 'lon': 119.4327}, // Sulawesi
    {'name': 'Manado', 'lat': 1.4748, 'lon': 124.8421}, // Sulawesi
    {'name': 'Denpasar', 'lat': -8.6500, 'lon': 115.2167}, // Bali
    {'name': 'Mataram', 'lat': -8.5821, 'lon': 116.1165}, // Lombok
  ];

  Future<Map<String, dynamic>> fetchWeather(
      double latitude, double longitude) async {
    final apiKey = '49496189a38290778340cc3c30aca558'; // Pastikan API key valid
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to load weather data. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuaca di Indonesia'),
        backgroundColor:
            Colors.blueGrey[700], // Warna gelap untuk kesan profesional
        actions: [
          IconButton(
            icon: Icon(Icons.person), // Ikon untuk navigasi ke halaman profil
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          return FutureBuilder(
            future: fetchWeather(location['lat'], location['lon']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Card(
                  child: ListTile(
                    title: Text(location['name']),
                    subtitle: Text('Loading...'), // Indikator loading
                  ),
                );
              } else if (snapshot.hasError) {
                return Card(
                  child: ListTile(
                    title: Text(location['name']),
                    subtitle: Text('Error'), // Indikator error
                  ),
                );
              } else {
                final weatherData = snapshot.data;
                final temp = weatherData!['main']['temp'];

                return Card(
                  child: ListTile(
                    title: Text(location['name']),
                    subtitle: Text('Suhu: $temp°C'),
                    trailing: Text('Klik untuk lihat detail'), // Trailing text
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            location['name'],
                            weatherData,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
