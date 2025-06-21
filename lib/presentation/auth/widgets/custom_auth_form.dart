import 'package:chat_app/presentation/auth/widgets/custom_button.dart';
import 'package:chat_app/presentation/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomAuthForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final String buttonText;
  final void Function(String email, String password) onSubmit;

  const CustomAuthForm({super.key, required this.formKey, required this.buttonText, required this.onSubmit });

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          const CustomFormBuilderTextField(
            name: 'Email',
          ),
          const SizedBox(
            height: 10,
          ),
          const CustomFormBuilderTextField(
            name: 'Password',
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            onTap: () {
              if (formKey.currentState?.saveAndValidate() ?? false) {
                final email = formKey.currentState!.value['Email'];
                final password = formKey.currentState!.value['Password'];
                onSubmit(email, password);
              }
            },
            text: buttonText,
          ),
        ],
      ),
    );
  }
}
