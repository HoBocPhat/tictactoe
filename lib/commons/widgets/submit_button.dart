import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget {
  final String label;
  final Function() submit;
  const SubmitButton({Key? key, required this.label, required this.submit}) : super(key: key);

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: Colors.green,
        onPressed: (){
          widget.submit();
        }
        , child: Text(widget.label, style: TextStyle(color: Colors.white)));
  }
}


