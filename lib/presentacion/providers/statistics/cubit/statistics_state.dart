part of 'statistics_cubit.dart';

class StatisticsState extends Equatable {
  final List<Statistic> statistics;

  const StatisticsState({required this.statistics});

  @override
  List<Object> get props => [
        statistics,
      ];

  static StatisticsState initial() {
    return const StatisticsState(
      statistics: [],
    );
  }
}
