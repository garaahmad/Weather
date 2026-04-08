import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:globalweather/features/weather/data/repositories/settings_repository.dart';

class SettingsState {
  final TemperatureUnit unit;
  const SettingsState({required this.unit});
}

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository repository;

  SettingsCubit({required this.repository})
      : super(const SettingsState(unit: TemperatureUnit.celsius));

  Future<void> loadSettings() async {
    final unit = await repository.getTemperatureUnit();
    emit(SettingsState(unit: unit));
  }

  Future<void> setTemperatureUnit(TemperatureUnit unit) async {
    await repository.saveTemperatureUnit(unit);
    emit(SettingsState(unit: unit));
  }
}
