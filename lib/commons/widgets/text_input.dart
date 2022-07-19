import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  const TextInput({Key? key, required this.labelText, required this.controller}) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: Colors.green,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Colors.green),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.green
            )
        ),
      ),

    );
  }
}
