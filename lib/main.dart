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

  String _cityName = '';
  String _temperature = '';
  String _weatherCondition = '';

  List<DailyForecast> _forecast = [];

  final Random _random = Random();

  final List<String> _conditions = ["Sunny", "Cloudy", "Rainy"];

  int _getRandomTemperature() => 15 + _random.nextInt(16);

  String _getRandomCondition() => _conditions[_random.nextInt(_conditions.length)];

  void _fetchForecast() {
    List<DailyForecast> forecast = [];
    for (int i = 0; i < 7; i++) {

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

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Divider(height: 40),

              ElevatedButton(
                onPressed: _fetchForecast,
                child: Text("Fetch 7-Day Forecast"),
              ),
              SizedBox(height: 20),

              Text(
                "7-Day Forecast:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _forecast.length,
                itemBuilder: (context, index) {
                  DailyForecast dayForecast = _forecast[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(dayForecast.day.split(' ').last),
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




