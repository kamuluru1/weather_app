import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: WeatherScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();

  String _cityName = '';
  String _temperature = '';
  String _weatherCondition = '';

  void _fetchWeather() {
    final random = Random();
    int temp = 15 + random.nextInt(16);

    List<String> conditions = ['Sunny', 'Cloudy', 'Raining'];
    String condition = conditions[random.nextInt(conditions.length)];
    setState(() {
      _cityName = _cityController.text;
      _temperature = "$temp°C";
      _weatherCondition = "$condition";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: "Enter City Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: Text("Fetch Weather"),
            ),
            SizedBox(height: 20),
            Text(
              "City: $_cityName",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Temperature: $_temperature",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Condition: $_weatherCondition",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}



