import 'package:chat_app/core/constants.dart';
import 'package:chat_app/presentation/chat/cubit/chat_cubit.dart';
import 'package:chat_app/presentation/chat/widgets/chat_buble.dart';
import 'package:chat_app/presentation/chat/widgets/message_Input_field.dart';
import 'package:chat_app/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = ScrollController();
  TextEditingController controller = TextEditingController();
  String? email;

  @override
  void dispose() {
    _controller.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)!.settings.arguments.toString();
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
            const Text('chat'),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              buildWhen: (previous, current) {
                return current is ChatSuccess || current is ChatLoading;
              },
              listener: (context, state) {
                if (state is ChatFailure) {
                  errorSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                return state is ChatSuccess
                    ? ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: state.messagesList.length,
                        itemBuilder: (context, index) {
                          return state.messagesList[index].id == email
                              ? ChatBuble(
                                  message: state.messagesList[index],
                                )
                              : ChatBubleForFriend(
                                  message: state.messagesList[index]);
                        },
                      )
                    : state is ChatLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Center(
                            child: Text('no messages'),
                          );
              },
            ),
          ),
          MessageInputField(
              controller: controller,
              onSend: () {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(text: controller.text, email: email??'');

                controller.clear();
                _controller.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              }),
        ],
      ),
    );
  }
}
