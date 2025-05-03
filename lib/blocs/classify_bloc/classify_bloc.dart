import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/classify_model.dart';
import '../../repository/helper_repository.dart';
part 'classify_event.dart';
part 'classify_state.dart';

class ClassifyBloc extends Bloc<ClassifyEvent, ClassifyState> {
  final HelperRepository helperRepository;
  ClassifyBloc({required this.helperRepository})
      : super(ClassifyInitialState()) {
    on<OnRefreshEvent>((event, emit) async {
      emit(ClassifyInitialState());
    });

    on<OnSelectPhotoEvent>(
      (event, emit) async {
        try {
          ClassifyModel output = await helperRepository.pickGalleryImage();
          emit(ClassifiedState(classifyModel: output));
        } catch (e) {
          emit(ErrorState(errormessage: e.toString()));
        }
      },
    );
  }

  @override
  Future<void> close() {
    helperRepository.closeModel();
    return super.close();
  }
}
