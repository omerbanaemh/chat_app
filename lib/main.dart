import 'package:chat_app/core/firebase_options.dart';
import 'package:chat_app/core/ob_Server/bloc_observer.dart';
import 'package:chat_app/data/services/auth_service.dart';
import 'package:chat_app/data/services/message_service.dart';
import 'package:chat_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:chat_app/presentation/auth/pages/login_page.dart';
import 'package:chat_app/presentation/auth/pages/register_page.dart';
import 'package:chat_app/presentation/chat/cubit/chat_cubit.dart';
import 'package:chat_app/presentation/chat/pages/chat_page.dart';
import 'package:chat_app/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async  {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(AuthService()),
        ),
        BlocProvider(
          create: (context) => ChatCubit(MessageService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      routes: {
       Routes.loginPage: (context) => LoginPage(),
       Routes.registerPage: (context) => RegisterPage(),
       Routes.chatPage : (context) =>  ChatPage()
      },
      initialRoute: Routes.loginPage,
    ),
    );
  }
}
