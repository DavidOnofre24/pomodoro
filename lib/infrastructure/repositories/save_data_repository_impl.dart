import 'package:pomodoro/domain/repositories/save_data_repository.dart';
import 'package:pomodoro/infrastructure/datasource/local_storage_datasource.dart';

class SaveDataRepositoryImpl extends SaveDataRepository {
  final LocalStorageDatasource datasource;

  SaveDataRepositoryImpl(this.datasource);

  @override
  Future<String?> getTimeLongBreak() {
    return datasource.getData('longBreak');
  }

  @override
  Future<String?> getTimePomodoro() async {
    return datasource.getData('pomodoro');
  }

  @override
  Future<String?> getTimeShortBreak() {
    return datasource.getData('shortBreak');
  }

  @override
  Future<void> saveTime(String key, String data) {
    return datasource.saveData(key, data);
  }
}
