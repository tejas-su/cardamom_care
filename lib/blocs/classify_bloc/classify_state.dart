part of 'classify_bloc.dart';

abstract class ClassifyState extends Equatable {
  const ClassifyState();

  @override
  List<Object> get props => [];
}

class ClassifyInitial extends ClassifyState {}

class ClassifyingState extends ClassifyState {}

class ClassifiedState extends ClassifyState {
  final ClassifyModel classifyModel;

  const ClassifiedState({required this.classifyModel});

  @override
  List<Object> get props => [classifyModel];
}

class Errorstate extends ClassifyState {
  final String errormessage;

  const Errorstate({required this.errormessage});

  @override
  List<Object> get props => [errormessage];
}
