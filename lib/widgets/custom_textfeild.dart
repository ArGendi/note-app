import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final Function(String?) onSaved;
  final String? Function(String?) validator;
  final TextInputType type;
  final bool isPassword;
  const CustomTextField({super.key, required this.text, required this.onSaved, required this.validator, this.type = TextInputType.text, this.isPassword = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: widget.onSaved,
      validator: widget.validator,
      keyboardType: widget.type,
      obscureText: widget.isPassword,
      decoration: InputDecoration(
        labelText: widget.text,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 2, color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 2, color: Colors.red),
        ),
      ),
    );
  }
}