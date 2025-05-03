part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

final class ChatLoadingState extends ChatState {}

final class ChatLoadedState extends ChatState {
  final List<ChatModel> chats;
  final bool isRecieving;

  const ChatLoadedState({required this.chats, required this.isRecieving});

  @override
  List<Object?> get props => [chats];
}

final class ChatErrorState extends ChatState {
  final String errorMessage;

  const ChatErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
