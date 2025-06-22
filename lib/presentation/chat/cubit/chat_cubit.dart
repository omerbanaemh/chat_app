import 'package:bloc/bloc.dart';
import 'package:chat_app/core/constants.dart';
import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/data/services/message_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  MessageService messageService;
  ChatCubit(this.messageService) : super(ChatInitial());

  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  void getMessages() {
    emit(ChatLoading());
    try {
     messageService.getMessages().listen((messagesList) {
        emit(ChatSuccess(messagesList: messagesList));
      });
    } catch (e) {
      emit(ChatFailure(message: 'Failed to load messages'));
    }
  }

  Future<void> sendMessage({required String text, required String email}) async {
    try {
      await messageService.sendMessage(text: text, email: email);
    } catch (e) {
      emit(ChatFailure(message: 'Failed to send message'));
    }
  }
}
