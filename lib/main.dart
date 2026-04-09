import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import 'package:globalweather/app_router.dart';
import 'package:globalweather/firebase_options.dart';
import 'package:globalweather/features/location/data/repositories/location_repository_impl.dart';
import 'package:globalweather/features/location/data/services/fcm_topic_service.dart';
import 'package:globalweather/features/location/presentation/bloc/location_bloc.dart';
import 'package:globalweather/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:globalweather/features/weather/data/repositories/settings_repository.dart';
import 'package:globalweather/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:globalweather/features/weather/domain/usecases/get_weather.dart';
import 'package:globalweather/features/weather/presentation/cubit/settings_cubit.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:globalweather/features/weather/data/services/local_notification_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  await LocalNotificationService.initialize();

  final httpClient = http.Client();
  final remoteDataSource = WeatherRemoteDataSourceImpl(client: httpClient);
  final weatherRepository = WeatherRepositoryImpl(remoteDataSource: remoteDataSource);
  final getWeatherUseCase = GetWeatherUseCase(weatherRepository);

  final locationRepository = LocationRepositoryImpl();
  final fcmTopicService = FcmTopicService();
  await fcmTopicService.requestNotificationPermission();

  final settingsRepository = SettingsRepository();

  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<LocationBloc>(
              create: (_) => LocationBloc(
                repository: locationRepository,
                fcmTopicService: fcmTopicService,
              ),
            ),
            BlocProvider<WeatherCubit>(
              create: (_) => WeatherCubit(getWeatherUseCase: getWeatherUseCase),
            ),
            BlocProvider<SettingsCubit>(
              create: (_) => SettingsCubit(repository: settingsRepository)
                ..loadSettings(),
            ),
          ],
          child: const MyApp(),
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GlobalWeather',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Inter',
      ),
      home: const AppRouter(),
    );
  }
}

