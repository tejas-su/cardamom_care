import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/classify_model.dart';
import '../../repository/helper_repository.dart';
part 'classify_event.dart';
part 'classify_state.dart';

class ClassifyBloc extends Bloc<ClassifyEvent, ClassifyState> {
  final HelperRepository helperRepository;
  ClassifyBloc({required this.helperRepository}) : super(ClassifyInitial()) {
    on<OnTakePhotoEvent>((event, emit) async {
      try {
        ClassifyModel output = await helperRepository.pickImage();
        emit(ClassifiedState(classifyModel: output));
      } catch (e) {
        emit(Errorstate(errormessage: e.toString()));
      }
    });

    on<OnSelectPhotoEvent>(
      (event, emit) async {
        try {
          ClassifyModel output = await helperRepository.pickGalleryImage();
          emit(ClassifiedState(classifyModel: output));
        } catch (e) {
          emit(Errorstate(errormessage: e.toString()));
        }
      },
    );
  }
}
