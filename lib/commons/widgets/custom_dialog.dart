import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String name;
  const CustomDialog({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 12,
      child: SizedBox(
        height: 100,
        child: Center(
          child: Text(
              "$name WIN", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
      ),
    );
  }
}
