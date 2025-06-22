import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CustomFormBuilderTextField extends StatelessWidget {
  const CustomFormBuilderTextField({
    super.key,
    required this.name,
    this.obscureText = false,
  });

  final String name;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: name,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),

      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Field is required'),
        if (name == 'Email')
          FormBuilderValidators.email(errorText: 'Invalid email format'),
        if (name == 'Password')
          FormBuilderValidators.minLength(6,
              errorText: 'Password must be at least 6 characters'),
      ]),
    );
  }
}
