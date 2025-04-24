part of 'classify_bloc.dart';

sealed class ClassifyState extends Equatable {
  const ClassifyState();

  @override
  List<Object> get props => [];
}

final class ClassifyInitialState extends ClassifyState {}

final class ClassifyingState extends ClassifyState {}

final class ClassifiedState extends ClassifyState {
  final ClassifyModel classifyModel;

  const ClassifiedState({required this.classifyModel});

  @override
  List<Object> get props => [classifyModel];
}

final class ErrorState extends ClassifyState {
  final String errormessage;

  const ErrorState({required this.errormessage});

  @override
  List<Object> get props => [errormessage];
}
