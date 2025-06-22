import 'package:chat_app/core/constants.dart';
import 'package:chat_app/data/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  Stream<List<Message>> getMessages() {
    return messages.orderBy(kCreatedAt, descending: true).snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Message.fromJson(doc)).toList());
  }

  Future<void> sendMessage(
      {required String text, required String email}) async {
    await messages.add({
      kMessage: text,
      kCreatedAt: DateTime.now(),
      'id': email,
    });
  }
}
