import 'package:cardamom_care/repository/helper_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/classify_model.dart';
part 'live_analysis_event.dart';
part 'live_analysis_state.dart';

class LiveAnalysisBloc extends Bloc<LiveAnalysisEvent, LiveAnalysisState> {
  final HelperRepository helperRepository;
  LiveAnalysisBloc({required this.helperRepository})
      : super(LiveAnalysisInitial()) {
    on<LiveAnalysisEvent>((event, emit) async {
      emit(ClassifyingState());
      try {
        if (event.imagePath == null) {
          return;
        } else {
          ClassifyModel output = await helperRepository
              .liveImageClassification(event.imagePath.toString());
          emit(ClassifiedState(classifyModel: output));
        }
      } catch (e) {
        emit(ClassificationErrorState(errorMessage: e.toString()));
      }
    });
  }
}
