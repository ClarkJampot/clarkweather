import 'package:flutter/material.dart';
import 'package:test_clima_flutter/screens/city_screen.dart';
import 'package:test_clima_flutter/utilities/constants.dart';
import 'dart:convert';
import 'package:test_clima_flutter/services/weather.dart';
import 'package:test_clima_flutter/services/networking.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.data, {super.key});
  final String data;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double temp = 0, feelsLike = 0, humidity = 0;
  String city = '', info = '', weatherIcon = '', weatherMessage = '';
  int id = 0;
  String backgroundUrl = '';

  @override
  void initState() {
    super.initState();
    info = widget.data;
    updateUI(info);
  }

  void updateUI(String weatherData) async {
    setState(() {
      if (weatherData == "Error") {
        temp = double.nan;
        feelsLike = double.nan;
        humidity = double.nan;
        city = "";
        id = 0;
        weatherMessage = "Cannot find data in city";
        weatherIcon = "🤷‍";
      } else {
        var data = jsonDecode(weatherData);
        temp = data['main']['temp'].toDouble();
        feelsLike = data['main']['feels_like'].toDouble();
        humidity = data['main']['humidity'].toDouble();
        city = data['name'];
        id = data['weather'][0]['id'];
        WeatherModel weatherModel = WeatherModel();
        weatherIcon = weatherModel.getWeatherIcon(id);
        weatherMessage = weatherModel.getMessage(temp.toInt(), city);

        // Fetch background image based on weather condition
        Networking networking = Networking();
        networking.fetchBackgroundImage(weatherModel.getWeatherPrompt(id)).then((url) {
          setState(() {
            backgroundUrl = url;
          });
        }).catchError((error) {
          print('Failed to load background image: $error');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundUrl.isNotEmpty
                ? NetworkImage(backgroundUrl) as ImageProvider<Object>
                : const AssetImage('images/location_background.jpg') as ImageProvider<Object>,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildTopButtons(),
              buildTemperatureInfo(),
              buildAdditionalInfo(),
              buildWeatherMessage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopButtons() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildIconButton(Icons.near_me, () async {
            String weatherData = await Networking().getLocationWeather();
            updateUI(weatherData);
          }),
          buildIconButton(Icons.location_city, () async {
            var newCity = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CityScreen()),
            );
            if (newCity != null && newCity.isNotEmpty) {
              String weatherData = await Networking().getCityWeather(newCity);
              updateUI(weatherData);
            } else {
              updateUI("Error");
            }
          }),
        ],
      ),
    );
  }

  Widget buildIconButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, size: 40.0),
      onPressed: onPressed,
      color: Colors.white,
    );
  }

  Widget buildTemperatureInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                temp.isNaN ? 'Error' : '${temp.toStringAsFixed(0)}°',
                style: kTempTextStyle,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                weatherIcon,
                style: kConditionTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAdditionalInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Feels Like: ${feelsLike.isNaN ? 'Error' : '${feelsLike.toStringAsFixed(0)}°'}',
            style: kMessageTextStyle.copyWith(fontSize: 20.0),
          ),
          const SizedBox(height: 10.0),
          Text(
            'Humidity: ${humidity.isNaN ? 'Error' : '${humidity.toStringAsFixed(0)}%'}',
            style: kMessageTextStyle.copyWith(fontSize: 20.0),
          ),
        ],
      ),
    );
  }

  Widget buildWeatherMessage() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, bottom: 20.0),
      child: Text(
        weatherMessage,
        textAlign: TextAlign.right,
        style: kMessageTextStyle.copyWith(fontSize: 24.0), // Increase the font size
        softWrap: true,
        overflow: TextOverflow.visible,
      ),
    );
  }
}
