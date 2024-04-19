import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pomodoro/domain/entities/statistic.dart';
import 'package:pomodoro/domain/use_cases/get_statistics_use_case.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final GetStatisticsUseCase getStatisticsUseCase;
  StatisticsCubit({required this.getStatisticsUseCase})
      : super(const StatisticsState(statistics: []));

  void init() async {
    final statistics = await getStatisticsUseCase.call();
    emit(StatisticsState(statistics: statistics));
  }
}
