abstract class AppAssets {
  static const logo = "assets/icons/logo.svg";
  static const drop = "assets/icons/drop.svg";
  static const temp = "assets/icons/temp.svg";
  static const sun = "assets/icons/sun.svg";
  static const moon = "assets/icons/moon.svg";
  static const cloudy = "assets/icons/cloudy.svg";
  static const sunny = "assets/icons/sunny.svg";
  static const rainy = "assets/icons/rainy.svg";
  static const dash = "assets/icons/dash.svg";

  static String weatherImage (WeatherState? state) {
    switch (state) {
      case WeatherState.sunny:
        return sunny;
      case WeatherState.cloudy:
        return cloudy;
      case WeatherState.rainy:
        return rainy;
      case WeatherState.moon:
        return moon;
      
      default:
        return dash;
    }
    
  }
}
enum WeatherState {
  sunny,
  cloudy,
  rainy,
  moon,
  dash
}