import 'package:chat_app/core/constants.dart';
import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/presentation/chat/cubit/chat_cubit.dart';
import 'package:chat_app/presentation/chat/widgets/chat_buble.dart';
import 'package:chat_app/presentation/chat/widgets/message_Input_field.dart';
import 'package:chat_app/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  final _controller = ScrollController();
  TextEditingController controller = TextEditingController();

  ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    List<Message> messagesList = [];
    String email = ModalRoute.of(context)!.settings.arguments.toString();
    BlocProvider.of<ChatCubit>(context).getMessages();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            Text('chat'),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  messagesList = state.messagesList;
                } else if (state is ChatFailure) {
                  errorSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                return state is ChatSuccess ? ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? ChatBuble(
                            message: messagesList[index],
                          )
                        : ChatBubleForFriend(message: messagesList[index]);
                  },
                ) : state is ChatLoading ?
                    Center(child: CircularProgressIndicator(),):
                    Center(child: Text('no messages'),);
              },
            ),
          ),
          MessageInputField(controller: controller, onSend: (){
            BlocProvider.of<ChatCubit>(context).sendMessage(text: controller.text, email: email);

            controller.clear();
            _controller.animateTo(0,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn);
          }),
        ],
      ),
    );
  }
}
