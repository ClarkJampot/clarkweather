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

  String getWeatherPrompt(int condition) {
    if (condition < 300) {
      return 'thunderstorm with lightning background';
    } else if (condition < 400) {
      return 'light drizzle with grey sky background';
    } else if (condition < 600) {
      return 'rainy day with puddles background';
    } else if (condition < 700) {
      return 'snowy winter landscape background';
    } else if (condition < 800) {
      return 'foggy morning background';
    } else if (condition == 800) {
      return 'clear blue sky with sun background';
    } else if (condition <= 804) {
      return 'partly cloudy sky background';
    } else {
      return 'weather background';
    }
  }
}
