import 'package:bloc/bloc.dart';
import 'package:chat_app/core/constants.dart';
import 'package:chat_app/data/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  void getMessages() {
    emit(ChatLoading());
    try {
      messages
          .orderBy(kCreatedAt, descending: true)
          .snapshots()
          .listen((snapshot) {
        List<Message> messagesList =
            snapshot.docs.map((doc) => Message.fromJson(doc)).toList();
        emit(ChatSuccess(messagesList: messagesList));
      });
    } catch (e) {
      emit(ChatFailure(message: 'Failed to load messages'));
    }
  }

  Future<void> sendMessage(
      {required String text, required String email}) async {
    try {
      await messages.add({
        kMessage: text,
        kCreatedAt: DateTime.now(),
        'id': email,
      });
    } catch (e) {
      emit(ChatFailure(message: 'Failed to send message'));
    }
  }
}
