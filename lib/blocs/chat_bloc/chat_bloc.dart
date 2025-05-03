import 'package:cardamom_care/models/chat_model.dart';
import 'package:cardamom_care/repository/dio_service.dart';
import 'package:cardamom_care/repository/hive_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  HiveService hiveService;
  ChatBloc({required this.hiveService}) : super(ChatLoadingState()) {
    on<OnLoadChatsEvent>(
      (event, emit) {
        try {
          List<ChatModel> chats = hiveService.getChats();

          emit(ChatLoadedState(chats: chats, isRecieving: false));
        } catch (e) {
          emit(ChatErrorState(errorMessage: e.toString()));
        }
      },
    );

    //Send query to the server and save it in the local db
    on<OnSendQueryEvent>((event, emit) async {
      ChatModel chatUser = ChatModel(query: event.query, sender: 'user');

      await hiveService.isertIntoBox(chat: chatUser);

      emit(ChatLoadedState(chats: hiveService.getChats(), isRecieving: true));

      String response = await DioService().sendQuery(query: event.query);

      ChatModel chatAssistant =
          ChatModel(response: response, sender: 'assistant');

      await hiveService.isertIntoBox(chat: chatAssistant);

      emit(ChatLoadedState(chats: hiveService.getChats(), isRecieving: false));
    });

    //delete all chats in the box
    on<OnDeleteAllChatsEvent>(
      (event, emit) async {
        List<ChatModel> chats = await hiveService.deleteAllMessages();
        emit(ChatLoadedState(chats: chats, isRecieving: false));
      },
    );
  }
}
