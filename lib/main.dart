import 'package:chat_app/core/firebase_options.dart';
import 'package:chat_app/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/presentation/chat/pages/chat_page.dart';
import 'package:chat_app/presentation/auth/pages/login_page.dart';
import 'package:chat_app/presentation/auth/pages/resgister_page.dart';


void main() async  {
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
    return MaterialApp(
      routes: {
       Routes.loginPage: (context) => const LoginPage(),
       Routes.registerPage: (context) => const RegisterPage(),
       Routes.chatPage : (context) => ChatPage()
      },
      initialRoute: Routes.loginPage,
    );
  }
}
