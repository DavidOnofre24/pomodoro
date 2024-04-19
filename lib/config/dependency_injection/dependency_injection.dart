import 'package:get_it/get_it.dart';
import 'package:pomodoro/domain/repositories/save_data_repository.dart';
import 'package:pomodoro/domain/repositories/statistics_repository.dart';
import 'package:pomodoro/domain/use_cases/get_statistics_use_case.dart';
import 'package:pomodoro/infrastructure/datasource/local_storage_datasource.dart';
import 'package:pomodoro/infrastructure/repositories/save_data_repository_impl.dart';
import 'package:pomodoro/infrastructure/repositories/statistics_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  await getIt.reset();
  final sharedPreferences = await SharedPreferences.getInstance();
  registerDataSources(sharedPreferences);
  registerRepositories();
  registerUseCases();
}

void registerDataSources(SharedPreferences sharedPreferences) {
  getIt.registerSingleton<LocalStorageDatasource>(
    LocalStorageDatasource(
      sharedPreferences,
    ),
  );
}

void registerRepositories() {
  getIt.registerSingleton<SaveDataRepository>(
    SaveDataRepositoryImpl(
      getIt(),
    ),
  );

  getIt.registerSingleton<StatisticsRepository>(
    StatisticsRepositoryImpl(
      datasource: getIt(),
    ),
  );
}

void registerUseCases() {
  getIt.registerSingleton<GetStatisticsUseCase>(
    GetStatisticsUseCase(
      getIt(),
    ),
  );
}
