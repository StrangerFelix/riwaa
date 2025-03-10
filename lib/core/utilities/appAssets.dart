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
  static const scan = "assets/icons/scan.svg";
  static const user = "assets/icons/user.svg";
  static const notifications = "assets/icons/notifications.svg";
  static const tempunit = "assets/icons/tempunit.svg";

  static String navBarIcon (int index,bool isactive) {
    switch (index) {
      case 0:
        return isactive ? "assets/icons/home_active.svg" : "assets/icons/home.svg";
      case 1:
        return isactive ? "assets/icons/logs_active.svg" : "assets/icons/logs.svg";
      case 2:
        return isactive ? "assets/icons/notifications_active.svg" : "assets/icons/notifications.svg";
      case 3:
        return isactive ? "assets/icons/settings_active.svg" : "assets/icons/settings.svg";
      default:
        return "assets/icons/dash.svg";
    }
  }

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