import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:globalweather/features/weather/presentation/pages/weather_page.dart';
import 'package:globalweather/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:globalweather/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:globalweather/features/weather/domain/usecases/get_weather.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_cubit.dart';

void main() {
  final http.Client httpClient = http.Client();
  final WeatherRemoteDataSourceImpl remoteDataSource =
      WeatherRemoteDataSourceImpl(client: httpClient);
  final WeatherRepositoryImpl repository =
      WeatherRepositoryImpl(remoteDataSource: remoteDataSource);
  final GetWeatherUseCase fetchWeather = GetWeatherUseCase(repository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>(
          create: (context) => WeatherCubit(getWeatherUseCase: fetchWeather)
            ..fetchWeather('London'), // Initial fetch
        ),
      ],
      child: const MyApp(),
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
