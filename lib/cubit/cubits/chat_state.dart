part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}
final class ChatSucces extends ChatState {

  List<Message>messages;
  ChatSucces(this.messages);
}