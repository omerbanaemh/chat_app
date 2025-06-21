import 'package:chat_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:chat_app/presentation/auth/widgets/custom_auth_form.dart';
import 'package:chat_app/presentation/auth/widgets/scholar_header.dart';
import 'package:chat_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:chat_app/core/constants.dart';
import 'package:chat_app/utils/show_snack_bar.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          successSnackBar(context, 'Welcome  ${state.email}');
          Navigator.pushNamed(context, Routes.chatPage, arguments: state.email);
        } else if (state is AuthFailure) {
          errorSnackBar(context, state.message);
        }
      },
      child: BlocSelector<AuthCubit, AuthState, bool>(
        selector: (state) {
          return state is AuthLoading;
        },
        builder: (context, isLoading) {
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Scaffold(
              backgroundColor: kPrimaryColor,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 75,
                    ),
                    const ScholarHeader(),
                    const SizedBox(
                      height: 75,
                    ),
                    const Row(
                      children: [
                        Text(
                          'LOGIN',
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
                    CustomAuthForm(
                      formKey: _formKey,
                      buttonText: 'LOGIN',
                      onSubmit: (email, password) {
                        context
                            .read<AuthCubit>()
                            .loginUser(email: email, password: password);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "dont't have an account?",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.registerPage);
                          },
                          child: const Text(
                            '  Register',
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
          );
        },
      ),
    );
  }
}
