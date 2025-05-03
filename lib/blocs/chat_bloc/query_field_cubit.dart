import 'package:flutter_bloc/flutter_bloc.dart';

class QueryFieldCubit extends Cubit<bool> {
  QueryFieldCubit() : super(true);

  canSendMessage({required bool canSend}) {
    emit(canSend);
  }
}
