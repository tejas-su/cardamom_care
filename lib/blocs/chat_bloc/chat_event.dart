part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

final class OnLoadChatsEvent extends ChatEvent {}

final class OnDeleteAllChatsEvent extends ChatEvent {}

final class OnSendQueryEvent extends ChatEvent {
  final String query;

  const OnSendQueryEvent({required this.query});

  @override
  List<Object> get props => [query];
}
