import 'package:chat_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:chat_app/presentation/auth/widgets/custom_button.dart';
import 'package:chat_app/presentation/auth/widgets/custom_text_field.dart';
import 'package:chat_app/utils/routes.dart';
import 'package:chat_app/utils/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:chat_app/core/constants.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          successSnackBar(context, 'Welcome  ${state.email}');
          Navigator.pushNamed(context, Routes.chatPage, arguments: state.email);
        } else if (state is AuthFailure) {
          errorSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            AuthCubit cubit = context.read<AuthCubit>();
            return ModalProgressHUD(
              inAsyncCall: state is AuthLoading,
              child: Scaffold(
                backgroundColor: kPrimaryColor,
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Form(
                    key: formKey,
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 75,
                        ),
                        Image.asset(
                          'assets/images/scholar.png',
                          height: 100,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Scholar Chat',
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontFamily: 'pacifico',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 75,
                        ),
                        const Row(
                          children: [
                            Text(
                              'REGISTER',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomFormTextField(
                          controlle: emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomFormTextField(
                          controlle: passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButon(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              cubit.register(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          text: 'REGISTER',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'already have an account?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                '  Login',
                                style: TextStyle(
                                  color: Color(0xffC7EDE6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
    print(user);
  }
}
