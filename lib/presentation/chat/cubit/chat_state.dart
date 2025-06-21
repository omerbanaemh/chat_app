part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}
final class ChatLoading extends ChatState{}
final class ChatSuccess extends ChatState{
  final List<Message> messagesList;
  ChatSuccess({required this.messagesList});
}
final class ChatFailure extends ChatState {
  final String message;
  ChatFailure({required this.message});
}