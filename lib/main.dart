import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:globalweather/features/weather/presentation/pages/weather_page/weather_page.dart';
import 'package:globalweather/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:globalweather/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:globalweather/features/weather/domain/usecases/get_weather.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:globalweather/features/weather/data/repositories/settings_repository.dart';
import 'package:globalweather/features/weather/presentation/cubit/settings_cubit.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  final http.Client httpClient = http.Client();
  final WeatherRemoteDataSourceImpl remoteDataSource =
      WeatherRemoteDataSourceImpl(client: httpClient);
  final WeatherRepositoryImpl repository =
      WeatherRepositoryImpl(remoteDataSource: remoteDataSource);
  final GetWeatherUseCase fetchWeather = GetWeatherUseCase(repository);

  final SettingsRepository settingsRepository = SettingsRepository();

  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<SettingsCubit>(
              create: (context) => SettingsCubit(repository: settingsRepository)..loadSettings(),
            ),
            BlocProvider<WeatherCubit>(
              create: (context) => WeatherCubit(getWeatherUseCase: fetchWeather)
                ..fetchWeather('London'),
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
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Inter',
      ),
      home: const WeatherPage(),
    );
  }
}
