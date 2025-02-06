import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // The root widget of your application.
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

// Model class for daily forecast details.
class DailyForecast {
  final String day;
  final int temperature;
  final String condition;

  DailyForecast({
    required this.day,
    required this.temperature,
    required this.condition,
  });
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();

  // Variables for current weather.
  String _cityName = '';
  String _temperature = '';
  String _weatherCondition = '';

  // List for 7-day forecast.
  List<DailyForecast> _forecast = [];

  // Random number generator.
  final Random _random = Random();

  // List of possible weather conditions.
  final List<String> _conditions = ["Sunny", "Cloudy", "Rainy"];

  // Generate a random temperature between 15 and 30.
  int _getRandomTemperature() => 15 + _random.nextInt(16);

  // Select a random weather condition.
  String _getRandomCondition() => _conditions[_random.nextInt(_conditions.length)];

  // Generate random forecast for 7 days.
  void _fetchForecast() {
    List<DailyForecast> forecast = [];
    for (int i = 0; i < 7; i++) {
      // For simplicity, we label the days as Day 1, Day 2, etc.
      String dayLabel = "Day ${i + 1}";
      forecast.add(DailyForecast(
        day: dayLabel,
        temperature: _getRandomTemperature(),
        condition: _getRandomCondition(),
      ));
    }
    setState(() {
      _forecast = forecast;
    });
  }

  // Generate current weather data.
  void _fetchWeather() {
    setState(() {
      _cityName = _cityController.text;
      int temp = _getRandomTemperature();
      _temperature = "$temp°C";
      _weatherCondition = _getRandomCondition();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
      ),
      body: SingleChildScrollView(
        // Using SingleChildScrollView to allow scrolling when forecast is displayed.
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input field for city name.
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: "Enter City Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              // Button to fetch current weather data.
              ElevatedButton(
                onPressed: _fetchWeather,
                child: Text("Fetch Weather"),
              ),
              SizedBox(height: 20),
              // Displaying current weather data.
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
              Divider(height: 40),
              // Button to fetch 7-day forecast.
              ElevatedButton(
                onPressed: _fetchForecast,
                child: Text("Fetch 7-Day Forecast"),
              ),
              SizedBox(height: 20),
              // UI section for the 7-day forecast.
              Text(
                "7-Day Forecast:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Display the forecast details.
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Let the outer scroll view handle scrolling.
                itemCount: _forecast.length,
                itemBuilder: (context, index) {
                  DailyForecast dayForecast = _forecast[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(dayForecast.day.split(' ').last), // Displays the day number.
                      ),
                      title: Text(dayForecast.day),
                      subtitle: Text("Condition: ${dayForecast.condition}"),
                      trailing: Text("${dayForecast.temperature}°C"),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}




