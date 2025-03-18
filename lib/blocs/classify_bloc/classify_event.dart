part of 'classify_bloc.dart';

abstract class ClassifyEvent extends Equatable {
  const ClassifyEvent();

  @override
  List<Object> get props => [];
}

class OnTakePhotoEvent extends ClassifyEvent {}

class OnSelectPhotoEvent extends ClassifyEvent {}
