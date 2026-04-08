import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;
import 'package:globalweather/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:globalweather/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:globalweather/features/location/data/repositories/location_repository_impl.dart';

const fetchWeatherTask = 'fetchWeatherTask';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      final locationRepository = LocationRepositoryImpl();
      final savedLocation = await locationRepository.getSavedLocation();

      if (savedLocation != null) {
        final httpClient = http.Client();
        final remoteDataSource = WeatherRemoteDataSourceImpl(client: httpClient);
        final weatherRepository = WeatherRepositoryImpl(remoteDataSource: remoteDataSource);
        
        final weather = await weatherRepository.getWeatherByCoords(
          savedLocation.latitude, 
          savedLocation.longitude
        );

        await LocalNotificationService.showWeatherNotification(
          title: 'Weather Update: ${weather.cityName}',
          body: '${weather.temperature.round()}°C, ${weather.condition}. Hum: ${weather.humidity}%',
        );
      }
    } catch (_) {}
    return Future.value(true);
  });
}

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true);

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    try {
      await _localNotificationsPlugin.initialize(
        settings: initializationSettings,
      );
    } catch (_) {}

    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );
  }

  static Future<void> showWeatherNotification({required String title, required String body}) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'weather_channel',
      'Weather Updates',
      channelDescription: 'Periodic weather updates every 5 hours',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await _localNotificationsPlugin.show(
      id: 0, 
      title: title,
      body: body,
      notificationDetails: platformDetails,
    );
  }

  static Future<void> enablePeriodicNotifications() async {
    await Workmanager().registerPeriodicTask(
      '1', // unique id
      fetchWeatherTask,
      frequency: const Duration(hours: 5),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      initialDelay: const Duration(minutes: 1),
    );
  }

  static Future<void> disablePeriodicNotifications() async {
    await Workmanager().cancelByUniqueName('1');
  }
}
