part of 'classify_bloc.dart';

abstract class ClassifyEvent extends Equatable {
  const ClassifyEvent();

  @override
  List<Object> get props => [];
}

class OnSelectPhotoEvent extends ClassifyEvent {}

class OnRefreshEvent extends ClassifyEvent {}
