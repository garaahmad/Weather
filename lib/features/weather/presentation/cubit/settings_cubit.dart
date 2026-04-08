import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:globalweather/features/weather/data/repositories/settings_repository.dart';
import 'package:globalweather/features/weather/data/services/local_notification_service.dart';

class SettingsState {
  final TemperatureUnit unit;
  final bool notificationsEnabled;

  const SettingsState({
    required this.unit,
    required this.notificationsEnabled,
  });
}

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository repository;

  SettingsCubit({required this.repository})
      : super(const SettingsState(
          unit: TemperatureUnit.celsius,
          notificationsEnabled: false,
        ));

  Future<void> loadSettings() async {
    final unit = await repository.getTemperatureUnit();
    final notificationsEnabled = await repository.getNotificationsEnabled();
    emit(SettingsState(
      unit: unit,
      notificationsEnabled: notificationsEnabled,
    ));
  }

  Future<void> setTemperatureUnit(TemperatureUnit unit) async {
    await repository.saveTemperatureUnit(unit);
    emit(SettingsState(
      unit: unit,
      notificationsEnabled: state.notificationsEnabled,
    ));
  }

  Future<void> toggleNotifications(bool enabled) async {
    await repository.saveNotificationsEnabled(enabled);
    if (enabled) {
      await LocalNotificationService.enablePeriodicNotifications();
    } else {
      await LocalNotificationService.disablePeriodicNotifications();
    }
    emit(SettingsState(
      unit: state.unit,
      notificationsEnabled: enabled,
    ));
  }
}
