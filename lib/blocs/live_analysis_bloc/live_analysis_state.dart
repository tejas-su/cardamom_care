part of 'live_analysis_bloc.dart';

sealed class LiveAnalysisState extends Equatable {
  const LiveAnalysisState();

  @override
  List<Object> get props => [];
}

final class LiveAnalysisInitial extends LiveAnalysisState {}

final class ClassifyingState extends LiveAnalysisState {}

final class ClassifiedState extends LiveAnalysisState {
  final ClassifyModel classifyModel;
  const ClassifiedState({required this.classifyModel});

  @override
  List<Object> get props => [classifyModel];
}

final class ClassificationErrorState extends LiveAnalysisState {
  final String errorMessage;
  const ClassificationErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
