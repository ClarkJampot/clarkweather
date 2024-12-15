class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '⛈️'; // Thunderstorm
    } else if (condition < 400) {
      return '🌧️'; // Drizzle
    } else if (condition < 600) {
      return '🌦️'; // Rain
    } else if (condition < 700) {
      return '❄️'; // Snow
    } else if (condition < 800) {
      return '🌫️'; // Atmosphere (fog, mist, etc.)
    } else if (condition == 800) {
      return '☀️'; // Clear
    } else if (condition <= 804) {
      return '☁️'; // Clouds
    } else {
      return '🌍'; // Unknown
    }
  }

  String getMessage(int temp, String city) {
    if (temp > 30) {
      return 'It\'s scorching hot in $city! 🌞 Stay hydrated and wear light clothing.';
    } else if (temp > 25) {
      return 'It\'s a warm day in $city. Perfect for some ice cream! 🍦';
    } else if (temp > 20) {
      return 'Nice weather in $city! Maybe a light T-shirt will do. 👕';
    } else if (temp > 10) {
      return 'It\'s a bit chilly in $city. A jacket would be nice. 🧥';
    } else if (temp > 0) {
      return 'Cold weather in $city. Time for a warm coat and gloves. 🧤';
    } else {
      return 'Brrr! It\'s freezing in $city! Stay warm with extra layers. 🧣';
    }
  }

  String getWeatherPrompt(int condition, double temp) {
    String tempDescription;
    if (temp > 30) {
      tempDescription = 'a screaming man burning alive in a';
    } else if (temp > 25) {
      tempDescription = 'a crowded beach in a';
    } else if (temp > 20) {
      tempDescription = 'a man wearing a t-shirt sitting on a bench while feeding birds in the park in a';
    } else if (temp > 10) {
      tempDescription = 'a man wearing a hoodie sitting on a ledge in a';
    } else if (temp > 0) {
      tempDescription = 'a man wearing a heavy jacket walking on the park in a';
    } else {
      tempDescription = 'a man freezing in ice in a';
    }

    if (condition < 300) {
      return '$tempDescription thunderstorm in the background';
    } else if (condition < 400) {
      return '$tempDescription light drizzle weather in the background';
    } else if (condition < 600) {
      return '$tempDescription rainy day background';
    } else if (condition < 700) {
      return '$tempDescription snowy landscape background';
    } else if (condition < 800) {
      return '$tempDescription foggy morning background';
    } else if (condition == 800) {
      return '$tempDescription clear blue sky with sun background';
    } else if (condition <= 804) {
      return '$tempDescription partly cloudy sky background';
    } else {
      return '$tempDescription weather background';
    }
  }
}
