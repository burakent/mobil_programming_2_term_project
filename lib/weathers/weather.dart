import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:final_project/header.dart';
import 'weather_provider.dart';

class Weather extends StatelessWidget {
  final List<String> cities = [
    "London",
    "Ankara",
    "Istanbul",
    "Eskisehir",
    "Boston",
    "Tokio"
  ];

  Widget buildWeatherCard(Map<String, dynamic> data) {
    final location = data['location']['name'];
    final country = data['location']['country'];
    final status = data['current']['condition']['text'];
    final temperature = data['current']['temp_c'];
    const imageBaseUrl = 'http://cdn.weatherapi.com/weather/128x128/day/';
    const image = '${imageBaseUrl}113.png';
    const image2 = '${imageBaseUrl}116.png';
    const image3 = '${imageBaseUrl}122.png';
    const image4 = '${imageBaseUrl}248.png';

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            leading: status == 'Sunny'
                ? Image.network(image)
                : status == 'Partly cloudy'
                    ? Image.network(image2)
                    : status == 'Overcast'
                        ? Image.network(image3)
                        : Image.network(image4),
            title: Row(
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("$location \n$country"),
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${temperature} C",
                      style: TextStyle(fontSize: 23),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: Column(
        children: [
          for (var city in cities)
            Expanded(
              child: Consumer(
                builder: (context, watch, _) {
                  final weatherAsyncValue = watch(weatherProvider.family(city).future);
                  return weatherAsyncValue.when(
                    data: (data) => buildWeatherCard(data),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, stackTrace) => Text("Error: $error"),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
